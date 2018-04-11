;; use mu4e for e-mail in emacs
(setq mail-user-agent 'mu4e-user-agent)
(setq mu4e-drafts-folder "/[Gmail].Rascunhos")
(setq mu4e-sent-folder   "/[Gmail].E-mails enviados")
(setq mu4e-trash-folder  "/[Gmail].Lixeira")
(setq mu4e-maildir-shortcuts
      '( ("/INBOX"               . ?i)
         ("/[Gmail].E-mails enviados"   . ?s)
         ("/[Gmail].Lixeira"       . ?t)
         ("/[Gmail].Todos os e-mails"    . ?a)))
;; allow for updating mail msing 'U' in the main view:
(setq mu4e-get-mail-command "offlineimap")

;; don't keep message buffers around
(setq message-kill-buffer-on-exit t)


;;(add-to-list 'mu4e-view-actions '("ViewInBrowser" . mu4e-action-view-in-browser) t)

;; Choose the style you prefer for desktop notifications
;; If you are on Linux you can use
;; 1. notifications - Emacs lisp implementation of the Desktop Notifications API
;; 2. libnotify     - Notifications using the `notify-send' program, requires `notify-send' to be in PATH
;;
;; On Mac OSX you can set style to
;; 1. notifier      - Notifications using the `terminal-notifier' program, requires `terminal-notifier' to be in PATH
;; 1. growl         - Notifications using the `growl' program, requires `growlnotify' to be in PATH
;;(mu4e-alert-set-default-style 'notifier)
;;(add-hook 'after-init-hook 'mu4e-alert-enable-notifications)

