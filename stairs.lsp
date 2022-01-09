(defun findopp (point len width)
  ; Finds the co-ordinates of the opposite corner in a rectangle
  (setq
    x_coord (car point)
    y_coord (cadr point)
    z_coord (caddr point)
  )
  (setq opp_point (list (+ x__coord len) (+ y_coord width) z_coord)
)

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
    vertical_dist (- vertical_gain thickness)
  )
  
  ; Draw stairs
  (setq ref_point start_point)  ; Top right corner of the previous step
  
  (repeat num_stairs
    (setq
      z_coord (caddr ref_point)
      pt1 (subst (+ z_coord vertical_dist) z_coord ref_point)   ; Bottom lower right corner of stair
      pt2 (findopp pt1 stair_len stair_width)   ; Bottom upper left corner of stair
    )
    
    (command ".box" pt1 pt2 thickness "")
    
    ; Set new ref_point
    (setq
      x_coord (car ref_point)
      y_coord (cadr ref_point)
      z_coord (caddr ref_point)
      
      ref_point (list (+ x_coord stair_len overlap) y_coord (+ z_coord stair_thickness) )
    )
  )
)

