(defsystem "cl-project-euler"
  :description "Work on solving the Project Euler problems in Common Lisp"
  :version "0.0.1"
  :author "Jeff Gonis <jeffgonis@fastmail.com"
  :licence "LGPL 3.0"
  :depends-on ("alexandria" "cl-utilities")
  :components ((:file "packages")
               (:file "grid")
               (:file "problems" :depends-on ("packages" "grid"))))
