(in-package #:grid)

(defclass grid ()
  ((storage :initform nil))
  (:documentation "An object representing a grid of values with x-y coordinates starting with at 0,0 in the top left corner"))

(defmethod initialize-instance :after ((grid-instance grid) &key (x 1) (y 1))
  (let ((arr (make-array (list x y) :element-type 'fixnum)))
    (setf (slot-value grid-instance 'storage) arr)))

(defmethod print-object ((object grid) stream)
  (let ((grd (slot-value object 'storage)))
    ))
