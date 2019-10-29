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
