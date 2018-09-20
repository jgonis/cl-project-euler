(in-package :cl-project-euler)

(defun make-growable-vector (initial-size) 
    (make-array initial-size :fill-pointer 0 :adjustable t))

(defun problem1 (n)
  (reduce #'+ (remove-if-not (lambda (x) (or (= 0 (mod x 3)) 
                                             (= 0 (mod x 5)))) 
                             (alexandria:iota (- n 1) :start 1))))

(defun problem2 ()
  (let ((vec (make-growable-vector 10)))
    (vector-push-extend 1 vec)
    (vector-push-extend 2 vec)
    (do* ((index 2 (+ index 1))
          (fib-val 3
                   (+ (elt vec (- index 1))
                      (elt vec (- index 2)))))
         ((> fib-val 4000000) vec)
      (vector-push-extend fib-val vec))
    (reduce #'+ (remove-if-not (lambda (x) (= 0 (mod x 2))) vec))))

(defun naive-primep (x)
  (labels ((naive-primep-helper (x counter)
             (cond ((= 0 (mod x counter)) nil)
                   ((= (ceiling (sqrt x)) counter) t)
                   (t (naive-primep-helper x (+ counter 1))))))
    (cond ((= x 1) nil)
          ((= x 2) t)
          (t (naive-primep-helper x 2)))))

(defun generate-factors (x)
  (let ((vec (make-growable-vector 0)))
    (do ((i 1 (+ i 1)))
        ((> i (ceiling (/ x 2))) vec)
      (if (= 0 (mod x i))
          (vector-push-extend i vec)))))

(defun problem3 (input)
  (let ((vec (remove-if-not #'naive-primep (generate-factors input))))
    (elt vec (- (length vec) 1))))

(defun problem4 ()
  (let ((vec (make-growable-vector 0)))
    (do ((i 999 (- i 1)))
        ((< i 100))
      (do ((j i (- j 1)))
          ((< j 100))
        (vector-push-extend (* i j) vec)))
    (find-if (lambda (x) 
               (let ((str (write-to-string x))) 
                 (string= (reverse str) 
                          str))) 
             (sort vec #'>))))

(defun problem5 (divisor-seq)
  (do ((i 11 (+ i 1)))
      ((null (find-if-not (lambda (x) 
                            (= 0 (mod i x))) 
                          divisor-seq)) i)))


(defun problem6 (n)
  (let ((square-of-sum (expt (/ (* n (+ n 1)) 2) 2))
        (sum-of-squares (reduce #'+ (map 'list (lambda (x) (expt x 2)) (alexandria:iota n :start 1)))))
    (- square-of-sum sum-of-squares)))

(defun problem7 (number-of-primes-to-find)
  (do* ((i 1 (+ i 1))
        (count 0 (if (naive-primep i) 
                     (+ count 1) 
                     count)))
       ((>= count number-of-primes-to-find) i)))

(defun problem8 (input-seq adjacent-length)
  (labels 
      ((problem8-helper (input-seq  
                         start 
                         end 
                         current-max)
         (cond ((> end (length input-seq)) current-max)
               (t (problem8-helper 
                   input-seq 
                   (+ start 1)
                   (+ end 1)
                   (max current-max 
                        (reduce #'* input-seq :start start :end end)))))))
    (problem8-helper input-seq 0 (+ 0 adjacent-length) -1)))
