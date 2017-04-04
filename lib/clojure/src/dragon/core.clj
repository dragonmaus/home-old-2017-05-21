(ns dragon.core
  (:refer-clojure)
  (:require [clojure.string :as str]))

(defmacro alias!
  "Add an alias in the current namespace to another arbitrary symbol.
  The alias will be an exact copy of the target, including all metadata."
  [alias target]
  `(alter-meta! (def ~alias ~target) (fn [~'_] (meta #'~target))))

(defn kebab
  ":convert-the-input-to-a-hyphenated-lower-case-keyword"
  [value]
  (as-> value v
    (if (keyword? v)
      (apply str (rest (str v)))
      (str v))
    (str/lower-case v)
    (str/split v #"[^0-9a-z]+")
    (str/join \- v)
    (if (str/blank? v)
      "-"
      v)
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
  [s]
  (some (fn [f] (when (= s (f s)) f))
        [str/capitalize str/upper-case identity]))

(defn- latin*
  [s]
  (if (re-seq #"[A-Za-z]" s)
    (let [fix-case (get-case-fix s)]
      (-> s
          (str/replace #"\A([AEIOUaeiou]|[Yy][BCDFGHJKLMNPQRSTVWXZbcdfghjklmnpqrstvwxz])" "w$1")
          (str/replace #"\A([BCDFGHJKLMNPQRSTVWXZbcdfghjklmnpqrstvwxz]*[Qq][Uu]|[Yy]|[BCDFGHJKLMNPQRSTVWXZbcdfghjklmnpqrstvwxz]+)([AEIOUYaeiouy]\w*)\z" "$2$1ay")
          (fix-case)))
    s))

(defn latin
  "Onvertcay ethay inputway otay Igpay Atinlay."
  [s]
  (as-> s s
    (str/split s #"\b")
    (map latin* s)
    (str/join s)))

(defn ppmap
  "Partitioned parallel map.
  Groups pmap operations to decrease per-operation overhead."
  [n f & colls]
  (apply concat
         (apply pmap
                (fn [& grains] (doall (apply map f grains)))
                (map (partial partition-all n) colls))))

(def << clojure.lang.PersistentQueue/EMPTY)

(defmethod print-method clojure.lang.PersistentQueue
  [q w]
  (print-method '< w)
  (when-let [s (seq q)]
    (print-method s w))
  (print-method '< w))

(defn- wrap
  [x lo hi]
  (cond
   (> x hi) (wrap (+ (- x hi) (dec lo)) lo hi)
   (< x lo) (wrap (+ (- x lo) (inc hi)) lo hi)
   :else    x))

(defn- rot13*
  [c]
  (let [A (int \A)
        Z (int \Z)
        a (int \a)
        z (int \z)
        x (int c)]
    (cond
     (<= A x Z) (char (wrap (+ x 13) A Z))
     (<= a x z) (char (wrap (+ x 13) a z))
     :else      c)))

(defn rot13
  "EBG13-rapbqrf gur vachg."
  [s]
  (apply str (map rot13* s)))
