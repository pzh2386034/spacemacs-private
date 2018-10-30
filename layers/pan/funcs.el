;; define functions 
;; fix for tab indent
;;;###auto-loaded
(defun pan/indent-region(numSpaces)
  (progn
                                        ; default to start and end of current line
    (setq regionStart (line-beginning-position))
    (setq regionEnd (line-end-position))

                                        ; if there is a selection, use that instead of current line)
    (when (use-region-p)
      (setq regionStart (region-beginning))
      (setq regionEnd (region-end))
      )

    (save-excursion ;restore the position afterwards
      (goto-char regionStart);goto the start of region
      (setq start (line-beginning-position));save the start of the line
      (goto-char regionEnd)   
      (setq end (line-end-position))
      (indent-rigidly start end numSpaces); indent between start and end
      (setq deactivate-mark nil) 
      )
    )
  )

;; 快速替换， 选中需要替换的文本，c-r调用函数
(defun pan/evil-quick-replace (beg end)
  (interactive "r")
  (when (evil-visual-state-p)
    (evil-exit-visual-state)
    (let ((selection (regexp-quote (buffer-substring-no-properties beg end))))
      (setq command-string (format "%%s /%s//g" selection))
      (minibuffer-with-setup-hook
          (lambda () (backward-char 2))
        (evil-ex command-string)))))

