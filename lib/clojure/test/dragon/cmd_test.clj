(ns dragon.cmd-test
  (:refer-clojure)
  (:require (clojure [test :refer :all])
            (dragon [cmd :refer :all])))

(deftest command
  (testing "!"
    (is (= "Hello! \n"
           (with-out-str (! echo Hello!)))))
  (testing "!!"
    (is (= {:exit 0
            :out "Hello! \n"
            :err ""}
           (!! echo Hello!)))))

(deftest parser
  (is (= {:exit 0
          :out "H:\\bin :foo /bar\n"
          :err ""}
         (!! echo %CD% $ :foo :bar $$ :dir "H:\\bin"))))
