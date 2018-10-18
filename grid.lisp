(in-package #:2d-grid)

(defclass 2d-grid ()
  ((grid :initform nil))
  (:documentation "An object representing a grid of values with x-y coordinates starting with at 0,0 in the top left corner"))

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

(defmethod value-at ((grid 2d-grid) x y)
  (let ((grd (slot-value grid 'grid)))
    (when (array-in-bounds-p grd x y)
      (aref grd x y))))

(defmethod set-value-at ((grid 2d-grid) x y val)
  (let ((grd (slot-value grid 'grid)))
    (when (array-in-bounds-p grd x y)
      (setf (aref grd x y) val))))


