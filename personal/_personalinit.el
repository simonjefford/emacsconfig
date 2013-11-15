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
    (set-face-font 'default "-apple-Menlo-medium-normal-normal-*-12-*-*-*-m-0-iso10646-1"))

(global-set-key (kbd "M-3") '(lambda () (interactive) (insert "#")))
(global-set-key (kbd "s-3") '(lambda () (interactive) (insert "#")))

(bind "C-c M-f" 'toggle-frame-fullscreen)

(defun save-and-recompile ()
  (interactive)
  (save-buffer)
  (recompile))

(bind "C-c C-t" 'save-and-recompile)

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

(display-time-mode)

(setq frame-title-format
      '("" (:eval (if (buffer-file-name)
                      (abbreviate-file-name (buffer-file-name))
                    "%b"))))

;; Keep these as they have been removed from prelude upstream
(key-chord-define-global "kk" 'just-one-space)
(key-chord-define-global "KK" 'delete-horizontal-space)
(setq prelude-flyspell nil)

(prelude-ensure-module-deps '(dash-at-point
                               evil-nerd-commenter
                               editorconfig
                               handlebars-mode
                               protobuf-mode
                               groovy-mode
                               powerline
                               company
                               go-eldoc))
(evilnc-default-hotkeys)
(require 'editorconfig)
(require 'handlebars-mode)

(defun sj-next-line ()
  (interactive)
  (end-of-line)
  (newline-and-indent))

(eval-after-load "go-mode"
  '(add-hook 'before-save-hook 'gofmt-before-save))

(prelude-swap-meta-and-super)

(require 'powerline)
(setq powerline-arrow-shape 'arrow)
(setq powerline-color1 "grey22")
(setq powerline-color2 "grey40")
(powerline-default-theme)


(add-to-list 'load-path (expand-file-name "gocode" prelude-vendor-dir))
(require 'company)
(require 'company-go)
(setq company-tooltip-limit 20)                      ; bigger popup window
(setq company-minimum-prefix-length 0)               ; autocomplete right after '.'
(setq company-idle-delay .3)                         ; shorter delay before autocompletion popup
(setq company-echo-delay 0)                          ; removes annoying blinking
(setq company-begin-commands '(self-insert-command)) ; start autocompletion only after typing

(add-hook 'go-mode-hook (lambda ()
                          (set (make-local-variable 'company-backends) '(company-go))
                          (company-mode)))

(require 'go-eldoc)
(add-hook 'go-mode-hook 'go-eldoc-setup)
