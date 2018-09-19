(in-package :cl-project-euler)

(defun problem1 (n)
  (reduce #'+ (remove-if-not (lambda (x) (or (= 0 (mod x 3)) 
                                             (= 0 (mod x 5)))) 
                             (alexandria:iota (- n 1) :start 1))))

(defun problem2 ()
  1)
