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
  [cmd & args]
  (cmd-fix (apply sh "cmd.exe" "/c" cmd args)))

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
  [cmd & args]
  (cmd-print (apply cmd! cmd args)))

(alias! ! cmd)
(alias! !! cmd!)
