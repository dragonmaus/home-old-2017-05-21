(ns dragon.core-test
  (:refer-clojure)
  (:require [clojure.test :refer :all]
            [dragon.core :refer :all]
            [dragon.maths :refer [τ]]))

(deftest env-test
  (testing "getenv"
    (is (= (System/getenv) (getenv)))
    (is (= (System/getenv "PATH") (getenv "PATH")))
    (is (= "jumps over the lazy dog."
           (getenv "The quick brown fox" "jumps over the lazy dog."))))
  (testing "getprop"
    (is (= (System/getProperties) (getprop)))
    (is (= (System/getProperty "user.home") (getprop "user.home")))
    (is (= "jumps over the lazy dog."
           (getprop "The quick brown fox" "jumps over the lazy dog."))))
  (testing "environment map"
    (is (= (System/getProperty "user.home") (env :user-home)))
    (is (= (System/getenv "PATH") (env :path)))))

(deftest kebab-test
  (testing "kebab"
    (is (= :- (kebab "")))
    (is (= :- (kebab nil)))
    (is (= :foo-bar (kebab "FOO  _baR")))
    (is (= :dragon-core-test (kebab 'dragon.core-test)))
    (is (= :6-283185307179586 (kebab τ)))))

(deftest ppmap-test
  (testing "partitioned parallel map"
    (let [given (range 100000)
          expected (map inc given)]
      (is (= expected (ppmap 100 inc given))))
    (let [given "The quick brown fox jumps over the lazy dog."
          inc-char (comp char inc int)
          expected (apply str (map inc-char given))]
      (is (= expected (apply str (ppmap 5 inc-char given)))))))

(deftest latin-test
  (testing "pig latin converter"
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
      (is (= "Ethay ickquay ownbray oxfay umpsjay overway ethay azylay ogday."
             (latin "The quick brown fox jumps over the lazy dog."))))
    (testing "property handles apostrophes"
      (is (= "Atthay's ymay eesechay!" (latin "That's my cheese!"))))))

(deftest <<-test
  (testing "queue syntactic sugar"
    (is (= "<<" (with-out-str (pr clojure.lang.PersistentQueue/EMPTY))))
    (let [q (conj << 'a 'b 'c 'd)]
      (is (= "<(a b c d)<" (with-out-str (pr q))))
      (is (= 'a (peek q)))
      (is (= (conj << 'b 'c 'd) (pop q))))))

(deftest rot13-test
  (testing "rot13 rotational cipher"
    (is (= "Gur dhvpx oebja sbk whzcf bire gur ynml qbt."
           (rot13 "The quick brown fox jumps over the lazy dog.")))
    (is (= "The quick brown fox jumps over the lazy dog."
           (rot13 "Gur dhvpx oebja sbk whzcf bire gur ynml qbt.")))))
