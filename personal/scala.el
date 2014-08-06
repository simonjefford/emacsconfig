(require 'ensime)

(prelude-require-packages '(ensime))

(add-hook 'scala-mode-hook 'ensime-scala-mode-hook)
