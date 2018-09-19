(defsystem "cl-project-euler"
  :description "Work on solving the Project Euler problems in Common Lisp"
  :version "0.0.1"
  :author "Jeff Gonis <jeffgonis@fastmail.com"
  :licence "LGPL 3.0"
  :components ((:file "packages")
               (:file "problem1" :depends-on ("packages"))))
