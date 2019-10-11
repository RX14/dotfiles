;;; .doom.d/config.el -*- lexical-binding: t; -*-

(map! :leader
      (:prefix "w"
        "f" #'make-frame
        "o" #'other-frame)

      "q q" #'save-buffers-kill-emacs)

(use-package! pkgbuild-mode
  :mode "/PKGBUILD$")
