(ns dragon.clipboard.osx
  (:refer-clojure)
  (:require [clojure.java.shell :refer [sh]]))

(defn copy
  [data]
  (sh "pbcopy" :in data)
  nil)

(defn paste
  []
  (:out (sh "pbpaste")))
