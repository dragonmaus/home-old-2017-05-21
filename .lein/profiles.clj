{:repl {:dependencies [[dragon/libs "1.0.0-SNAPSHOT"]]
        :plugins [[lein-pprint "1.1.0"]]
        :repl-options {:init (do
                              (require '[clojure [set :as set]
                                                 [string :as str]]
                                       'clojure.java.javadoc
                                       '[dragon [clipboard :as clipboard]
                                                [core :refer :all]
                                                [maths :as maths]])
                              (let [fix #(str/replace
                                          %
                                          #"http://java\.sun\.com/javase/7/"
                                          "https://docs.oracle.com/javase/8/")]
                                (intern 'clojure.java.javadoc
                                        '*core-java-api*
                                        (fix clojure.java.javadoc/*core-java-api*))
                                (intern 'clojure.java.javadoc
                                        '*remote-javadocs*
                                        (ref (into (sorted-map)
                                                   (map (fn
                                                         [[k v]]
                                                         [k (fix v)])
                                                        @clojure.java.javadoc/*remote-javadocs*))))))}}
 :user {:plugins [[jonase/eastwood "0.2.3"]]}}
