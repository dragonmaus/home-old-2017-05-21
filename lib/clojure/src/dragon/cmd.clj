(ns dragon.cmd
  (:refer-clojure)
  (:require (clojure [string :as str])
            (clojure.java [shell :refer [sh]])
            (dragon [core :refer [alias!]])))

(defmulti ^:private cmd-fix*
  (fn [data] (class data)))

(defmethod cmd-fix* :default
  [b]
  b)

(defmethod cmd-fix* java.lang.String
  [string]
  (as-> string s
    (str s \~)
    (str/split-lines s)
    (str/join \newline s)
    (butlast s)
    (str/join s)))

(defn- cmd-fix
  [{:keys [exit out err]}]
  {:exit exit
   :out (cmd-fix* out)
   :err (cmd-fix* err)})

(defn cmd!
  [& args]
  (cmd-fix (apply sh "cmd.exe" "/c" args)))

(defn- print-maybe
  [s]
  (if (string? s)
    (when (not (str/blank? s))
      (print s))
    (println s)))

(defn- cmd-print
  [{:keys [exit out err]}]
  (print-maybe out)
  (print-maybe err)
  exit)

(defn cmd
  [& args]
  (cmd-print (apply cmd! args)))

(defn arg-parser
  [coll args]
  (if (empty? args)
    coll
    (let [arg (first args)
          args (rest args)]
      (case arg
        $
        (recur (concat coll [(str (eval (first args)))])
               (rest args))
        $$
        (recur (concat coll (map eval args))
               ())
        ;default
        (recur (concat coll [(if (keyword? arg)
                               (apply str (cons \/ (rest (str arg))))
                               (str arg))])
               args)))))

(defmacro !
  [& args]
  `(apply cmd (arg-parser () '~args)))

(defmacro !!
  [& args]
  `(apply cmd! (arg-parser () '~args)))
