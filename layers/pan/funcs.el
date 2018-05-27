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
(defun occur-dwim ()
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

(spacemacs/set-leader-keys  "so" 'occur-dwim) 

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

;;;;;;;;;;;;;;;;;;;  funs  for  dired   ;;;;;;;;;;;;;;;;;;;;;;;;;;
(setq dired-guess-shell-alist-user
      '(("\\.pdf\\'" "evince" "okular")
        ("\\.\\(?:djvu\\|eps\\)\\'" "evince")
        ("\\.\\(?:jpg\\|jpeg\\|png\\|gif\\|xpm\\)\\'" "eog")
        ("\\.\\(?:xcf\\)\\'" "gimp")
        ("\\.csv\\'" "libreoffice")
        ("\\.tex\\'" "pdflatex" "latex")
        ("\\.\\(?:mp4\\|mkv\\|avi\\|flv\\|ogv\\)\\(?:\\.part\\)?\\'"
         "vlc")
        ("\\.\\(?:mp3\\|flac\\)\\'" "rhythmbox")
        ("\\.html?\\'" "firefox")
        ("\\.cue?\\'" "audacious")))
;; progress start by Emacs can continue running even when emacs is closed
(require 'dired-aux)
(defvar dired-filelist-cmd
  '(("vlc" "-L")))

(defun dired-start-process (cmd &optional file-list)
  (interactive
   (let ((files (dired-get-marked-files
                 t current-prefix-arg)))
     (list
      (dired-read-shell-command "& on %s: "
                                current-prefix-arg files)
      files)))
  (let (list-switch)
    (start-process
     cmd nil shell-file-name
     shell-command-switch
     (format
      "nohup 1>/dev/null 2>/dev/null %s \"%s\""
      (if (and (> (length file-list) 1)
               (setq list-switch
                     (cadr (assoc cmd dired-filelist-cmd))))
          (format "%s %s" cmd list-switch)
        cmd)
      (mapconcat #'expand-file-name file-list "\" \"")))))
(define-key dired-mode-map "s" 'dired-start-process)

;; File sizes in dired
(defun dired-get-size ()
  (interactive)
  (let ((files (dired-get-marked-files)))
    (with-temp-buffer
      (apply 'call-process "/usr/bin/du" nil t nil "-sch" files)
      (message
       "Size of all marked files: %s"
       (progn
         (re-search-backward "\\(^[ 0-9.,]+[A-Za-z]+\\).*total$")
 (match-string 1))))))

(define-key dired-mode-map (kbd "?") 'dired-get-size)
;; 
(defun terminal ()
  "Switch to terminal. Launch if nonexistent."
  (interactive)
  (if (get-buffer "*ansi-term*")
      (switch-to-buffer "*ansi-term*")
    (ansi-term "/bin/bash"))
  (get-buffer-process "*ansi-term*"))

(defalias 'tt 'terminal)
(define-key dired-mode-map (kbd "`") 'dired-open-term)

(defun dired-open-term ()
  "Open an `ansi-term' that corresponds to current directory."
  (interactive)
  (let ((current-dir (dired-current-directory)))
    (term-send-string
     (terminal)
     (if (file-remote-p current-dir)
         (let ((v (tramp-dissect-file-name current-dir t)))
           (format "ssh %s@%s\n"
                   (aref v 1) (aref v 2)))
       (format "cd '%s'\n" current-dir)))))
(defun named-term (name)
  (interactive "sName: ")
  (ansi-term "/bin/bash" name))

(define-key dired-mode-map "i" 'ido-find-file)
(define-key dired-mode-map (kbd "%^") 'dired-flag-garbage-files)
(setq dired-garbage-files-regexp
      "\\.idx\\|\\.run\\.xml$\\|\\.bbl$\\|\\.bcf$\\|.blg$\\|-blx.bib$\\|.nav$\\|.snm$\\|.out$\\|.synctex.gz$\\|\\(?:\\.\\(?:aux\\|bak\\|dvi\\|log\\|orig\\|rej\\|toc\\|pyg\\)\\)\\'")
(define-key dired-mode-map "F" 'find-name-dired)

(define-key dired-mode-map (kbd "M-o") 'dired-omit-mode)
(setq dired-omit-files "\\(?:.*\\.\\(?:aux\\|log\\|synctex\\.gz\\|run\\.xml\\|bcf\\|am\\|in\\)\\'\\)\\|^\\.\\|-blx\\.bib")

(define-key dired-mode-map "a"
  (lambda ()
    (interactive)
    (find-alternate-file "..")))

(eval-after-load "term"
  '(define-key term-raw-map (kbd "C-c C-y") 'term-paste))
;; 重用buffer
(put 'dired-find-alternate-file 'disabled nil)
(define-key dired-mode-map (kbd "RET") 'dired-find-alternate-file)
(setq dired-recursive-deletes 'always)
(setq dired-recursive-copies 'always)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;   end  for  dired   ;;;;;;;;;;;;;;;;;;;;;;;;;;
