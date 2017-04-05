(ns dragon.clipboard
  (:refer-clojure)
  (:require [clojure.string :as str]
            [clojure.java [io :as io]
                          [shell :refer [sh]]]
            [dragon.core :refer [getenv getprop]])
  (:import [java.awt GraphicsEnvironment
                     Toolkit]
           [java.awt.datatransfer DataFlavor
                                  StringSelection]))

;;; Mode specification.
(defn- has-pb?
  []
  (and (let [f (io/file "/usr/bin/pbcopy")]
         (and (.exists f)
              (.isFile f)
              (.canExecute f)))
       (let [f (io/file "/usr/bin/pbpaste")]
         (and (.exists f)
              (.isFile f)
              (.canExecute f)))))

(defn- has-gui?
  []
  (not (GraphicsEnvironment/isHeadless)))

(def ^:dynamic *mode* nil)

(defn- get-mode
  []
  (cond
   (#{:pb :awt :file} *mode*) *mode*
   (has-pb?)                  :pb
   (has-gui?)                 :awt
   :else                      :file))

(defmacro with-mode
  [mode & forms]
  `(binding [*mode* ~mode]
     ~@forms))

;;; OSX implementation.
(defn- pb-paste
  []
  (:out (sh "/usr/bin/pbpaste")))

(defn- pb-copy
  [s]
  (sh "/usr/bin/pbcopy" :in (str s))
  nil)

;;; AWT implementation.
(def ^:dynamic *awt-clipboard* (.getSystemClipboard (Toolkit/getDefaultToolkit)))

(def ^:dynamic *awt-data-flavor* nil)

(defmacro with-data-flavor
  [flavor & forms]
  `(let [df# (case ~flavor
               :files DataFlavor/javaFileListFlavor
               :html  DataFlavor/selectionHtmlFlavor
               :image DataFlavor/imageFlavor
                      DataFlavor/stringFlavor)]
     (binding [*awt-data-flavor* df#
               *mode* :awt]
       ~@forms)))

(defn- awt-paste
  []
  (let [df (or *awt-data-flavor*
               ;(first (.getAvailableDataFlavors *awt-clipboard*))
               DataFlavor/stringFlavor)]
    (when (.isDataFlavorAvailable *awt-clipboard* df)
      (.getData *awt-clipboard* df))))

(defn- awt-copy
  [s]
  (as-> s s
    (str s)
    (StringSelection. s)
    (.setContents *awt-clipboard* s nil)))

;;; File implementation.
(def ^:dynamic *file-clipboard*
  (let [file (getenv "CLIPBOARD")
        file (or (and file (io/file file))
                 (io/file (getprop "user.home") ".clipboard"))]
    (doto file (.createNewFile))))

(defn- file-paste
  []
  (slurp *file-clipboard*))

(defn- file-copy
  [s]
  (spit *file-clipboard* (str s)))

;;; Core functions.
(defn paste
  []
  (case (get-mode)
    :pb   (pb-paste)
    :awt  (awt-paste)
    :file (file-paste)))

(defn copy
  [s]
  (case (get-mode)
    :pb   (pb-copy s)
    :awt  (awt-copy s)
    :file (file-copy s)))

(defn clear
  []
  (copy nil))
