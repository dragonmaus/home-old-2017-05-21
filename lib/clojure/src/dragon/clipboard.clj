(ns dragon.clipboard
  (:refer-clojure)
  (:require (clojure [string :as str])
            (dragon [core :refer [alias! env]])))

(declare copy)

(defn clear
  []
  (copy nil))

(case (first (str/split (env :os-name) #"\s+"))
  "Windows"
  (require '(dragon.clipboard [awt :as internal]))
  "Mac"
  (require '(dragon.clipboard [osx :as internal]))
  ;default
  (require '(dragon.clipboard [txt :as internal])))

(alias! copy internal/copy)
(alias! paste internal/paste)
