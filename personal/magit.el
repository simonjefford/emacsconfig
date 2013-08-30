(require 'magit)
(defadvice magit-status (around magit-fullscreen activate)
  (window-configuration-to-register :magit-fullscreen)
  ad-do-it
  (delete-other-windows))

(defun magit-quit-session ()
  "Restores the previous window configuration and kills the magit buffer"
  (interactive)
  (kill-buffer)
  (jump-to-register :magit-fullscreen))

(define-key magit-status-mode-map (kbd "q") 'magit-quit-session)

(defun magit-commit-mode-init ()
  (when (looking-at "\n")
    (open-line 1)))

(add-hook 'git-commit-mode-hook 'magit-commit-mode-init)

;; close popup when commiting

(defadvice git-commit-commit (after delete-window activate)
  (delete-window))

(defun magit-exit-commit-mode ()
  (interactive)
  (kill-buffer)
  (delete-window))

(eval-after-load "git-commit-mode"
  '(define-key git-commit-mode-map (kbd "C-c C-k") 'magit-exit-commit-mode))
