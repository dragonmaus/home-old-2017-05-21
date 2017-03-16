(ns dragon.clipboard
  (:refer-clojure))

(declare copy)

(defn clear
  []
  (copy nil))

(case (System/getProperty "os.name")
  "Windows" ; FIXME: Not sure what actually goes here
  (require '[dragon.clipboard.awt :as internal])
  "Mac OS X"
  (require '[dragon.clipboard.osx :as internal])
  ; default
  (require '[dragon.clipboard.txt :as internal]))

(def copy internal/copy)

(def paste internal/paste)
