(defun C:DRAWBOX (/ width height depth rect pt1 pt2 pt3)
  ; Takes in user input for width, height and a starting point then draws a rectangle based off this information
  
  ; Collect user input
  (setq
    pt1 (getpoint "Enter lower-left corner: ")
    width (getreal "Enter width: ")
    height (getreal "Enter height: ")
    depth (getreal "Enter depth: ")
  )
  
  ; Find corners of rectangle and draw
  (setq
    pt2 (polar pt1 0 width)
    pt3 (polar pt2 (/ pi 2) height)
  )  
  (command ".box" pt1 pt3 depth"")
)
