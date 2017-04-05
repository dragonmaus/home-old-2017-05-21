{:repl {:dependencies [[dragon/libs "1.0.0-SNAPSHOT"]]
        :plugins [[lein-pprint "1.1.0"]]
        :repl-options {:init (do
                              (require '[clojure.set :as set]
                                       '[clojure.string :as string]
                                       '[dragon.clipboard :as clipboard]
                                       '[dragon.core :refer :all]
                                       '[dragon.maths :as maths]))}}
 :user {:plugins [[jonase/eastwood "0.2.3"]]}}
