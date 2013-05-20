(setq ibuffer-saved-filter-groups
      '(("home"
         ("emacs-lisp" (or (filename . "\.el$")
                           (name . "\*scratch")))
         ("clojure" (mode . clojure-mode))
         ("ruby/rails" (or (mode . ruby-mode)
                           (mode . haml-mode)
                           (mode . less-css-mode)))
         ("go" (mode . go-mode))
         ("Javascript / Coffee" (or (mode . js2-mode)
                                    (mode . js-mode)
                                    (mode . coffee-mode)))
         ("Docs" (or (mode . markdown-mode)
                     (mode . showoff-mode)))
         ("code"  (filename . "code"))
         ("REPL" (or (mode . inferior-lisp-mode)
                     (mode . slime-repl-mode)))

         ("Shells" (or (mode . eshell-mode)))
         ("Magit" (name . "\*magit"))
         ("Org" (mode . org-mode))
         ("ERC" (mode . erc-mode))
         ("Dirs" (mode . dired-mode))
         ("Customize" (mode . Custom-mode))
         ("Help" (or (name . "\*Help\*")
                     (name . "\*Apropos\*")
                     (name . "\*info\*")))
         ("Scala" (mode . scala-mode))
         ("Man pages" (mode . Man-mode)))))

(add-hook 'ibuffer-mode-hook
          '(lambda ()
             (ibuffer-switch-to-saved-filter-groups "home")
             (ibuffer-auto-mode 1)))

(setq ibuffer-show-empty-filter-groups nil)