;;; packages.el --- pan layer packages file for Spacemacs.
(provide 'init-keymaps)

;;; ==========================global key band=====================================
(global-set-key (kbd "M-a") 'mark-whole-buffer)
(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "C-\\") 'highlight-symbol-at-point)
(global-set-key (kbd "RET") 'newline-and-indent)
(global-set-key (kbd "M-j") 'other-window)
(global-set-key (kbd "M-s") 'save-buffer)
(global-set-key (kbd "M-W") 'split-window-below-and-focus)
(global-set-key (kbd "M-w") 'split-window-right-and-focus)
;;(global-set-key (kbd "M-m") 'ido-imenu)
(global-set-key (kbd "M-q") 'quit-window)
;;(global-set-key (kbd "M-W") 'only-current-buffer)
;;(global-set-key (kbd "M-q") 'save-buffers-kill-emacs)
;;(global-set-key (kbd "<f8>") 'magit-blame-mode)
(global-set-key (kbd "M-.") 'etags-select-find-tag)
(global-set-key (kbd "M-o") 'occur)
(global-set-key (kbd "<f3>") 'flycheck-list-errors)
(global-set-key (kbd "M-s-o") 'multi-occur)
(global-set-key (kbd "M-v") 'evil-paste-after)
(global-set-key (kbd "M-n") 'next-error)
;;(global-set-key (kbd "M-P") 'session-jump-to-last-change)
(global-set-key (kbd "M-p") 'previous-error)
(global-set-key (kbd "M-j") 'evil-window-next)
(global-set-key (kbd "C-SPC") 'comment-or-uncomment-region)
(global-set-key (kbd "M-t") 'projectile-find-file-other-window)
(global-set-key (kbd "C-p") 'switch-to-lOCAL-project)
(global-set-key (kbd "M-`") 'other-frame)
(global-set-key (kbd "C-c t") 'terminal)
(global-set-key (kbd "C-c T") 'named-term)
(global-set-key (kbd "C-h C-f") 'find-function)
(global-set-key (kbd "C-h C-v") 'find-variable)
(global-set-key (kbd "C-h C-k") 'find-function-on-key)
(global-set-key (kbd "C-'") 'dired-jump)
(setq auto-save-default nil)
(setq make-backup-files nil)
(spacemacs/set-leader-keys (kbd "dw") 'delete-other-windows)
(global-set-key (kbd "C-d") 'delete-forward-char)

;;(define-key evil-insert-state-map (kbd "C-c C-t") 'ansi-term)
(setq kimim-color-list '(hi-yellow hi-green hi-blue hi-pink))
(setq kimim-color-index 0)
(setq kimim-color-list-length (length kimim-color-list))

(defun kimim/toggle-highlight-tap ()
  "Toggle highlight pattern at the point"
  (interactive)
  (if (and (listp (get-text-property (point) 'face))
           (memq (car (get-text-property (point) 'face)) kimim-color-list))
      (unhighlight-regexp (thing-at-point 'symbol))
    (progn
      (highlight-regexp (thing-at-point 'symbol) (nth kimim-color-index kimim-color-list))
      (setq kimim-color-index (+ kimim-color-index 1))
      (if (>= kimim-color-index kimim-color-list-length)
          (setq kimim-color-index 0))
      )))

(global-set-key [f8] 'kimim/toggle-highlight-tap)

(add-hook 'LaTeX-mode-hook 
          (lambda()
            (add-to-list 'TeX-command-list '("XeLaTeX" "%`xelatex%(mode)%' %t" TeX-run-TeX nil t))
            (setq TeX-command-default "XeLaTeX")
            (setq TeX-save-query nil)
            (setq TeX-show-compilation t)))

;; dired-mode go back to last document
;; (add-hook 'dired-mode-hook
;;          (lambda ()
;;            (define-key dired-mode-map (kbd "i")
;;              (lambda ()
;;                (interactive)
;;                (find-alternate-file "..")))))


(defconst pan-packages
  '(
    fcitx
    youdao-dictionary
    elpy
    )
)
(defun pan/init-elpy ()
  (use-package elpy
    :defer t
    :init
    (elpy-enable)
    ))
(defun pan/init-fcitx ()
  (use-package fcitx
    :defer t
    :init
    (setq  fcitx-active-evil-states '(insert emacs hybrid))
    ))
(defun pan/init-youdao-dictionary ()
  (use-package youdao-dictionary
    :defer t
    :init
    (spacemacs/set-leader-keys "oy" 'youdao-dictionary-search-at-point+)
    )
  )
;; ======================================dired mode key-binding====================================
;; add `flet'
(require 'cl)

(defadvice save-buffers-kill-emacs
    (around no-query-kill-emacs activate)
  "Prevent \"Active processes exist\" query on exit."
  (flet ((process-list ())) ad-do-it))
;; guess programs by file extensions
(require 'dired-x)

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
(define-key dired-mode-map "r" 'dired-start-process)

;; Ediff configuration
(defmacro csetq (variable value)
  `(funcall (or (get ',variable 'custom-set)
                'set-default)
            ',variable ,value))
(csetq ediff-window-setup-function 'ediff-setup-windows-plain)
(csetq ediff-split-window-function 'split-window-horizontally)
(defun ora-ediff-hook ()
  (ediff-setup-keymap)
  (define-key ediff-mode-map "j" 'ediff-next-difference)
  (define-key ediff-mode-map "k" 'ediff-previous-difference))

(add-hook 'ediff-mode-hook 'ora-ediff-hook)

;; Restoring the windows after Ediff quits
(winner-mode)
(add-hook 'ediff-after-quit-hook-internal 'winner-undo)
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
;;; packages.el ends here
;; (provide 'my-feature)
;; (require 'my-feature)
;; (push "/some/path" load-path) spc h d v load-path check result

;; 重用buffer
(put 'dired-find-alternate-file 'disabled nil)
(define-key dired-mode-map (kbd "RET") 'dired-find-alternate-file)
(setq dired-recursive-deletes 'always)
(setq dired-recursive-copies 'always)
;;(with-eval-after-load 'dired
;;  (define-key dired-mode-map (kbd "RET") 'dired-find-alternate-file))
;; =========================================config for magit====================================== 
;;(global-set-key (kbd "g s") 'magit-status)


;; learn org
(add-hook 'org-mode-hook
          (lambda ()
            (spacemacs/set-leader-keys (kbd "os") 'org-schedule)
            (spacemacs/set-leader-keys (kbd "od") 'org-deadline)
            ))
(spacemacs/set-leader-keys (kbd "oc") 'org-capture)
(spacemacs/set-leader-keys (kbd "oa") 'org-agenda)
(setq org-agenda-files '("~/workspace/org/agenda/"))
(setq org-agenda-dir '("~/workspace/org/agenda/"))

(setq org-agenda-file-note (expand-file-name "notes.org" "~/workspace/org/agenda/"))

(setq org-agenda-file-finance (expand-file-name "finance.org" "~/workspace/org/agenda/"))
(setq org-agenda-file-emacs (expand-file-name "emacs.org" "~/workspace/org/agenda/"))
(setq org-agenda-file-gtd (expand-file-name "gtd.org" "~/workspace/org/agenda/"))
(setq org-agenda-file-journal (expand-file-name "journal.org" "~/workspace/org/agenda/"))
(setq org-agenda-file-code-snippet (expand-file-name "snippet.org" "~/workspace/org/agenda/"))
(setq org-default-notes-file (expand-file-name "gtd.org" "~/workspace/org/agenda/"))
 (setq org-capture-templates
            '(("t" "Todo" entry (file+headline org-agenda-file-gtd "Workspace")
               "* TODO [#B] %?\n  %i\n"
               :empty-lines 1)
              ("n" "notes" entry (file+headline org-agenda-file-note "Quick notes")
               "* %?\n  %i\n %U"
               :empty-lines 1)
              ("f" "finance" entry (file+headline org-agenda-file-finance "finance notes")
               "* %?\n  %i\n %U"
               :empty-lines 1)
              ("s" "spacemacs" entry (file+headline org-agenda-file-emacs "spacemacs notes")
               "* %?\n  %i\n %U"
               :empty-lines 1)
              ("b" "Blog Ideas" entry (file+headline org-agenda-file-note "Blog Ideas")
               "* TODO [#B] %?\n  %i\n %U"
               :empty-lines 1)
              ("s" "Code Snippet" entry
               (file org-agenda-file-code-snippet)
               "* %?\t%^g\n#+BEGIN_SRC %^{language}\n\n#+END_SRC")
              ("w" "work" entry (file+headline org-agenda-file-gtd "Cocos2D-X")
               "* TODO [#A] %?\n  %i\n %U"
               :empty-lines 1)
              ("c" "Chrome" entry (file+headline org-agenda-file-note "Quick notes")
               "* TODO [#C] %?\n %(zilongshanren/retrieve-chrome-current-tab-url)\n %i\n %U"
               :empty-lines 1)
              ("l" "links" entry (file+headline org-agenda-file-note "Quick notes")
               "* TODO [#C] %?\n  %i\n %a \n %U"
               :empty-lines 1)
              ("j" "Journal Entry"
               entry (file+datetree org-agenda-file-journal)
               "* %?"
:empty-lines 1)))

(with-eval-after-load 'org
;;(require 'org-install)
;;(require 'org-pomodoro)
;;(require 'ob-tangle)
;;(org-babel-load-file (expand-file-name "literConfig.org" "/home/hadoop2/.spacemacs.d/private/pan/"))
)
(with-eval-after-load 'org-agenda
(define-key org-agenda-mode-map (kbd "P") 'org-pomodoro)
(spacemacs/set-leader-keys-for-major-mode 'org-agenda-mode
  "." 'spacemacs/org-agenda-transient-state/body)
)

;; configure for search
(spacemacs/set-leader-keys "sp" 'helm-ag-project-root)
;; c-c c-e edit helm-ag result
(add-hook 'js2-mode-hook 'flycheck-mode)
(add-hook 'python-mode-hook 'flycheck-mode)
;; use flycheck-list-errors to display all error

;; yas snippet learn

;;(require 'yasnippet)
;;(yas-global-mode 1)

;; (setq yas-snippet-dirs "~/.spacemacs.d/private/snippets")
;; (yas-reload-all)
;; (add-hook 'prog-mode-hook #'yas-minor-mode)
;; learn evil
;; 1. evil normal state
;; 1. evil insert state
;; 1. evil visual state
;; 1. evil motion state
;; 1. evil emacs state
;; 1. evil operate state

(with-eval-after-load 'evil
  (define-key evil-normal-state-map (kbd ",/") 'evilnc-comment-or-uncomment-lines)
  (define-key evil-visual-state-map (kbd ",/") 'evilnc-comment-or-uncomment-lines)
  )
;; leanrn anacoda mode
(add-hook 'python-mode-hook
          (lambda ()
            (set (make-local-variable 'company-backends) '(company-anaconda company-dabbrev))
            (spacemacs/set-leader-keys "or" 'anaconda-mode-find-references)
            (spacemacs/set-leader-keys "om" 'anaconda-mode-complete)
            (spacemacs/set-leader-keys "od" 'anaconda-mode-find-definitions)
            (spacemacs/set-leader-keys "os" 'anaconda-mode-find-assignments)
            (spacemacs/set-leader-keys "ob" 'anaconda-mode-go-back)
            (spacemacs/set-leader-keys "oh" 'anaconda-mode-show-doc)
            ))
;;(define-key python-mode-hook (kbd ""))
;; (add-hook 'python-mode-hook 'anaconda-mode)
(add-hook 'python-mode-hook 'eldoc-mode)


;; 搜索相关配置
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

(defun zilongshanren/open-file-with-projectile-or-counsel-git ()
 (interactive)
 (if (zilongshanren/git-project-root)
     (counsel-git)
   (if (projectile-project-p)
       (projectile-find-file)
     (counsel-file-jump))))
(spacemacs/set-leader-keys "pf" 'zilongshanren/open-file-with-projectile-or-counsel-git)
;;(evilified-state-evilify-map occur-mode-map
 ;; :mode occur-mode)
;; learn tags
(defvar my-tags-updated-time nil)
(defun my-create-tags-if-needed (SRC-DIR &optional FORCE)
  "return the full path of tags file"
  (let ((dir (file-name-as-directory (file-truename SRC-DIR)))
        file)
    (setq file (concat dir "TAGS"))
    (when (spacemacs/system-is-mswindows)
      (setq dir (substring dir 0 -1)))
    (when (or FORCE (not (file-exists-p file)))
      (message "Creating TAGS in %s ..." dir)
      (shell-command
       (format "ctags -f %s -e -R %s" file dir)))
    file))
(defun my-update-tags ()
  (interactive)
  "check the tags in tags-table-list and re-create it"
  (dolist (tag tags-table-list)
    (my-create-tags-if-needed (file-name-directory tag) t)))

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


(spacemacs/set-leader-keys "ot" 'my-auto-update-tags-when-save)

;; self define function
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
;; mimic "nzz"behavious in vim, but sense no use
(defadvice evil-search-next (after advice-for-evil-search-next activate)
  (evil-scroll-line-to-center (line-number-at-pos)))

(defadvice evil-search-previous (after advice-for-evil-search-previous activate)
  (evil-scroll-line-to-center (line-number-at-pos)))
