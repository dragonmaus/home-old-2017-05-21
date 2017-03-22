(ns dragon.core
  (:refer-clojure)
  (:require [clojure.string :as str]))

(def ^:private ^:static pattern
  #"\A([BCDFGHJKLMNPQRSTVWXZbcdfghjklmnpqrstvwxz]*[Qq][Uu]|[Yy]|[BCDFGHJKLMNPQRSTVWXZbcdfghjklmnpqrstvwxz]*)([AEIOUYaeiouy]\w*)\z")

(defn- fix
  [s]
  (let [t (str/lower-case (str/join "-" (str/split s #"[^\p{Alnum}]+")))]
    (if (empty? t)
      :-
      (keyword t))))

(defn- fix-map
  [m]
  (->> m
       (filter (fn [[k v]] (not (str/includes? k "="))))
       (map (fn [[k v]] [(fix k) v]))
       (into {})))

(defn- get-case-fix
  [w]
  (some (fn [f] (when (= w (f w)) f))
        [str/capitalize str/upper-case identity]))

(defn- latin*
  [w]
  (if (re-seq #"[A-Za-z]" w)
    (let [fix-case (get-case-fix w)]
      (-> w
          (str/replace #"\A([AEIOUaeiou]|[Yy][BCDFGHJKLMNPQRSTVWXZbcdfghjklmnpqrstvwxz])" "w$1")
          (str/replace pattern "$2$1ay")
          (fix-case)))
    w))

(def env
  (merge (sorted-map)
         (fix-map (System/getenv))
         (fix-map (System/getProperties))))

(defn latin
  "Onvertscay ethay inputay otay Igpay Atinlay."
  [s]
  (-> s
      (str/split #"\b")
      (->> (map latin*))
      (str/join)))

(defn ppmap
  "Partitioned parallel map.
  Groups pmap operations to decrease per-operation overhead."
  [grain-size f & colls]
  (apply concat
         (apply pmap
                (fn [& grains] (doall (apply map f grains)))
                (map (partial partition-all grain-size) colls))))
