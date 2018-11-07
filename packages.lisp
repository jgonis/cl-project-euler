(defpackage #:2d-grid
  (:use #:cl)
  (:export #:2d-grid
           #:set-value-at
           #:value-at
           #:get-list-of-values))

(defpackage #:cl-project-euler
  (:use #:cl #:2d-grid)
  (:export #:problem1 #:problem2))
