(ns dragon.clipboard.txt
  (:refer-clojure)
  (:require [clojure.java.io :refer [file]]
            [dragon.core :refer [getenv getprop]]))

(def ^:dynamic *clipboard*
  (let [path (getenv "CLIPBOARD")
        path (or (and path (file path))
                 (file (getprop "user.home") ".clipboard"))]
    path))

(defn copy
  [data]
  (spit *clipboard* data))

(defn paste
  []
  (slurp *clipboard*))
