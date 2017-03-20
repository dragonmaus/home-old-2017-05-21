(ns dragon.core
  (:refer-clojure)
  (:require [clojure.string :as str]))

(defn latin
  "Onvertscay ethay inputay otay igpay atinlay."
  [s]
  (-> s
      (str/lower-case)
      (str/replace #"\b([bcdfghjklmnpqrstvwxz]*qu|y|[bcdfghjklmnpqrstvwxz]*)([aeiouy]\w*)\b" "$2$1ay")
      (str/capitalize)))

(defn ppmap
  "Partitioned parallel map.
  Groups pmap operations to decrease per-operation overhead"
  [grain-size f & colls]
  (apply concat
         (apply pmap
                (fn [& grains] (doall (apply map f grains)))
                (map (partial partition-all grain-size) colls))))
