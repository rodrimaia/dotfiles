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
 org-agenda-skip-scheduled-if-done t
 org-agenda-skip-deadline-if-done t
 org-agenda-start-on-weekday nil
 org-agenda-start-with-follow-mode nil
 org-agenda-todo-ignore-deadlines (quote far)
 org-agenda-todo-ignore-scheduled "far"
 org-enforce-todo-dependencies t
 org-want-todo-bindings t
 org-journal-time-prefix "** ")

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
;;(setq org-habit-show-habits-only-for-today nil)

;; gtd in org-mode https://emacs.cafe/emacs/orgmode/gtd/2017/06/30/orgmode-gtd.html

(setq org-agenda-files '("~/notas/inbox.org"
                         "~/notas/gtd.org"
                         "~/notas/saude.org"
                         "~/notas/cal.org"
                         "~/notas/cal-work.org"
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

(setq org-capture-templates '(("t" "Todo [inbox]" entry
                               (file+headline "~/notas/inbox.org" "Tasks")
                               "* TODO %i%?")
                              ("a" "Appointment" entry (file  "~/notas/cal.org" )
	                             "* %?\n\n%^T\n\n:PROPERTIES:\n\n:END:\n\n")
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

(setq org-todo-keywords '((sequence "TODO(t)" "WAITING(w)" "|" "DONE(d)" "SKIP(k)" "CANCELLED(c)")))
 


(setq org-agenda-custom-commands
      '(("n" "Agenda and all TODOs"
         ((agenda "")
          (alltodo "INBOX"
                   (
                    (org-agenda-overriding-header "Para Processar")
                    (org-agenda-files '("~/notas/inbox.org")))
           )
          (tags-todo "-TODO/!TODO"
                     ((org-agenda-overriding-header "Tasks")
                      (org-agenda-skip-function 'my-org-agenda-skip-all-siblings-but-first)))
          (stuck ""
                 ((org-agenda-overriding-header "Esperando")) )
          ))))

(defun my-org-agenda-skip-all-siblings-but-first ()
  "Skip all but the first non-done entry."
  (let (should-skip-entry)
    (unless (org-current-is-todo)
      (setq should-skip-entry t))
    (save-excursion
      (while (and (not should-skip-entry) (org-goto-sibling t) (not (org-current-is-heading-outros)))
        (when (org-current-is-todo)
                (setq should-skip-entry t))))
       (when should-skip-entry
         (or (outline-next-heading)
             (goto-char (point-max))))))

(defun org-current-is-heading-outros () 
  (string= (first (org-get-outline-path)) "Outros"))

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

(defun open-gcal-file ()
  (interactive)
  (find-file "~/notas/cal.org"))
(spacemacs/set-leader-keys "oa" 'open-gcal-file)

(defun rodrigomaia17-org-agenda-show-agendas ()
  (interactive)
  (org-agenda nil "n"))


;(load "~/dotfiles/brazilian-holidays.el")

(spacemacs/set-leader-keys "an" 'rodrigomaia17-org-agenda-show-agendas)

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
