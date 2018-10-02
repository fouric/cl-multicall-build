;;;; -*- Mode: Lisp; Syntax: ANSI-Common-Lisp; Base: 10 -*-

(defpackage #:cl-multcall-build-asd
  (:use :cl :asdf))

(in-package :cl-multcall-build-asd)

(defsystem cl-multicall-build
  :name "cl-multicall-build"
  :version "0.0.0"
  :maintainer "fouric"
  :author "fouric"
  :license "All rights reserved"
  :description "quickly build a Common Lisp multicall image using buildapp from a data file"

  :serial t
  :depends-on (:trivial-shell)
  :pathname "src"
  :components ((:file "package")
               (:file "cl-multicall-build" :depends-on ("package"))))
