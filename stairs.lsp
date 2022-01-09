(defun C:DRAWSTAIRS (/ total_length height stair_len stair_width stair_thickness)
  
  ; Retrieve Dimensions from the User
  (setq
    total_length (getreal "Enter total length: ")
    height (getreal "Enter total height: ")
    num_stairs (getint "Enter number of stairs: ")
    stair_len (getreal "Enter individual stair length: ")
    stair_width (getreal "Enter stair width: ")
    stair_thickness (getreal "Enter stair thickness: ")
    start_point (getpoint "Select stair starting point")
  )
  
  ; Calculate stair overlapping length
  (setq
    length_diff (- total_length (* num_stairs stair_len) )
    overlap (/ length_diff (- num_stairs 1) )
  )
  
  ; Calculate vertical distance between stairs
  (setq
    vertical_gain (/ height num_stairs)
    
  )
)