(ns dragon.clipboard
  (:refer-clojure)
  (:require [clojure.java.shell :as shell]))

(defn copy
  [data]
  (= 0 (:exit (shell/sh "pbcopy" :in data))))

(defn paste
  []
  (:out (shell/sh "pbpaste")))

(defn clear
  []
  (copy ""))
