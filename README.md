# cl-multicall-build

quickly build a Common Lisp multicall image using buildapp from a data file

next: buildapp sort of randomly breaks on some machines, going to build my own:
    (1) for designing, take several different existing programs - let's say graygoo and monolith - and then import those functions into a lisp core in separate packages
        find existing code, and figure out what the "right" way to do packages is - then do that with graygoo and monolith
    (2) figure out how to get the arguments that a lisp program was invoked with
        *posix-argv*
    (3) switch on argv[0] to invoke the individual function
        (pathname-name (pathname (first *posix-argv*)))
        (intern (string-upcase (pathname-name (pathname (first *posix-argv*)))))
    (4) write to core file
        (defparameter *binary-name* (second *posix-argv*))
        (defun switcher ()
          (case (intern (string-upcase (pathname-name (pathname (first *posix-argv*)))))
            (*binary-name*
              ;; if the binary was just called by its default name, we should check the first argument to use that for the binary...
              )
            (monolith
              (monolith:monolith))
            (graygoo
              (graygoo:graygoo))))
        (sb-ext:save-lisp-and-die *binary-name* :toplevel 'switcher :executable t)
    (5) write script that does this
        invoke the script with a list of arguments like graygoo:graygoo and monolith:monolith which then splits those things, uses the first to ql:quickload, and the entire thing for a switch statement for the multicall
        if the script is called with its normal name, then use the first argument to the script to figure out what to do...and then maybe remove that argument from *posix-argv* to avoid affecting whatever is being called?
        is it possible to support appending to an existing multicall binary? the toplevel's been overwritten, right?
