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

(set-face-font 'default "-apple-Menlo-medium-normal-normal-*-11-*-*-*-m-0-iso10646-1")
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

(setq prelude-whitespace nil)
