(defmacro bind (key fn)
  "shortcut for global-set-key"
  `(global-set-key (kbd ,key)
                   ;; handle unquoted function names and lambdas
                   ,(if (listp fn)
                        fn)))

(if (display-graphic-p)
    (set-face-font 'default "-apple-Menlo-medium-normal-normal-*-12-*-*-*-m-0-iso10646-1"))

(global-set-key (kbd "M-3") '(lambda () (interactive) (insert "#")))
(global-set-key (kbd "s-3") '(lambda () (interactive) (insert "#")))

(bind "C-c M-f" 'toggle-frame-fullscreen)

(defun save-and-recompile ()
  (interactive)
  (save-buffer)
  (recompile))

(defun projectile-save-and-recompile ()
  (interactive)
  (save-buffer)
  (projectile-compile-project nil))

(bind "C-c C-t" 'projectile-save-and-recompile)

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

(prelude-require-packages '(dash-at-point
                            evil-nerd-commenter
                            editorconfig
                            handlebars-mode
                            protobuf-mode
                            company
                            go-eldoc
                            writeroom-mode))
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

(add-to-list 'load-path (expand-file-name "gocode" prelude-vendor-dir))
(require 'company)
(require 'company-go)
(setq company-tooltip-limit 20)                      ; bigger popup window
(setq company-minimum-prefix-length 3)               ; autocomplete right after '.'
(setq company-idle-delay .3)                         ; shorter delay before autocompletion popup
(setq company-echo-delay 0)                          ; removes annoying blinking
(setq company-begin-commands '(self-insert-command)) ; start autocompletion only after typing

(add-hook 'go-mode-hook (lambda ()
                          (set (make-local-variable 'company-backends) '(company-go))
                          (company-mode)))

(require 'go-eldoc)
(add-hook 'go-mode-hook 'go-eldoc-setup)

(setq ack-and-a-half-arguments '()) ;; otherwise it just crashes. *sigh*

(setq projectile-switch-project-action 'projectile-vc)

(setq auto-save-default nil)

(add-to-list 'auto-mode-alist '("\\.hbs?\\'" . web-mode))

(setq writeroom-width 150)

(let ((oracle (executable-find "oracle")))
  (when oracle
    (setq go-oracle-command oracle)
    (autoload 'go-oracle-mode "oracle")
    (add-hook 'go-mode-hook 'go-oracle-mode)))

(defun sj-go-mode-hook ()
  (local-set-key (kbd "M-.") 'godef-jump))

(add-hook 'go-mode-hook 'sj-go-mode-hook)

(defun go-projectile-set-gopath-from-godep (current)
  (let ((godeps (locate-dominating-file (projectile-project-root) "Godeps")))
    (if (stringp godeps)
        (let* ((path-from-godeps (with-temp-buffer
                                   (cd godeps)
                                   (call-process "godep" nil t nil "path")
                                   (s-chomp (buffer-string))))
               (final-path (if (stringp current)
                               (s-concat path-from-godeps ":" current)
                             path-from-godeps)))
          final-path))))

(defun go-projectile-set-gopath ()
  "Attempt to setenv GOPATH for the current project."
  (interactive)
  (let* ((derived (go-projectile-derive-gopath))
         (path (or (go-projectile-make-gopath)
                   (go-projectile-set-gopath-from-godep derived)
                   derived)))
    (when path
      (message "setenv GOPATH=%s" path)
      (setenv "GOPATH" path))))

(require 'prelude-helm-everywhere)
