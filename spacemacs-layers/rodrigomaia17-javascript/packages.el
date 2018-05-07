;;; packages.el --- rodrigomaia17-javascript layer packages file for Spacemacs.
;;
;; Copyright (c) 2012-2018 Sylvain Benner & Contributors
;;
;; Author: rodrigo <rodrigo@rodrigos-MacBook-Pro.local>
;; URL: https://github.com/syl20bnr/spacemacs
;;
;; This file is not part of GNU Emacs.
;;
;;; License: GPLv3

(defconst rodrigomaia17-javascript-packages
  '(
    prettier-js
    ))

(defun rodrigomaia17-javascript/init-prettier-js ()
  (use-package prettier-js
    :defer t))

;;; packages.el ends here
