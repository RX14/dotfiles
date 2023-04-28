;;; init.el -*- lexical-binding: t; -*-

(doom! :completion
       (company +tng)             ; the ultimate code completion backend
       (vertico +icons)

       :ui
       doom              ; what makes DOOM look the way it does
       doom-dashboard    ; a nifty splash screen for Emacs
       doom-quit         ; DOOM quit-message prompts when you quit Emacs
       hl-todo           ; highlight TODO/FIXME/NOTE/DEPRECATED/HACK/REVIEW
       modeline          ; snazzy, Atom-inspired modeline, plus API
       nav-flash         ; blink the current line after jumping
       ophints           ; highlight the region an operation acts on
       (popup            ; tame sudden yet inevitable temporary windows
        +all             ; catch all popups that start with an asterix
        +defaults)       ; default popup rules
       treemacs          ; a project drawer, like neotree but cooler
       vc-gutter         ; vcs diff in the fringe
       vi-tilde-fringe   ; fringe tildes to mark beyond EOB
       window-select     ; visually switch windows

       :editor
       (evil +everywhere); come to the dark side, we have cookies
       fold              ; (nigh) universal code folding
       (format +onsave)  ; automated prettiness
       multiple-cursors  ; editing in many places at once
       rotate-text       ; cycle region at point between text candidates
       snippets          ; my elves. They type so I don't have to
       word-wrap         ; soft wrapping with language-aware indent

       :emacs
       (dired +ranger +icons) ; making dired pretty [functional]
       electric               ; smarter, keyword-based electric-indent
       undo
       vc                     ; version-control and Emacs, sitting in a tree

       :checkers
       syntax
       (spell +everywhere)
       grammar

       :tools
       docker
       editorconfig      ; let someone else argue about tabs vs spaces
       eval              ; run code, run (also, repls)
       (lookup           ; helps you navigate your code and documentation
        +docsets)        ; ...or in Dash docsets locally
       lsp
       magit             ; a git porcelain for Emacs
       make              ; run make tasks from Emacs
       rgb               ; creating color strings
       tree-sitter

       :lang
       cc                ; C/C++/Obj-C madness
       crystal           ; ruby at the speed of c
       data              ; config/data formats
       (elixir +lsp)       ; erlang done right
       emacs-lisp        ; drown in parentheses
       (go +lsp)           ; the hipster dialect
       (java +meghanada)   ; the poster child for carpal tunnel syndrome
       (javascript +lsp)          ; all(hope(abandon(ye(who(enter(here))))))
       (kotlin +lsp)            ; a better, slicker Java(Script)
       markdown          ; writing docs for people to ignore
       (python +lsp +pyright +poetry +tree-sitter)            ; beautiful is better than ugly
       sh                ; she sells {ba,z,fi}sh shells on the C xor
       web                 ; the tubes
       yaml

       :config
       (default +bindings +smartparens))
