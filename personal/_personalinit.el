(defmacro bind (key fn)
  "shortcut for global-set-key"
  `(global-set-key (kbd ,key)
                   ;; handle unquoted function names and lambdas
                   ,(if (listp fn)
                        fn)))

(if (fboundp 'smex-initialize)
    (progn
      (bind "C-x C-m" 'smex)
      (bind "M-x" 'smex-major-mode-commands))
  (message "install smex!"))

(if (display-graphic-p)
    (set-face-font 'default "-apple-Menlo-medium-normal-normal-*-11-*-*-*-m-0-iso10646-1"))

(global-set-key (kbd "M-3") '(lambda () (interactive) (insert "#")))
(global-set-key (kbd "s-3") '(lambda () (interactive) (insert "#")))

(dolist (mode '(menu-bar-mode tool-bar-mode scroll-bar-mode))
  (when (fboundp mode) (funcall mode -1)))

(setq ido-enable-prefix nil
      ido-enable-flex-matching t
      ido-auto-merge-work-directories-length nil
      ido-create-new-buffer 'always
      ido-use-filename-at-point 'guess
      ido-use-virtual-buffers t
      ido-handle-duplicate-virtual-buffers 2
      ido-max-prospects 10)

(server-start)

(display-battery-mode)
(display-time-mode)

(setq frame-title-format
      '("" (:eval (if (buffer-file-name)
                      (abbreviate-file-name (buffer-file-name))
                    "%b"))))

;; Keep these as they have been removed from prelude upstream
(key-chord-define-global "kk" 'just-one-space)
(key-chord-define-global "KK" 'delete-horizontal-space)
(setq prelude-flyspell nil)

(prelude-ensure-module-deps '(dash-at-point evil-nerd-commenter editorconfig handlebars-mode))
(evilnc-default-hotkeys)
(require 'editorconfig)
(require 'handlebars-mode)
(require 'rinari)
(global-rinari-mode)

(defun sj-next-line ()
  (interactive)
  (end-of-line)
  (newline-and-indent))

(eval-after-load "go-mode"
  '(add-hook 'before-save-hook 'gofmt-before-save))
