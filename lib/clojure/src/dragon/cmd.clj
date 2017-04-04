(ns dragon.cmd
  (:refer-clojure)
  (:require [clojure.string :as str]
            [clojure.java.shell :refer [sh]]))

(defmulti ^:private fix-arg type)

(defmethod fix-arg clojure.lang.Keyword
  [v]
  (str \/ (name v)))

(defmethod fix-arg :default
  [v]
  (str v))

(defn- parse-3
  [d [a & bs] & more]
  (cons
   (cons
    (if (= '($) d)
      (str (eval a))
      (fix-arg a))
    (map fix-arg bs))
   (when-not (empty? more)
     (apply parse-3 more))))

(defn- parse-2
  [& args]
  (if-not (#{() '($)} (first args))
    (apply parse-2 () args)
    (flatten (apply parse-3 args))))

(defn- parse-1
  ([args] (parse-1 args () ()))
  ([args _ opts]
   (concat (apply parse-2 (partition-by #{'$} args))
           (map eval opts))))

(defn- parse
  [& args]
  (apply parse-1 (partition-by #{'$$} args)))

(defn- fix-lines
  [s]
  (-> s
      (str \~)
      (str/split-lines)
      (->> (str/join \newline))
      (butlast)
      (str/join)))

(defn- fix-cmd
  [{:keys [exit out err]}]
  {:exit exit
   :out (fix-lines out)
   :err (fix-lines err)})

(defn cmd!
  [& args]
  (fix-cmd (apply sh "cmd.exe" "/c" (apply parse args))))

(defn- print-maybe
  [s]
  (if (string? s)
    (when-not (str/blank? s)
      (print s))
    (println s)))

(defn- print-cmd
  [{:keys [exit out err]}]
  (print-maybe out)
  (print-maybe err)
  exit)

(defn cmd
  [& args]
  (print-cmd (apply cmd! args)))

(defmacro !
  [& args]
  `(apply cmd '~args))

(defmacro !!
  [& args]
  `(apply cmd! '~args))
