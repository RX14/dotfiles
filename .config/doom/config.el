;;; .doom.d/config.el -*- lexical-binding: t; -*-

(map! :leader
      (:prefix "w"
        "f" #'make-frame
        "o" #'other-frame)

      "q q" #'save-buffers-kill-emacs
      "t F" #'format-all-mode)

(use-package! pkgbuild-mode
  :mode "/PKGBUILD$")

(+global-word-wrap-mode +1)

(setq evil-want-fine-undo t

      lsp-clients-elixir-server-executable "elixir-ls"
      lsp-enable-snippet nil)

(after! sql
  (sql-set-product 'postgres))

(after! (flycheck lsp-mode flycheck-golangci-lint)
  (flycheck-add-next-checker 'lsp 'golangci-lint))
