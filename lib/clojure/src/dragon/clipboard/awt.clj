(ns dragon.clipboard.awt
  (:refer-clojure)
  (:import java.awt.Toolkit
           [java.awt.datatransfer DataFlavor
                                  StringSelection]))

(def ^:dynamic *clipboard* (.getSystemClipboard (Toolkit/getDefaultToolkit)))

(def ^:dynamic *data-flavor* nil)

(defmacro with-string-flavor
  [& body]
  `(let [df# DataFlavor/stringFlavor]
     (binding [*data-flavor* df#]
       ~@body)))

(defn copy
  [data]
  (as-> data d
    (str d)
    (StringSelection. d)
    (.setContents *clipboard* d nil)))

(defn paste
  []
  (let [f (or *data-flavor*
              (first (.getAvailableDataFlavors *clipboard*))
              DataFlavor/stringFlavor)]
    (when (.isDataFlavorAvailable *clipboard* f)
      (.getData *clipboard* f))))
