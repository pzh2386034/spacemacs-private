;; json-mode
(require 'json-mode)
(setq json-mode-indent-level 4)
(add-to-list 'auto-mode-alist '("\\.json\\'" . json-mode))
(defun json-beautify ()
  (interactive)
  (let ((begin (if mark-active (min (point) (mark))
                  (point-min)))
        (end (if mark-active (max (point) (mark))
                      (point-max))))
    (shell-command-on-region begin end "python -mjson.tool"
                                  (current-buffer) t)))
(define-key json-mode-map (kbd "C-c C-f") #'json-beautify)
