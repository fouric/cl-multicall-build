(in-package :cl-multicall-build)

(proclaim '(optimize (speed 0) (safety 0) (space 0) (debug 3)))

;; (system-name invoked-binary-name package-name entrypoint-name)
(defparameter *systems* '((cl-multicall-build multicall-build cl-multicall-build build)
                          (monolith monolith monolith main)
                          ;;(lightning-cd lightning lightning-cd main)
                          (mercury mercury mercury main)
                          ;;(graygoo graygoo graygoo main)
                          ))
(defparameter *bin-location* "~/bin")
(defparameter *bin-name* "cl-multicall")

(defun echo-and-run (string)
  (print string)
  (print (shell-command string)))

(defun build (&optional argv)
  (format t "hello world 3! my args were ~s~%" argv)
  (let ((new-bin-name (concatenate 'string "." *bin-name* ".new")))
    (echo-and-run (apply #'concatenate 'string
                         (format nil "buildapp --output ~a/~a --asdf-tree ~~/other-code/quicklisp/ --dispatched-entry /cl-multicall-build:build " *bin-location* new-bin-name)
                         (mapcar (lambda (system) (format nil "--load-system ~a --dispatched-entry ~a/~a:~a " (string-downcase (nth 0 system)) (string-downcase (nth 1 system)) (string-downcase (nth 2 system)) (string-downcase (nth 3 system)))) *systems*)))
    (echo-and-run (concatenate 'string "mv " new-bin-name " " *bin-name*)))
  (dolist (system *systems*)
    (echo-and-run (format nil "ln -fs ~a/~a ~a/~a" *bin-location* *bin-name* *bin-location* (string-downcase (nth 1 system))))))
