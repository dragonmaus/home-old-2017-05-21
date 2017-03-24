(ns dragon.core
  (:refer-clojure)
  (:require [clojure.string :as str]))

(defn- get-case-fix
  [word]
  (some (fn [f] (when (= word (f word)) f))
        [str/capitalize str/upper-case identity]))

(defn kebab
  [string]
  (as-> string s
    (try
      (name s)
      (catch Exception _
        (str s)))
    (str/split s #"[^\p{Alnum}]+")
    (str/join "-" s)
    (if (str/blank? s) "-" s)
    (str/lower-case s)
    (keyword s)))

(defn- keybab
  [coll]
  (->> coll
       (filter (fn [[k v]] (not (str/includes? k "="))))
       (map (fn [[k v]] [(kebab k) v]))
       (into {})))

(defn- latin*
  [word]
  (if (re-seq #"[A-Za-z]" word)
    (let [fix-case (get-case-fix word)]
      (-> word
          (str/replace #"\A([AEIOUaeiou]|[Yy][BCDFGHJKLMNPQRSTVWXZbcdfghjklmnpqrstvwxz])" "w$1")
          (str/replace #"\A([BCDFGHJKLMNPQRSTVWXZbcdfghjklmnpqrstvwxz]*[Qq][Uu]|[Yy]|[BCDFGHJKLMNPQRSTVWXZbcdfghjklmnpqrstvwxz]+)([AEIOUYaeiouy]\w*)\z" "$2$1ay")
          (fix-case)))
    word))

(def env
  (merge (sorted-map)
         (keybab (System/getenv))
         (keybab (System/getProperties))))

(defn latin
  "Onvertscay ethay inputay otay Igpay Atinlay."
  [string]
  (as-> string s
    (str/split s #"\b")
    (map latin* s)
    (str/join s)))

(defn ppmap
  "Partitioned parallel map.
  Groups pmap operations to decrease per-operation overhead."
  [grain-size f & colls]
  (apply concat
         (apply pmap
                (fn [& grains] (doall (apply map f grains)))
                (map (partial partition-all grain-size) colls))))
