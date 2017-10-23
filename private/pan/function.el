;; fix for tab indent
(defun zilongshanren/indent-region(numSpaces)
  (progn
                                        ; default to start and end of current line
    (setq regionStart (line-beginning-position))
    (setq regionEnd (line-end-position))

                                        ; if there's a selection, use that instead of the current line
    (when (use-region-p)
      (setq regionStart (region-beginning))
      (setq regionEnd (region-end))
      )

    (save-excursion                          ; restore the position afterwards
      (goto-char regionStart)                ; go to the start of region
      (setq start (line-beginning-position)) ; save the start of the line
      (goto-char regionEnd)                  ; go to the end of region
      (setq end (line-end-position))         ; save the end of the line

      (indent-rigidly start end numSpaces) ; indent between start and end
      (setq deactivate-mark nil)           ; restore the selected region
      )
    )
)

;; 快速替换，选中需要替换的文本， c-r调用函数
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

;; 搜索项目
(defun zilongshanren/open-file-with-projectile-or-counsel-git ()
  (interactive)
  (if (zilongshanren/git-project-root)
      (counsel-git)
    (if (projectile-project-p)
        (projectile-find-file)
      (counsel-file-jump))))
(spacemacs/set-leader-keys "pf" 'zilongshanren/open-file-with-projectile-or-counsel-git)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
