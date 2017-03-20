(ns dragon.clipboard.txt
  (:import [java.io File])
  (:refer-clojure))

(def ^:dynamic *clipboard* (File. (str (System/getProperty "user.home")
                                       "/.clipboard")))

(defn copy
  [data]
  (spit *clipboard* data))

(defn paste
  []
  (slurp *clipboard*))
