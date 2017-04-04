(ns dragon.clipboard.awt
  (:import [java.awt Toolkit]
           [java.awt.datatransfer DataFlavor StringSelection])
  (:refer-clojure))

(def ^:dynamic *clipboard* (.. Toolkit getDefaultToolkit getSystemClipboard))
(def ^:dynamic *data-flavor* nil)

(defn copy
  [data]
  (as-> data d
    (str d)
    (StringSelection. d)
    (.setContents *clipboard* d nil)))

(defn paste
  []
  (let [data-flavor (or *data-flavor*
                        (first (.getAvailableDataFlavors *clipboard*))
                        DataFlavor/stringFlavor)]
    (when (.isDataFlavorAvailable *clipboard* data-flavor)
      (.getData *clipboard* data-flavor))))
