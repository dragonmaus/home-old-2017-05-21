(ns dragon.maths-test
  (:import [java.lang Math])
  (:refer-clojure)
  (:require (clojure [test :refer :all])
            (dragon [maths :refer :all])))

(deftest constants
  (testing "the value of constant"
    (testing "e"
      (is (= 2.718281828459045 (double e))))
    (testing "π"
      (is (= 3.141592653589793 (double π))))
    (testing "τ"
      (is (= 6.283185307179586 (double τ))))))
