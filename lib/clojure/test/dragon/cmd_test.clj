(ns dragon.cmd-test
  (:refer-clojure)
  (:require (clojure [test :refer :all])
            (dragon [cmd :refer :all])))

(deftest command
  (testing "cmd"
    (is (= "Hello!\n"
           (with-out-str (cmd "echo" "Hello!")))))
  (testing "cmd!"
    (is (= {:exit 0
            :out "Hello!\n"
            :err ""}
           (cmd! "echo" "Hello!"))))
  (testing "!"
    (is (= "Hello!\n"
           (with-out-str (! echo "Hello!")))))
  (testing "!!"
    (is (= {:exit 0
            :out "Hello!\n"
            :err ""}
           (!! echo "Hello!")))))

(deftest parser
  (is (= {:exit 0
          :out (str "H:\\bin :foo /bar\n")
          :err ""}
         (!! echo %CD% $ :foo :bar $$ :dir "H:\\bin"))))
