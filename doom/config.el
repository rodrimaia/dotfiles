;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "John Doe"
      user-mail-address "john@doe.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
(setq doom-font (font-spec :family "Fira Code" :size 13))
      ;;doom-variable-pitch-font (font-spec :family "sans" :size 15))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-outrun-electric)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/notas/")

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

(map! :leader
      :desc "Open like spacemacs" "SPC" #'counsel-M-x)

(setq doom-localleader-key ",")

;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.
;;
;;
(setq swiper-use-visual-line-p (lambda (_) nil))


(map! :leader "TAB" 'evil-switch-to-windows-last-buffer)
(map! :leader "w /" 'evil-window-vsplit)
(map! :leader "w -" 'evil-window-split)
(map! :leader "j" 'evilem-motion-find-char)
(map! :after evil-org
      :map evil-org-mode-map
      :n "t" #'org-todo)

(setq treemacs-follow-mode t)
(setq treemacs-display-current-project-exclusively t)

(setq projectile-enable-caching nil)

(defun spacemacs/set-leader-keys (key command)
  (map! :leader key command))

(toggle-frame-maximized)

(setq-default evil-escape-key-sequence "fd")
(setq-default evil-escape-delay 0.2)

(super-save-mode +1)

(defun doom/ediff-init-and-example ()
  "ediff the current `init.el' with the example in doom-emacs-dir"
  (interactive)
  (ediff-files (concat doom-private-dir "init.el")
               (concat doom-emacs-dir "init.example.el")))

(define-key! help-map
  "di"   #'doom/ediff-init-and-example
  )

(setq
   typescript-indent-level 2
   web-mode-code-indent-offset 2)

(after! javascript
  (setq
   standard-indent 2
   typescript-indent-level 2
   web-mode-code-indent-offset 2
   ))

(after! org
  (setq
   ;; set up org mode
   org-confirm-babel-evaluate nil
   org-log-done 'time
   org-startup-indented t
   org-startup-folded "content"
   org-directory "~/notas"
   org-enable-org-journal-support t
   org-journal-dir "~/notas/journal/"
   org-journal-date-format "%A, %B %d %Y"
   org-journal-file-format "%Y%m%d.org"
   org-agenda-span 5
   org-agenda-todo-ignore-scheduled 'future  ;; Ignore todos for 5 days in the future
   org-agenda-todo-ignore-timestamp 5  ;; Ignore todos for 5 days in the future
   org-agenda-tags-todo-honor-ignore-options t
   org-agenda-include-diary t
   org-agenda-show-future-repeats nil
   org-agenda-skip-scheduled-if-done t
   org-agenda-skip-deadline-if-done t
   org-agenda-skip-scheduled-if-deadline-is-shown t
   org-agenda-start-on-weekday nil
   org-agenda-start-with-follow-mode nil
   org-agenda-todo-ignore-deadlines (quote far)
   org-agenda-todo-ignore-scheduled (quote far)
   org-enforce-todo-dependencies t
   org-want-todo-bindings t
   org-journal-time-prefix "** "
   org-agenda-span 5 ;; show how many days in agenda
   org-todo-keywords '((sequence "TODO(t)" "WAITING(w)" "|" "DONE(d)" "SKIP(k)" "CANCELLED(c)"))
   org-todo-keywords-for-agenda '((sequence "TODO(t)" "WAITING(w)" "|" "DONE(d)" "SKIP(k)" "CANCELLED(c)"))
   org-agenda-window-setup 'reorganize-frame
   org-agenda-block-separator (string-to-char " "))

  (setq org-modules '(org-bbdb
                      org-gnus
                      org-checklist
                      org-drill
                      org-info
                      org-jsinfo
                      ;;org-habit
                      org-irc
                      org-mouse
                      org-protocol
                      org-annotate-file
                      org-eval
                      org-expiry
                      org-interactive-query
                      org-man
                      org-collector
                      org-panel
                      org-screen
                      org-toc))
  (eval-after-load 'org
    '(org-load-modules-maybe t))
  ;; Prepare stuff for org-export-backends
  (setq org-export-backends '(org latex icalendar html ascii))

  ;; org-reveal
  (setq org-enable-reveal-js-support t
        org-reveal-root "file:///Users/rodrigo/projects/reveal.js" )

  ;; disable holidays
  (setq
   holiday-bahai-holidays nil
   holiday-hebrew-holidays nil
   holiday-islamic-holidays nil
   )


  ;; org-habit
  (setq org-habit-following-days 4)
  (setq org-habit-show-all-today nil) ;; show completed tasks too
  (setq org-habit-show-habits-only-for-today t) ;;show habits only today ( not in the future days)

  ;; gtd in org-mode https://emacs.cafe/emacs/orgmode/gtd/2017/06/30/orgmode-gtd.html

  (setq org-agenda-files '(
                           "~/notas/inbox.org"
                           "~/notas/gtd.org"
                           "~/notas/saude.org"
                           "~/notas/trabalho.org"
                           "~/notas/tickler.org"))

  (setq diary-file "~/notas/diario.org")

  (defun org-journal-find-location ()
    ;; Open today's journal, but specify a non-nil prefix argument in order to
    ;; inhibit inserting the heading; org-capture will insert the heading.
    (org-journal-new-entry t)
    ;; Position point on the journal's top-level heading so that org-capture
    ;; will add the new entry as a child entry.
    (goto-char (point-min)))


  ;;(spacemacs/declare-prefix "aj" "journal")
  (spacemacs/set-leader-keys
   "ajj" 'org-journal-new-entry)


  (setq org-capture-templates '(("t" "Todo [Outros]" entry
                                 (file+headline "~/notas/gtd.org" "Outros")
                                 "* TODO %i%?")
                                ("T" "Tickler" entry
                                 (file+headline "~/notas/tickler.org" "Tickler")
                                 "* %i%? \n %U")
                                ("w" "Revisão semanal" entry (function org-journal-find-location) (file "~/notas/templates/weekly-review.org"))
                                ))


  ;; Show parent prefix on task name
  (setq org-agenda-prefix-format '((agenda . " %i %-12:c%?-12t% s")
                                   (timeline . "  % s")
                                   (todo .
                                         " %i %-12c %(concat \" \"(org-format-outline-path (org-get-outline-path)) \" >\") ")
                                   (tags .
                                         " %i %-12c %(concat \" \"(org-format-outline-path (org-get-outline-path)) \" >\") ")
                                   (search . " %i %-12:c"))
        )

  (setq org-refile-targets '((org-agenda-files :maxlevel . 3)
                             ("~/notas/someday.org" :level . 1)
                             ("~/notas/trash.org" :level . 1)
                             ))

  (setq org-refile-use-outline-path 'file)
  (setq org-outline-path-complete-in-steps nil)
  (setq org-refile-allow-creating-parent-nodes 'confirm)
  ;; explanation: https://blog.aaronbieber.com/2017/03/19/organizing-notes-with-refile.html

  (setq org-agenda-custom-commands
        '(("n" "Agenda and all TODOs"
           ((agenda ""
                    (
                     (org-agenda-start-day "+0d")
                     (org-agenda-overriding-header "⚡ Schedule:\n")
                     (org-agenda-current-time-string "⮜┈┈┈┈┈┈┈ now")
                     (org-agenda-prefix-format "  %-12c%?-12t% s")
                     )
                    )
            (alltodo "INBOX"
                     (
                      (org-agenda-overriding-header "Para Processar")
                      (org-agenda-files '("~/notas/inbox.org")))
                     )
            (tags-todo "-TODO/!TODO"
                       ((org-agenda-overriding-header "⚡ Tasks:\n")
                        (org-agenda-skip-function 'my-org-agenda-skip-all-siblings-but-first)))

            (tags-todo "-TODO/!TODO"
                       ((org-agenda-overriding-header "⚡ Projetos Pessoais:\n")
                        (org-agenda-skip-function 'my-org-agenda-skip-all-siblings-but-first)
                        (org-agenda-files '("~/notas/projetos.org"))))
            (todo "WAITING"
                  ((org-agenda-overriding-header "⚡ Esperando:\n")) )
            ))))

  (defun my-org-agenda-skip-all-siblings-but-first ()
    "Skip all but the first non-done entry."
    (let (should-skip-entry)
      (unless (org-current-is-todo)
        (setq should-skip-entry t))
      (save-excursion
        (while (and (not should-skip-entry) (org-goto-sibling t) (not (org-current-is-heading-outros)))
          (when (or (org-current-is-todo) (org-current-is-waiting))
            (setq should-skip-entry t))))
      (when should-skip-entry
        (or (outline-next-heading)
            (goto-char (point-max))))))

  (defun org-current-is-heading-outros ()
    (string= (car (org-get-outline-path)) "Outros"))

  (defun org-current-is-first-pending-in-project ()
    (let (is-not-first-todo)
      (save-excursion
        (while (org-goto-sibling t)
          (if (org-current-is-todo)
              (setq is-not-first-todo t))))
      (not is-not-first-todo)))

  (defun org-current-is-first-heading ()
    (not (org-get-outline-path)))

  (defun org-current-is-habit ()
    (string= (org-entry-get nil "STYLE") "habit"))

  (defun org-current-is-todo ()
    (string= "TODO" (org-get-todo-state)))

  (defun org-current-is-waiting ()
    (string= "WAITING" (org-get-todo-state)))

  (defun org-agenda-delete-empty-blocks ()
    "Remove empty agenda blocks.
  A block is identified as empty if there are fewer than 2
  non-empty lines in the block (excluding the line with
  `org-agenda-block-separator' characters)."
    (when org-agenda-compact-blocks
      (user-error "Cannot delete empty compact blocks"))
    (setq buffer-read-only nil)
    (save-excursion
      (goto-char (point-min))
      (let* ((blank-line-re "^\\s-*$")
             (content-line-count (if (looking-at-p blank-line-re) 0 1))
             (start-pos (point))
             (block-re (format "%c\\{10,\\}" org-agenda-block-separator)))
        (while (and (not (eobp)) (forward-line))
          (cond
           ((looking-at-p block-re)
            (when (< content-line-count 2)
              (delete-region start-pos (1+ (point-at-bol))))
            (setq start-pos (point))
            (forward-line)
            (setq content-line-count (if (looking-at-p blank-line-re) 0 1)))
           ((not (looking-at-p blank-line-re))
            (setq content-line-count (1+ content-line-count)))))
        (when (< content-line-count 2)
          (delete-region start-pos (point-max)))
        (goto-char (point-min))
        ;; The above strategy can leave a separator line at the beginning
        ;; of the buffer.
        (when (looking-at-p block-re)
          (delete-region (point) (1+ (point-at-eol))))))
    (setq buffer-read-only t))

  (add-hook 'org-agenda-finalize-hook #'org-agenda-delete-empty-blocks)

  (defun open-gtd-file ()
    (interactive)
    (find-file "~/notas/gtd.org"))
  (spacemacs/set-leader-keys "og" 'open-gtd-file)

  (defun rodrigomaia17-org-agenda-show-agendas ()
    (interactive)
    (org-agenda nil "n"))
  )


(spacemacs/set-leader-keys "a n" 'rodrigomaia17-org-agenda-show-agendas)

;; Global key for org-mode
;; org-mode helps me more than help-command :P
(global-set-key (kbd "<f1>") 'rodrigomaia17-org-agenda-show-agendas)
(global-set-key (kbd "<f5>") 'org-capture)

(defun org-todo-with-date (&optional arg)
  (interactive "P")
  (cl-letf* ((org-read-date-prefer-future nil)
             (my-current-time (org-read-date t t nil "when:" nil nil nil))
             ((symbol-function #'org-current-effective-time)
              #'(lambda () my-current-time)))
    (org-todo arg)
    ))

(add-hook 'org-mode-hook #'toggle-word-wrap)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("912cac216b96560654f4f15a3a4d8ba47d9c604cbc3b04801e465fb67a0234f0" default)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
