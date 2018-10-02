(in-package :cl-multicall-build)

(proclaim '(optimize (speed 0) (safety 0) (space 0) (debug 3)))

(defparameter *systems* '((monolith monolith monolith main)
                          (graygoo graygoo graygoo main)
                          (lightning-cd lightning lightning-cd main)
                          (mercury mercury mercury main)
                          (cl-multicall-build multicall-build cl-multicall-build build)))

(defun build (&optional argv)
  (format t "hello world! my args were ~s~%" argv)
  (format t "pushd ~~/bin~%")
  (format t "buildapp --output cl-multicall --asdf-tree ~~/other-code/quicklisp/ --dispatched-entry /cl-multicall-build:build~%")
  (dolist (system *systems*)
    (format t "--load-system ~a --dispatched-entry ~a/~a:~a~%" (string-downcase (nth 0 system)) (string-downcase (nth 1 system)) (string-downcase (nth 2 system)) (string-downcase (nth 3 system)))))
