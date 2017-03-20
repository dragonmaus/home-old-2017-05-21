(ns dragon.core
  (:refer-clojure))

(defn ppmap
  "Partitioned parallel map.
  Groups pmap operations to decrease per-operation overhead"
  [grain-size f & colls]
  (apply concat
         (apply pmap
                (fn [& grains] (doall (apply map f grains)))
                (map (partial partition-all grain-size) colls))))
