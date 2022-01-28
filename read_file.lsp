(defun c:TEST ()
  (load "C:\\Users\\danie\\OneDrive\\Documents\\AutoCAD\\AutoLisp\\ReadCSV-V1-3.lsp")
  
  (setq
    file (getfiled "Instruction File" "" "csv" 0)
  )
  
  (setq line (LM:readcsv file))
  (print line)

  (princ)
)