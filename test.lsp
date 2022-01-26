(defun c:test ()
  (setq
    a (list 3 2 1)
    b (list 3 2 1)
  )
  
  (if (equal a b)
    (print "Equal")
    (print "Not Equal")
  )
  (princ)
)