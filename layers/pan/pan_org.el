
;; learn org
(add-hook 'org-mode-hook
          (lambda ()
            (set (make-local-variable 'company-backends) '( auto-complete   company-files  company-dabbrev ))
            (spacemacs/set-leader-keys (kbd "os") 'org-schedule)
            (spacemacs/set-leader-keys (kbd "od") 'org-deadline)
            (local-unset-key (kbd "s-l"))
            (local-unset-key (kbd "s-n"))
            (local-unset-key (kbd "s-j"))
            (local-unset-key (kbd "s-k"))
            (define-key evil-insert-state-map (kbd "s-j") 'next-line)
            (define-key evil-insert-state-map (kbd "s-k") 'previous-line)
            (define-key evil-insert-state-map (kbd "s-l") 'right-char)
            (define-key evil-insert-state-map (kbd "s-h") 'left-char)
            ))

(add-hook 'org-mode-hook 'org-indent-mode)

(spacemacs/set-leader-keys (kbd "oc") 'org-capture)
(spacemacs/set-leader-keys (kbd "oa") 'org-agenda)
(setq org-agenda-files '("~/workspace/org/agenda/"))
(setq org-agenda-dir '("~/workspace/org/agenda/"))
(setq org-dir '("~/workspace/org/"))

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
  (define-key org-mode-map (kbd "s-g t") 'org-set-tags)
  )

(with-eval-after-load 'org-agenda
  (define-key org-agenda-mode-map (kbd "P") 'org-pomodoro)
  (define-key org-mode-map (kbd "s-g t") 'org-set-tags)
  (spacemacs/set-leader-keys-for-major-mode 'org-agenda-mode
    "." 'spacemacs/org-agenda-transient-state/body)
)
(defun imalison:join-paths (root &rest dirs)
  (let ((result root))
    (cl-loop for dir in dirs do
             (setq result (concat (file-name-as-directory result) dir)))
    result))
(defvar imalison:created-property-string
  "
  :PROPERTIES:
  :CREATED: %U
  :END:")


;;(setq org-projectile-projects-file (expand-file-name "project.org" "~/workspace/org/agenda/"))
          ;; org-projectile-capture-template
          ;; (format "%s%s" "* TODO %?" imalison:created-property-string))
    ;;(add-to-list 'org-capture-templates
   ;;              (org-projectile-project-todo-entry
     ;;             :capture-character "p"
       ;;           :capture-heading "Linked Project TODO"))
    ;;(add-to-list 'org-capture-templates
      ;;           (org-projectile-project-todo-entry
        ;;          :capture-character "m"))

;;(require 'org-projectile)
(setq-default dotspacemacs-configuration-layers
              '((org :variables org-projectile-file "TODOS.org")))
;; (with-eval-after-load 'org-agenda
;;   (require 'org-projectile)
;;   (push (org-projectile:todo-files) org-agenda-files))
