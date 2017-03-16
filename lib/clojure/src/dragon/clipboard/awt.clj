(ns dragon.clipboard.awt
  (:import [java.awt Toolkit]
           [java.awt.datatransfer Clipboard DataFlavor StringSelection])
  (:refer-clojure))

(def ^:dynamic *clipboard* (.. Toolkit getDefaultToolkit getSystemClipboard))
(def ^:dynamic *data-flavor* DataFlavor/stringFlavor)

(defn copy
  [data]
  (let [s (StringSelection. (str data))]
    (.setContents *clipboard* s nil)))

(defn paste
  []
  (if (.isDataFlavorAvailable *clipboard* *data-flavor*)
    (.getData *clipboard* *data-flavor*)
    ""))
