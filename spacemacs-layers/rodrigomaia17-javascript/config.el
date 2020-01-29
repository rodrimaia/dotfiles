(setq
 ;; js2-mode
 js2-basic-offset 2
 js2-indent-level 2
 js-indent-level 2
 typescript-basic-offset 2
 typescript-indent-level 2
 typescript-indent-level 2
 ;; web-mode
 css-indent-offset 2
 web-mode-markup-indent-offset 2
 web-mode-css-indent-offset 2
grep-find-ignored-directories '("node_modules" "SCCS" "RCS" "CVS" "MCVS" ".src" ".svn" ".git" ".hg" ".bzr" "_MTN" "_darcs" "{arch}")
 web-mode-code-indent-offset 2
 web-mode-attr-indent-offset 2)

'(js2-strict-trailing-comma-warning nil)

(add-hook 'react-mode-hook 'prettier-js-mode)

(add-to-list 'auto-mode-alist '("\\.js\\'" . typescript-mode))
(add-to-list 'auto-mode-alist '("\\.scss" . sass-mode))

(add-hook 'react-mode-hook
          (lambda()
            (local-unset-key (kbd "C-c C-j")))) ;; I use this for Org-Journal

(add-hook 'js2-mode-hook
          (lambda()
            (local-unset-key (kbd "C-c C-j")))) ;; I use this for Org-Journal

(with-eval-after-load 'flycheck
  (flycheck-add-mode 'javascript-eslint 'flow-minor-mode))

