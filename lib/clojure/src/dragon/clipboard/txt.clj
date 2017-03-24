(ns dragon.clipboard.txt
  (:import [java.io File])
  (:refer-clojure)
  (:require [clojure.java.io :refer [as-file]]
            [dragon.core :refer [env]]))

(def ^:dynamic *clipboard*
  (as-file (or (env :clipboard)
               (str (env :user-home) "/.clipboard"))))

(defn copy
  [data]
  (spit *clipboard* data))

(defn paste
  []
  (slurp *clipboard*))
