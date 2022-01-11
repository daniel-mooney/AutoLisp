(defun c:test ()
  (setq
    ent (entlast)
    entl (entget ent)
    i 0                 ; Incrementor
  )
  
  (princ "Entget data: ")
  
  (repeat (length entl) 
    (print (nth i entl))
    (setq i (1+ i))
  )
  (princ)
)