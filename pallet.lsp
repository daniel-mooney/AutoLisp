(defun findopp (point len width)
  ; Finds the co-ordinates of the opposite corner in a rectangle
  (setq
    x_coord (car point)
    y_coord (cadr point)
    z_coord (caddr point)
  )
  (setq opp_point (list (+ x_coord len) (+ y_coord width) z_coord))
)

(defun c:DRAWPALLET ()
  ; Hard coded function that draws a pallet with dimensions adhearing to Australian Standards

  ; Constants (values in millimetres)
  (setq
    LEN 1165
    WIDTH 1165
    HEIGHT 150
    MIN_GAP 30    ; The gap between the upper planks of a pallet
    INNER_PLANK_WIDTH 138
    OUTER_PLANK_WIDTH 145
    PLANK_THICKNESS 17.5
    TOTAL_LOWER_PLANKS 3
    CROSS_BEAM_THICKNESS 45
    TOTAL_CROSS_BEAMS 3
  )
  
  (setq
    start_point (getpoint "Enter start point: ")
  )
  
  (setq
    total_inner_planks (fix(/ (- WIDTH (* 2 OUTER_PLANK_WIDTH) MIN_GAP) (+ INNER_PLANK_WIDTH MIN_GAP) ) )
    upper_plank_gap (/ (- WIDTH (* 2 OUTER_PLANK_WIDTH) (* total_inner_planks INNER_PLANK_WIDTH) ) (+ 1 total_inner_planks) )
    lower_plank_gap (/ (- WIDTH (* TOTAL_LOWER_PLANKS OUTER_PLANK_WIDTH) ) (- TOTAL_LOWER_PLANKS 1))
    cross_beam_height (- HEIGHT (* 2 PLANK_THICKNESS) )
    cross_beam_gap (/ (- WIDTH (* TOTAL_CROSS_BEAMS CROSS_BEAM_THICKNESS) ) (- TOTAL_CROSS_BEAMS 1))
  )
  
  ; Disable Object Snap
  (setq snap_value (getvar "OSMODE"))
  (setvar "OSMODE" 0)
  
  ; Draw lower planks
  (setq opp_point (findopp start_point LEN OUTER_PLANK_WIDTH) )
  
  (command "._box" start_point opp_point PLANK_THICKNESS)
  (setq lower_plank (entlast) )
  
  (command "._array" lower_plank "" "r" TOTAL_LOWER_PLANKS 1 (+ lower_plank_gap OUTER_PLANK_WIDTH) )
  (setq lower_plank nil)
  
  ; Draw Cross Beams  
  (setq
    x_coord (car start_point)
    y_coord (cadr start_point)
    z_coord (caddr start_point)
    
    ref_point (list x_coord y_coord (+ z_coord PLANK_THICKNESS) ) ; New reference point
    opp_point (findopp ref_point CROSS_BEAM_THICKNESS WIDTH)
  ) 
  
  (command "._box" ref_point opp_point cross_beam_height)
  (setq cross_beam (entlast) )
  
  (command "._array" cross_beam "" "r" 1 TOTAL_CROSS_BEAMS (+ cross_beam_gap CROSS_BEAM_THICKNESS) )
  (setq cross_beam nil)
  
  ; Draw outer upper planks
  (setq
    x_coord (car ref_point)
    y_coord (cadr ref_point)
    z_coord (caddr ref_point)
    
    ref_point (list x_coord y_coord (+ z_coord cross_beam_height) )
    opp_point (findopp ref_point LEN OUTER_PLANK_WIDTH)
  )
  
  (command "._box" ref_point opp_point PLANK_THICKNESS)
  (setq outer_plank (entlast) )
  
  (command "._array" outer_plank "" "r" 2 1 (- WIDTH OUTER_PLANK_WIDTH) )
  (setq outer_plank nil)
  
  ; Draw inner upper planks
  (setq
    x_coord (car ref_point)
    y_coord (cadr ref_point)
    z_coord (caddr ref_point)
    
    ref_point (list x_coord (+ y_coord OUTER_PLANK_WIDTH upper_plank_gap) z_coord)
    opp_point (findopp ref_point LEN INNER_PLANK_WIDTH)
  )
  
  (command "._box" ref_point opp_point PLANK_THICKNESS)
  (setq inner_plank (entlast) )
  
  (command "._array" inner_plank "" "r" total_inner_planks 1 (+ INNER_PLANK_WIDTH upper_plank_gap) )
  (setq inner_plank nil)  
  
  
  (setvar "OSMODE" snap_value) ; Reset Object Snap
)