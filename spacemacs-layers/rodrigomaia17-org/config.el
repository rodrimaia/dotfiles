(setq
 ;; set up org mode
 org-log-done nil
 org-startup-indented t
 org-startup-folded "content"
 org-directory "~/notas"
 org-enable-org-journal-support t org-journal-dir "~/notas/journal/"
 org-journal-date-format "%A, %B %d %Y"
 org-agenda-todo-ignore-scheduled 5  ;; Ignore todos for 5 days in the future
 org-agenda-todo-ignore-timestamp 5  ;; Ignore todos for 5 days in the future
 org-agenda-tags-todo-honor-ignore-options t
 org-journal-time-prefix "* ")

(setq org-agenda-files '("~/notas/inbox.org"
                         "~/notas/gtd.org"
                         "~/notas/tickler.org"))


(setq org-capture-templates '(("t" "Todo [inbox]" entry
                               (file+headline "~/notas/inbox.org" "Tasks")
                               "* TODO %i%?")))

(setq org-refile-targets '((org-agenda-files :maxlevel . 3)
                           ("~/notas/someday.org" :level . 1)
                           ("~/notas/trash.org" :level . 1)
                           ))

(setq org-refile-use-outline-path 'file)
(setq org-outline-path-complete-in-steps nil)
(setq org-refile-allow-creating-parent-nodes 'confirm)
;; explanation: https://blog.aaronbieber.com/2017/03/19/organizing-notes-with-refile.html

(setq org-todo-keywords '((sequence "TODO(t)" "WAITING(w)" "|" "DONE(d)" "CANCELLED(c)")))


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
