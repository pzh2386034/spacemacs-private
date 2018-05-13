
;; learn org
(add-hook 'org-mode-hook
          (lambda ()
            (set (make-local-variable 'company-backends) '( auto-complete   company-files  company-dabbrev ))
            (spacemacs/set-leader-keys (kbd "os") 'org-schedule)
            (spacemacs/set-leader-keys (kbd "od") 'org-deadline)
            (local-unset-key (kbd "M-l"))
            (local-unset-key (kbd "M-n"))
            (local-unset-key (kbd "M-j"))
            (local-unset-key (kbd "M-k"))
            (define-key evil-insert-state-map (kbd "M-j") 'next-line)
            (define-key evil-insert-state-map (kbd "M-k") 'previous-line)
            (define-key evil-insert-state-map (kbd "M-l") 'right-char)
            (define-key evil-insert-state-map (kbd "M-h") 'left-char)
            ))

(add-hook 'org-mode-hook 'org-indent-mode)

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

(with-eval-after-load 'org-agenda
  (define-key org-agenda-mode-map (kbd "P") 'org-pomodoro)
  (spacemacs/set-leader-keys-for-major-mode 'org-agenda-mode
    "." 'spacemacs/org-agenda-transient-state/body)
)
