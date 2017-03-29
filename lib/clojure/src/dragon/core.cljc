(ns dragon.core
  (:refer-clojure)
  (:require (clojure [string :as str])))

(defmacro alias!
  "Add an alias in the current namespace to another
  arbitrary symbol. The alias will be an exact copy
  of the target, including all metadata."
  [alias target]
  `(alter-meta! (def ~alias ~target) (fn [~'_] (meta #'~target))))

(defn kebab
  ":converts-the-input-to-a-hyphenated-lower-case-keyword"
  [value]
  (as-> value v
    (if (keyword? v) (apply str (rest (str v))) (str v))
    ;(if (instance? clojure.lang.Named v) (name v) (str v))
    (str/split v #"[^\p{Alnum}]+")
    (str/join "-" v)
    (if (str/blank? v) "-" v)
    (str/lower-case v)
    (keyword v)))

(defn- keybab
  [coll]
  (into {}
        (comp
          (filter (fn [[k v]] (not (str/includes? k "="))))
          (map (fn [[k v]] [(kebab k) v])))
        coll))

(def env
  (merge (sorted-map)
         (keybab (System/getenv))
         (keybab (System/getProperties))))

(defn- get-case-fix
  [word]
  (some (fn [f] (when (= word (f word)) f))
        [str/capitalize str/upper-case identity]))

(defn- latin*
  [word]
  (if (re-seq #"[A-Za-z]" word)
    (let [fix-case (get-case-fix word)]
      (-> word
          (str/replace #"\A([AEIOUaeiou]|[Yy][BCDFGHJKLMNPQRSTVWXZbcdfghjklmnpqrstvwxz])" "w$1")
          (str/replace #"\A([BCDFGHJKLMNPQRSTVWXZbcdfghjklmnpqrstvwxz]*[Qq][Uu]|[Yy]|[BCDFGHJKLMNPQRSTVWXZbcdfghjklmnpqrstvwxz]+)([AEIOUYaeiouy]\w*)\z" "$2$1ay")
          (fix-case)))
    word))

(defn latin
  "Onvertscay ethay intputway otay Igpay Atinlay."
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
