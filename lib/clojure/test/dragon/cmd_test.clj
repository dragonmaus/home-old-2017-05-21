(ns dragon.cmd-test
  (:refer-clojure)
  (:require [clojure.test :refer :all]
            [dragon.cmd :refer :all]))

(deftest ^:windows cmd-test
  (testing "printing command"
    (is (= "Hello!\n"
           (with-out-str (! echo Hello!)))))
  (testing "raw command"
    (is (= {:exit 0
            :out "Hello!\n"
            :err ""}
           (!! echo Hello!))))
  (testing "parser"
    (is (= {:exit 0
            :out "H:\\bin :foo /bar\n"
            :err ""}
           (!! echo %CD% $ :foo :bar $$ :dir "H:\\bin")))))
