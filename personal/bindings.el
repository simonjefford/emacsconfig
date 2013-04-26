(bind "s->"  '(lambda ()
                (interactive)
                (enlarge-window 1)))

(bind "s-<"  '(lambda ()
                (interactive)
                (shrink-window 1)))

(bind "C-s->"  '(lambda ()
                  (interactive)
                  (enlarge-window-horizontally 1)))

(bind "C-s-<" '(lambda ()
                 (interactive)
                 (shrink-window-horizontally 1)))

(bind "M-<"  'beginning-of-buffer)
(bind "M->"  'end-of-buffer)

(bind "C-s" 'isearch-forward-regexp)
(bind "C-r" 'isearch-backward-regexp)
(bind "C-M-s" 'isearch-forward)
(bind "C-M-r" 'isearch-backward)
