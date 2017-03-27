(ns dragon.clipboard.osx
  (:refer-clojure)
  (:require (clojure.java [shell :as shell])))

(defn copy
  [data]
  (shell/sh "pbcopy" :in data)
  nil)

(defn paste
  []
  ((shell/sh "pbpaste") :out))
