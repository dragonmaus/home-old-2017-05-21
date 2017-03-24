(ns dragon.clipboard.awt
  (:import [java.awt Toolkit]
           [java.awt.datatransfer Clipboard DataFlavor StringSelection])
  (:refer-clojure))

(def ^:dynamic *clipboard* (.. Toolkit getDefaultToolkit getSystemClipboard))
(def ^:dynamic *data-flavor* DataFlavor/stringFlavor)

(defn copy
  [data]
  (as-> data d
    (str d)
    (StringSelection. d)
    (.setContents *clipboard* d nil)))

(defn paste
  []
  (let [data-flavor (or (first (.getAvailableDataFlavors *clipboard*))
                        *data-flavor*)]
    (when (.isDataFlavorAvailable *clipboard* data-flavor)
      (.getData *clipboard* data-flavor))))
