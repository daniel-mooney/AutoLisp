(defun c:TEST ()
  (load "C:\\Users\\danie\\OneDrive\\Documents\\AutoCAD\\AutoLisp\\ReadCSV-V1-3.lsp")
  
  (setq
    f_prefix (getvar "DWGPREFIX")
    file (getfiled "Instruction File" f_prefix "csv" 0)
  )
  
  (setq line (LM:readcsv file))
  (print line)

  (princ)
)