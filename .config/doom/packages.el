;; -*- no-byte-compile: t; -*-
;;; .doom.d/packages.el

(package! pkgbuild-mode)
(package! verilog-mode)
(package! caddyfile-mode)
(package! llvm-mode :recipe (:host github :repo "nverno/llvm-mode"))
(package! protobuf-mode
  :recipe (:host github :repo "protocolbuffers/protobuf"
           :files ("editors/protobuf-mode.el")))
