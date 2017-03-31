(ns dragon.cmd
  (:refer-clojure)
  (:require (clojure [string :as str])
            (clojure.java [shell :refer [sh]])))

(defn- fix-keywords
  [x]
  (if (keyword? x)
    (str \/ (name x))
    x))

(defn- read-cmd-3
  [[_ [x & y] & more]]
  (cons
    (cons
      (eval x)
      (map fix-keywords y))
    (when (not (empty? more))
      (apply read-cmd-3 more))))

(defn- read-cmd-2
  [[args & more]]
  (if (= '$ (first args))
    (read-cmd-2 (cons () (cons args more)))
    (map str (apply concat (map fix-keywords args) (read-cmd-3 more)))))

(defn- read-cmd-1
  [[args _ opts]]
  (concat (read-cmd-2 (partition-by #{'$} args))
          (map eval opts)))

(defn- read-cmd
  [[& args]]
  (read-cmd-1 (partition-by #{'$$} args)))

(defn- fix-lines
  [s]
  (->> s
       (#(str % \~))
       (str/split-lines)
       (str/join \newline)
       (butlast)
       (str/join)))

(defn- cmd-fix
  [{:keys [exit out err]}]
  {:exit exit
   :out (fix-lines out)
   :err (fix-lines err)})

(defn cmd!
  [& args]
  (cmd-fix (apply sh "cmd.exe" "/c" (read-cmd args))))

(defn- maybe-print
  [s]
  (if (string? s)
    (when (not (str/blank? s))
      (print s))
    (println s)))

(defn- cmd-print
  [{:keys [exit out err]}]
  (maybe-print out)
  (maybe-print err)
  exit)

(defn cmd
  [& args]
  (cmd-print (apply cmd! args)))

(defmacro !!
  [& args]
  `(apply cmd! '~args))

(defmacro !
  [& args]
  `(apply cmd '~args))
