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
      (is (= "igpay atinlay" (latin "pig latin"))))
    (testing "properly handles qu"
      (is (= "ickquay eaksquay ababqay" (latin "quick squeak qabab"))))
    (testing "properly handles y"
      (is (= "ouryay ypetay isay yperiteay" (latin "your type is yperite"))))
    (testing "properly handles mixed capitalisation"
      (is (= "ellohay Ellohay ELLOHAY" (latin "hello Hello HELLO"))))
    (testing "properly handles full sentences with punctuation"
      (is (= "Ethay ickquay ownbray oxfay umpsjay overay ethay azylay ogday." (latin "The quick brown fox jumps over the lazy dog."))))
    (testing "property handles apostrophes"
      (is (= "Atthay's ymay eesechay!" (latin "That's my cheese!"))))))
