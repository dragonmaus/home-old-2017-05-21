(ns dragon.clipboard-test
  (:refer-clojure)
  (:require [clojure.test :refer :all]
            [dragon.clipboard :refer :all]))

(deftest clipboard
  (let [data "The quick brown fox jumps over the lazy dog."]
    (testing "copy+paste"
      (is (= true (copy data)))
      (is (= data (paste))))
    (testing "clear"
      (is (= true (clear)))
      (is (empty? (paste))))))