(with-eval-after-load 'evil
	(define-key evil-visual-state-map (kbd "C-r") 'pan/evil-quick-replace)
	)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; 搜索相关配置
;; 在当前buff搜索， 会将搜索内容罗列在另一个buff中
(defun pan/occur-dwim ()
  "Call `occur' with a sane default."
  (interactive)
  (push (if (region-active-p)
            (buffer-substring-no-properties
             (region-beginning)
             (region-end))
          (let ((sym (thing-at-point 'symbol)))
            (when (stringp sym)
              (regexp-quote sym))))
        regexp-history)
  (deactivate-mark)
  (call-interactively 'occur))

(spacemacs/set-leader-keys  "so" 'pan/occur-dwim) 

(defun pan/git-project-root ()
  "Return the project root for current buffer"
  (let ((directory default-directory))
    (locate-dominating-file directory ".git")
    )
  )


(defun pan/run-current-file ()
  "Execute the current file.
For example, if the current buffer is the file x.py, then it'll call 「python x.py」 in a shell.
The file can be emacs lisp, php, perl, python, ruby, javascript, bash, ocaml, Visual Basic.
File suffix is used to determine what program to run.
If the file is modified, ask if you want to save first.
URL `http://ergoemacs.org/emacs/elisp_run_current_file.html'
version 2015-08-21"
  (interactive)
  (let* (
         (ξsuffix-map
          ;; (‹extension› . ‹shell program name›)
          `(
            ("php" . "php")
            ("pl" . "perl")
            ("py" . "python")
            ("py3" . ,(if (string-equal system-type "windows-nt") "c:/Python32/python.exe" "python3"))
            ("rb" . "ruby")
            ("js" . "node") ; node.js
            ("sh" . "bash")
            ;; ("clj" . "java -cp /home/xah/apps/clojure-1.6.0/clojure-1.6.0.jar clojure.main")
            ("ml" . "ocaml")
            ("vbs" . "cscript")
            ("tex" . "pdflatex")
            ("lua" . "lua")
            ;; ("pov" . "/usr/local/bin/povray +R2 +A0.1 +J1.2 +Am2 +Q9 +H480 +W640")
            ))
         (ξfname (buffer-file-name))
         (ξfSuffix (file-name-extension ξfname))
         (ξprog-name (cdr (assoc ξfSuffix ξsuffix-map)))
         (ξcmd-str (concat ξprog-name " \""   ξfname "\"")))

    (when (buffer-modified-p)
      (when (y-or-n-p "Buffer modified. Do you want to save first?")
        (save-buffer)))

    (if (string-equal ξfSuffix "el") ; special case for emacs lisp
        (load ξfname)
      (if ξprog-name
          (progn
            (message "Running…")
            (async-shell-command ξcmd-str "*pan/run-current-file output*"))
        (message "No recognized program file suffix for this file.")))))

(defun pan/now ()
  (interactive)
  (insert (format-time-string "%Y-%m-%d %H:%m"))
  )


(defun pan/today ()
  (interactive)
  (insert (format-time-string "%A, %B %e, %Y"))
  )
(defun pan/goto-match-paren (arg)
  "Go to the matching  if on (){}[], similar to vi style of % "
  (interactive "p")
  ;; first, check for "outside of bracket" positions expected by forward-sexp, etc
  (cond ((looking-at "[\[\(\{]") (evil-jump-item))
        ((looking-back "[\]\)\}]" 1) (evil-jump-item))
        ;; now, try to succeed from inside of a bracket
        ((looking-at "[\]\)\}]") (forward-char) (evil-jump-item))
        ((looking-back "[\[\(\{]" 1) (backward-char) (evil-jump-item))
        (t nil)))

(defvar my-tags-updated-time nil)

(defun my-auto-update-tags-when-save (prefix)
  (interactive "P")
  (cond
   ((not my-tags-updated-time)
    (setq my-tags-updated-time (current-time)))

   ((and (not prefix)
         (< (- (float-time (current-time)) (float-time my-tags-updated-time)) 300))
    ;; < 300 seconds
    (message "no need to update the tags")
    )
   (t
    (setq my-tags-updated-time (current-time))
    (my-update-tags)
    (message "updated tags after %d seconds." (- (float-time (current-time)) (float-time my-tags-updated-time))))))

    (defun pan/copy-buff-file-name-as-kill (choice)
      "Copy the buffer file name to kill-rings"
      (interactive "cCopy Buffer Name (F) Full, (D) Directory, (N) Name, (M) MarkdownMode")
      (let ((new-kill-string)
            (name (if (eq major-mode 'dired-mode)
                      (dired-get-filename)
                      (or (buffer-file-name) "")
            ))
      )
      (cond ((eq choice ?f)
             (setq new-kill-string name)
      )
            ((eq choice ?d) (setq new-kill-string (file-name-directory name)))
            ((eq choice ?n) (setq new-kill-string (file-name-nondirectory name)))
            ((eq choice ?m) (setq new-kill-string (substring (file-name-nondirectory name) 11)))
            (t (message "Qite"))
            )
      (when new-kill-string
        (message "%s copied" new-kill-string)
        (kill-new new-kill-string)
      )
      )
   )

(defun pan/dired-create-file (file )
  "create md file: %Y-%m-%d-file.md in current dir"
  (interactive "sInput file name: ")
  (let (
    (file_name (concat (format-time-string "%Y-%m-%d-") file ".md")))
    (message "create file name : %s"  file_name)
    (write-region "" nil file_name)
  )
)

;; 调用该函数在自动保存c-c++文件时，会检测.clang-format函数，有则自动排版，没有则不
(defun pan/clang-format-buffer-smart ()
  "Reformat buffer if .clang-format exists in the projectile root."
  (interactive)
  (when (f-exists? (expand-file-name ".clang-format" (projectile-project-root)))
    (clang-format-buffer)))

;;
(defun pan/org-todo-at-date (date)
  (interactive (list (org-time-string-to-time (org-read-date))))
  (cl-flet ((org-current-effective-time (&rest t) date)
            (org-today (&rest r) (time-to-days date)))
    (cond ((eq major-mode 'org-mode) (org-todo))
          ((eq major-mode 'org-agenda-mode) (org-agenda-mode)))))

(defun pan/org-agenda-done (&optional arg)
  "Mark current TODO as done.
This changes the line at point, all other lines in the agenda referring to the same tree node, and the headline of the tree node in the org-mode file"
  (interactive "P")
  (org-agenda-todo "DONE"))
