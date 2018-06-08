(setq
 ;; set up org mode
 org-log-done 'time
 org-startup-indented t
 org-startup-folded "content"
 org-directory "~/notas"
 org-enable-org-journal-support t org-journal-dir "~/notas/journal/"
 org-journal-date-format "%A, %B %d %Y"
 org-agenda-todo-ignore-scheduled 'future  ;; Ignore todos for 5 days in the future
 org-agenda-todo-ignore-timestamp 5  ;; Ignore todos for 5 days in the future
 org-agenda-tags-todo-honor-ignore-options t
 org-agenda-include-diary t
 org-agenda-skip-scheduled-if-done t
 org-agenda-skip-deadline-if-done t
 org-agenda-start-on-weekday nil
 org-enforce-todo-dependencies t
 org-want-todo-bindings t
 org-journal-time-prefix "* ")

(setq org-modules '(org-bbdb
                    org-gnus
                    org-checklist
                    org-drill
                    org-info
                    org-jsinfo
                    org-habit
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

;; org-habit
(setq org-habit-following-days 4)
(setq org-habit-show-all-today t) ;; show completed tasks too
;;(setq org-habit-show-habits-only-for-today nil)

;; gtd in org-mode https://emacs.cafe/emacs/orgmode/gtd/2017/06/30/orgmode-gtd.html

(setq org-agenda-files '("~/notas/inbox.org"
                         "~/notas/gtd.org"
                         "~/notas/saude.org"
                         "~/notas/tickler.org"))

(setq diary-file "~/notas/diario.org")

(defun org-journal-find-location ()
  ;; Open today's journal, but specify a non-nil prefix argument in order to
  ;; inhibit inserting the heading; org-capture will insert the heading.
  (org-journal-new-entry t)
  ;; Position point on the journal's top-level heading so that org-capture
  ;; will add the new entry as a child entry.
  (goto-char (point-min)))

(setq org-capture-templates '(("t" "Todo [inbox]" entry
                               (file+headline "~/notas/inbox.org" "Tasks")
                               "* TODO %i%?")
                              ("T" "Tickler" entry
                               (file+headline "~/notas/tickler.org" "Tickler")
                               "* %i%? \n %U")
                              ("w" "Revisão semanal" entry (function org-journal-find-location) (file "~/notas/templates/weekly-review.org"))
                              ))

(setq org-refile-targets '((org-agenda-files :maxlevel . 3)
                           ("~/notas/someday.org" :level . 1)
                           ("~/notas/trash.org" :level . 1)
                           ))

(setq org-refile-use-outline-path 'file)
(setq org-outline-path-complete-in-steps nil)
(setq org-refile-allow-creating-parent-nodes 'confirm)
;; explanation: https://blog.aaronbieber.com/2017/03/19/organizing-notes-with-refile.html

(setq org-todo-keywords '((sequence "TODO(t)" "WAITING(w)" "|" "DONE(d)" "CANCELLED(c)")))


(setq org-agenda-custom-commands
      '(("n" "Agenda and all TODOs"
  ((agenda "")
   (alltodo ""
     ((org-agenda-skip-function 'rodrigomaia17-skip-todos-from-project-but-first)))))))

(defun rodrigomaia17-skip-todos-from-project-but-first ()
  "Pular se ele nao for primeiro HEADING e se nao for o primeiro da lista que ainda esta para fazer"
  (unless
      (and
       (org-current-is-todo)
       (not (org-current-is-habit))
       (or
        (org-current-is-first-heading)
        (org-current-is-first-pending-in-project)))

       (outline-next-heading)
  ))

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

(defun open-inbox-file ()
  (interactive)
  (find-file "~/notas/inbox.org"))
(spacemacs/set-leader-keys "oi" 'open-inbox-file)

(defun open-gtd-file ()
  (interactive)
  (find-file "~/notas/gtd.org"))
(spacemacs/set-leader-keys "og" 'open-gtd-file)

(defun open-someday-file ()
  (interactive)
  (find-file "~/notas/someday.org"))

(spacemacs/set-leader-keys "os" 'open-someday-file)

(defun open-tickler-file ()
  (interactive)
  (find-file "~/notas/tickler.org"))
(spacemacs/set-leader-keys "ot" 'open-tickler-file)

(defun open-diary-file ()
  (interactive)
  (find-file "~/notas/diario.org"))
(spacemacs/set-leader-keys "od" 'open-diary-file)

(defun rodrigomaia17-org-agenda-show-agendas ()
  (interactive)
  (org-agenda nil "n"))


;(load "~/dotfiles/brazilian-holidays.el")

(spacemacs/set-leader-keys "an" 'rodrigomaia17-org-agenda-show-agendas)
