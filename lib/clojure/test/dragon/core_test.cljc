(ns dragon.core-test
  (:refer-clojure)
  (:require (clojure [test :refer :all])
            (dragon [core :refer :all])))

(deftest environment
  (testing "environment map"
    (is (= (System/getProperty "user.home") (env :user-home)))
    (is (= (System/getenv "PATH") (env :path)))))

(deftest kebabify
  (testing "kebab"
    (is (= :- (kebab "")))
    (is (= :- (kebab nil)))
    (is (= :foo-bar (kebab "FOO  _baR")))
    (is (= :dragon-core-test (kebab 'dragon.core-test)))
    (is (= :3-141592653589793 (kebab java.lang.Math/PI)))))

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
      (is (= "ouryay ypetay isway yperiteway" (latin "your type is yperite"))))
    (testing "properly handles basic vowels"
      (is (= "eatway anway omeletteway" (latin "eat an omelette"))))
    (testing "properly handles mixed capitalisation"
      (is (= "ellohay Ellohay ELLOHAY" (latin "hello Hello HELLO"))))
    (testing "properly handles full sentences with punctuation"
      (is (= "Ethay ickquay ownbray oxfay umpsjay overway ethay azylay ogday." (latin "The quick brown fox jumps over the lazy dog."))))
    (testing "property handles apostrophes"
      (is (= "Atthay's ymay eesechay!" (latin "That's my cheese!"))))))

(deftest queue
  (testing "queue syntactic sugar"
    (is (= "<<" (with-out-str (pr clojure.lang.PersistentQueue/EMPTY))))
    (let [q (conj << 'a 'b 'c 'd)]
      (is (= "<(a b c d)<" (with-out-str (pr q))))
      (is (= 'a (peek q)))
      (is (= (conj << 'b 'c 'd) (pop q))))))

(deftest rotational-cipher
  (testing "rot13"
    (is (= "Gur dhvpx oebja sbk whzcf bire gur ynml qbt." (rot13 "The quick brown fox jumps over the lazy dog.")))
    (is (= "The quick brown fox jumps over the lazy dog." (rot13 (rot13 "The quick brown fox jumps over the lazy dog."))))))
