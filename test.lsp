(defun changeLayer (entity layerName)
  (setq def_list (entget entity) )  
  (setq def_list (subst (cons 8 layerName) (assoc 8 def_list) def_list) )
  
  (entmod def_list)
  
)

(defun c:TEST ()
  
  (setq
    start (getpoint "Enter starting point: ")
    p2 (polar start 0 300)
    p3 (polar p2 (/ pi 2) 300)
    p4 (polar start (/ pi 2) 300)
  )
  
  (command "._line" start p2 p3 p4 start "")
  (setq
    lines (ssget "_C" start p3 )
  )
  
  (command "._pedit" lines "Y" "_join" "_all" "" "")
  (setq lines nil)
  (setq box (ssget "_L"))
  
  (changeLayer (ssname box 0) "Pallet")
  (command "._chprop" box "" "_C" "red" "")
  
  (command "._block" "BLOCK1" start box "")
  (command "._layer" "Set" "Pallet" "")
  (command ".insert" "BLOCK1" start "" "" "")   
  
  (princ)
)

(defun c:PRINTINFO ()
  (setq
    block (ssget)
    blockName (ssname block 0)
    defList (entget blockName)
  )
  (print defList)
  (princ)  
)