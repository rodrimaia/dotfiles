;;; packages.el --- rodrigomaia17-autocomplete layer packages file for Spacemacs.
;;
;; Copyright (c) 2012-2018 Sylvain Benner & Contributors
;;
;; Author: rodrigo <rodrigo@rodrigos-MacBook-Pro.local>
;; URL: https://github.com/syl20bnr/spacemacs
;;
;; This file is not part of GNU Emacs.
;;
;;; License: GPLv3

(defconst rodrigomaia17-autocomplete-packages
  '(
    company-tabnine
    ))

(defun rodrigomaia17-javascript/init-company-tabnine ()
  (use-package company-tabnine
    :defer t))

;;; packages.el ends here
