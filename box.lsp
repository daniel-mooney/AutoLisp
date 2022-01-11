(defun drawBox (pt1 len width height / pt2 pt3 pt4 pt5 pt6 pt7 pt8)
  ; Draws a 3D box of the specified dimensions, pt1 represents the lower left of the front view
  
  ; Find Base vertices
  (setq
    pt2 (polar pt1 0 len)   ; Base - lower right
    pt3 (polar pt2 (/ pi 2) height)   ; Base - upper right
    pt4 (polar pt1 (/ pi 2) height)   ; Base - upper left
  )
  
  ; Find top vertices, each corresponds to the base vertice immediately below
  (setq
    pt5 (list (car pt1) (cadr pt1) (+ (caddr pt1) height))
    pt6 (list (car pt2) (cadr pt2) (+ (caddr pt2) height))
    pt7 (list (car pt3) (cadr pt3) (+ (caddr pt3) height))
    pt8 (list (car pt4) (cadr pt4) (+ (caddr pt4) height))
  )
  
  ; Draw lines
  (command ".line" pt1 pt2 pt3 pt4 pt1 "")  ; Base
  (command ".line" pt5 pt6 pt7 pt8 pt5 "")  ; Top
  
  (command ".line" pt1 pt5 "")
  (command ".line" pt2 pt6 "")
  (command ".line" pt3 pt7 "")
  (command ".line" pt4 pt8 "")  
)

(defun c:DRAWBOX ()
  (setq
    point (getpoint "Enter point: ")
    len (getreal "Enter length: ")
    width (getreal "Enter width:")
    height (getreal "Enter height: ")
  )
  
  (drawBox point len width height)
)