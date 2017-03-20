{:repl {:dependencies [[dragon/libs "0.1.0-SNAPSHOT"]
                       [environ "1.1.0"]]
        :plugins [[lein-environ "1.1.0"]
                  [lein-pprint "1.1.0"]]
        :repl-options {:init (do
                               (require '[clojure.set :as set])
                               (require '[clojure.string :as str])
                               (require '[dragon.clipboard :as clipboard])
                               (require '[dragon.core :refer :all])
                               (require '[dragon.maths :as maths])
                               (require '[environ.core :refer [env]])
                               (intern 'environ.core 'env (into (sorted-map) environ.core/env)))}}}
