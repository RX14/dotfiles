;;; .doom.d/config.el -*- lexical-binding: t; -*-

(map!
 "M-c" #'clipboard-kill-ring-save
 "M-v" #'clipboard-yank

 :leader
 (:prefix "w"
          "f" #'make-frame
          "o" #'other-frame)

 "q q" #'save-buffers-kill-emacs
 "t F" #'format-all-mode
 )

(map! :m "C-M-o" #'evil-jump-forward)

(use-package! pkgbuild-mode
  :mode "/PKGBUILD$")

(+global-word-wrap-mode +1)

(setq evil-want-fine-undo t

      lsp-enable-snippet nil

      jit-lock-stealth-time 2

      langtool-default-language "en-GB"

      ispell-dictionary "en_GB"

      +format-on-save-enabled-modes '(crystal-mode python-mode elm-mode)

      highlight-indent-guides-auto-character-face-perc 5

      git-commit-summary-max-length 68)

(after! sql
  (sql-set-product 'postgres))

(add-hook! 'lsp-after-initialize-hook
  (run-hooks (intern (format "%s-lsp-hook" major-mode))))

(add-hook 'go-mode-lsp-hook
          (lambda ()
            (flycheck-add-next-checker 'lsp 'golangci-lint)))

(after! git-commit
  (remove-hook! 'git-commit-setup-hook 'git-commit-turn-on-auto-fill))

(use-package! caddyfile-mode
  :mode (("Caddyfile\\'" . caddyfile-mode)
         ("caddy\\.conf\\'" . caddyfile-mode)))

(use-package! llvm-mode
  :mode "\\.ll\\'")

(after! treemacs-evil
  (evil-define-key 'treemacs treemacs-mode-map (kbd "h")      #'treemacs-TAB-action)
  (evil-define-key 'treemacs treemacs-mode-map (kbd "l")      #'treemacs-TAB-action))

(set-popup-rule! "^ ?\\*Treemacs" :ignore t)
