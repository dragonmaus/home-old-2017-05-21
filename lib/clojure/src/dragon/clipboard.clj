(ns dragon.clipboard
  (:refer-clojure)
  (:require [clojure.string :as str]
            [dragon.core :refer [env]]))

(declare copy)

(defn clear
  []
  (copy nil))

(case (first (str/split (env :os-name) #"\s+"))
  "Windows"
  (require '[dragon.clipboard.awt :as internal])
  "Mac"
  (require '[dragon.clipboard.osx :as internal])
  ;default
  (require '[dragon.clipboard.txt :as internal]))

(def copy internal/copy)

(def paste internal/paste)
