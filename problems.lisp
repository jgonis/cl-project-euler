(in-package #:cl-project-euler)

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
  (do ((i 20 (+ i 20)))
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

(defparameter *p8-input-path* 
  #P"~/quicklisp/local-projects/cl-project-euler/problem8Input.txt")

(defun read-input-as-vector (input-path vec)
  (with-open-file (in-stream input-path)
    (do ((ch (read-char in-stream) (read-char in-stream nil)))
        ((null ch) vec)
      (if (digit-char-p ch) 
          (vector-push-extend (parse-integer (string ch)) vec)))))


(defun problem8 (input-seq adjacent-length)
  (labels 
      ((new-offset (input-seq start end)
         (let ((zero-pos (position 0 input-seq :from-end t :start start :end end)))
           (cond ((null zero-pos) 1)
                 (t (- (+ zero-pos 1) start)))))
       (problem8-helper (input-seq  
                         start 
                         end 
                         current-max)
         (cond ((> end (length input-seq)) current-max)
               (t 
                (let ((offset (new-offset input-seq start end))) 
                  (problem8-helper 
                     input-seq 
                     (+ start offset)
                     (+ end offset)
                     (max current-max (reduce #'* input-seq :start start :end end))))))))
    (problem8-helper input-seq 0 (+ 0 adjacent-length) -1)))

(defun problem9 (n)
  (alexandria:map-combinations 
   (lambda (comb) 
     (destructuring-bind (a b c) comb
       (cond ((and (= 1000 (+ a b c)) (= (* c c) 
                                          (+ (* a a) (* b b)))) 
              (format t "~A~%" (* a b c)))))) 
   (alexandria:iota n :start 1) 
   :length 3))

(defun problem10 (n)
  (let ((sum 2))
    (do ((i 3 (+ i 2)))
        ((>= i n) sum)
      (if (naive-primep i) 
          (setf sum (+ sum i))))))

(defparameter *p11-input-path* 
  #P"~/quicklisp/local-projects/cl-project-euler/problem11input.txt")


(defun read-input-as-grid (input-path vec)
  (with-open-file (in-stream input-path)
    (do ((line (read-line in-stream) (read-line in-stream nil)))
        ((null line) vec)
      (let* ((split-line (cl-utilities:split-sequence #\Space line))
             (result-vec (map 'vector 
                              (lambda (x) 
                                (parse-integer x)) 
                              split-line)))
        (vector-push-extend result-vec vec)))))

;; (defun get-all-superclasses (class-obj)
;;  (labels ((helper (class-obj lst)
;;             (let ((superclasses (closer-mop:class-direct-superclasses 
;;                                  class-obj)))
;;               (cond ((null superclasses) lst)
;;                     (t (mapcar (lambda (x) (helper x (cons (list x) lst))) 
;;                                 superclasses))))))
;;    (remove-duplicates (alexandria:flatten (helper class-obj (list))) 
;;                       :test #'equalp)))
