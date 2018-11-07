(in-package #:2d-grid)

(defclass 2d-grid ()
  ((grid :initform nil))
  (:documentation "An object representing a grid of values with x-y coordinates starting with at 0,0 in the top left corner"))

(deftype direction () '(member :up :down :right :up-right :down-right))

(defmethod initialize-instance :after ((grid-instance 2d-grid) 
                                       &key (width 1) (height 1))
  (let ((arr (make-array (list width height) :element-type 'fixnum)))
    (setf (slot-value grid-instance 'grid) arr)))

(defmethod print-object ((object 2d-grid) stream)
  (format stream "a 2d grid:~%")
  (let ((grd (slot-value object 'grid)))
    (dotimes (i (array-dimension grd 0))
      (dotimes (j (array-dimension grd 1))
        (format stream "~a~vt" (aref grd i j) (+ (* j 5) 5)))
      (format stream "~%"))))

(defmethod value-at ((grid 2d-grid) (row fixnum) (column fixnum))
  (let ((grd (slot-value grid 'grid)))
    (when (array-in-bounds-p grd row column)
      (aref grd row column))))

(defmethod set-value-at ((grid 2d-grid) (row fixnum) (column fixnum) val)
  (let ((grd (slot-value grid 'grid)))
    (when (array-in-bounds-p grd row column)
      (setf (aref grd row column) val))))

(defmethod get-list-of-values ((grid 2d-grid) 
                               (starting-row fixnum) 
                               (starting-column fixnum) 
                               (length fixnum) 
                               direction)
  "This function returns a list of values from the grid, given a starting point and a direction to proceed, which canbe the symbols :up, :up-right (for diagonal up), :right, :down-right (for diagonal down) and :down"
  (let ((grd (slot-value grid 'grid))
        (lst '())
        (lngth (- length 1)))
    (labels ((get-list (row-func col-func)
               (if (array-in-bounds-p grd
                                      (funcall row-func lngth)
                                      (funcall col-func lngth))
                   (dotimes (i length lst) 
                     (setf lst (cons (aref grd
                                           (funcall row-func i)
                                           (funcall col-func i))
                                     lst)))
                   '()))) ;;return null if bounds given aren't valid
      (cond ((eql direction :up)
             (get-list (lambda (x) (- starting-row x))
                       (lambda (x) (declare (ignore x)) starting-column)))
            ((eql direction :up-right)
             (get-list (lambda (x) (- starting-row x))
                       (lambda (x) (+ starting-column x))))
            ((eql direction :right)
             (get-list (lambda (x) (declare (ignore x)) starting-row)
                       (lambda (x) (+ starting-column x))))
            ((eql direction :down-right)
             (get-list (lambda (x) (+ starting-row x))
                       (lambda (x) (+ starting-column x))))
            ((eql direction :down)
             (get-list (lambda (x) (+ starting-row x))
                       (lambda (x) (declare (ignore x)) starting-column)))))))
