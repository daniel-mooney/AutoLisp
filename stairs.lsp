(defun findopp (point len width)
  ; Finds the co-ordinates of the opposite corner in a rectangle
  (setq
    x_coord (car point)
    y_coord (cadr point)
    z_coord (caddr point)
  )
  (setq opp_point (list (+ x_coord len) (+ y_coord width) z_coord))
)

(defun c:DRAWSTAIRS (/ total_length height stair_len stair_width stair_thickness)
  
  ; Retrieve Dimensions from the User
  (setq
    start_point (getpoint "Select stair starting point: ")
    total_length (getreal "Enter total length: ")
    height (getreal "Enter total height: ")
    num_stairs (getint "Enter number of stairs: ")
    stair_len (getreal "Enter individual stair length: ")
    stair_width (getreal "Enter stair width: ")
    stair_thickness (getreal "Enter stair thickness: ")
  )
  
  ; Calculate stair overlapping length
  (setq
    length_diff (- total_length (* num_stairs stair_len) )
    overlap (/ length_diff (- num_stairs 1) )
  )
  
  ; Calculate vertical distance between stairs
  (setq
    vertical_gain (/ height num_stairs)   ; Total stair gain
    vertical_dist (- vertical_gain stair_thickness)   ; Space between the lower part of one step and the top of the previous step
  )
  
  ; Draw stairs
  (setq ref_point start_point)  ; Top right corner of the previous step  
  
  (repeat num_stairs
       
    (setq
      pt1 (list (car ref_point) (cadr ref_point) (+ (caddr ref_point) vertical_dist))
      pt2 (findopp pt1 stair_len stair_width)
    )
    
    (command "._box" pt1 pt2 stair_thickness "")
    
    ; Set new reference point
    (setq
      x_coord (+ (car ref_point) stair_len overlap)
      y_coord (cadr ref_point)
      z_coord (+ (caddr ref_point) vertical_gain)
      
      ref_point (list x_coord y_coord z_coord)
    )
  )
)

