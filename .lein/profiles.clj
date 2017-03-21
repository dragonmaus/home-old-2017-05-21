{:repl {:dependencies [[dragon/libs "0.1.0-SNAPSHOT"]]
        :plugins [[lein-pprint "1.1.0"]]
        :repl-options {:init (do
                               (require '(clojure [set :as set]
                                                  [string :as str])
                                        '(dragon [clipboard :as clipboard]
                                                 [core :refer :all]
                                                 [maths :as maths])))}}
 :user {:plugins [[jonase/eastwood "0.2.3"]]}}
