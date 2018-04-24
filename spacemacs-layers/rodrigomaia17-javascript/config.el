(setq
 ;; js2-mode
 js2-basic-offset 2
 js2-indent-level 2
 js-indent-level 2
 ;; web-mode
 css-indent-offset 2
 web-mode-markup-indent-offset 2
 web-mode-css-indent-offset 2
 web-mode-code-indent-offset 2
 web-mode-attr-indent-offset 2)

'(js2-strict-trailing-comma-warning nil)

(add-hook 'react-mode-hook 'prettier-js-mode)

(add-to-list 'auto-mode-alist '("\\.js" . react-mode))
(add-to-list 'auto-mode-alist '("\\.scss" . sass-mode))

(add-hook 'react-mode-hook
          (lambda()
            (local-unset-key (kbd "C-c C-j")))) ;; I use this for Org-Journal
