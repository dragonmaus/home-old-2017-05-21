(ns dragon.clipboard.txt
  (:refer-clojure)
  (:require [clojure.java.io :refer [as-file]]
            [dragon.core :refer [env]])
  (:import java.io.File))

(def ^:dynamic *clipboard*
  (as-file (or (env :clipboard)
               (str (env :user-home) "/.clipboard"))))

(defn copy
  [data]
  (spit *clipboard* data))

(defn paste
  []
  (slurp *clipboard*))
