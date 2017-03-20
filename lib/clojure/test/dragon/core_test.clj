(ns dragon.core-test
  (:refer-clojure)
  (:require [clojure.test :refer :all]
            [dragon.core :refer :all]))

(deftest p-p-map
  (testing "partitioned parallel map"
    (let [given (range 10000)
          expected (map inc given)]
      (is (= expected (ppmap 100 inc given))))
    (let [given "The quick brown fox jumps over the lazy dog."
          expected (apply str (map (comp char inc int) given))]
      (is (= expected (apply str (ppmap 5 (comp char inc int) given)))))))

(deftest pig-latin
  (testing "pig latin generator"
    (testing "properly handles basic consonants"
      (is (= "Atinlay" (latin "Latin"))))
    (testing "properly handles y"
      (is (= "Ouyay" (latin "You")))
      (is (= "Ypetay" (latin "Type"))))
    (testing "properly handles qu"
      (is (= "Ickquay" (latin "Quick")))
      (is (= "Eaksquay" (latin "Squeak"))))
    (testing "properly handles full sentences with punctuation"
      (is (= "Ethay ickquay ownbray oxfay umpsjay overay ethay azylay ogday." (latin "The quick brown fox jumps over the lazy dog."))))))
