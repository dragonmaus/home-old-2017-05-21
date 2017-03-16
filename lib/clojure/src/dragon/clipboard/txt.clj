(ns dragon.clipboard.txt
  (:refer-clojure)
  (:require [clojure.java.shell :as shell]))

(def ^:dynamic *clipboard-path* (str (System/getenv "HOME") "/.clipboard"))

(defn copy
  [data]
  (spit *clipboard-path* data))

(defn paste
  []
  (slurp *clipboard-path*))
