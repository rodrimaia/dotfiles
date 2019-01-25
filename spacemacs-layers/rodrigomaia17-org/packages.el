(defconst rodrigomaia17-org-packages
  '(org-journal
    org-alert
    org-gcal
    ))

(defun rodrigomaia17-org/init-org-journal ()
  (use-package org-journal
    :defer t)
  )

(defun rodrigomaia17-org/init-org-alert ()
  (use-package org-alert
    :defer t)
  )


(defun rodrigomaia17-org/init-org-gcal ()
  (use-package org-gcal
    :defer t)
  
  (load "~/notas/secret.el") ; load gcal secrets on this format:
  ;; (setq org-gcal-client-id "a-random-number.apps.googleusercontent.com"
  ;;       org-gcal-client-secret "client-secret"
  ;;       org-gcal-file-alist '(("my-email" .  "~/notas/cal.org")

  (add-hook 'org-agenda-mode-hook (lambda () (org-gcal-sync) ))
  )
