(set-env!
 :resource-paths #{"src"}
 :dependencies '[[adzerk/boot-test "1.2.0" :scope "test"]]
 :source-paths #{"test"})

(require '[adzerk.boot-test :refer :all])

(task-options!
 pom {:project 'dragon/libs
      :version "1.0.0-SNAPSHOT"
      :description "Miscellaneous personal code"}
 aot {:all true})
