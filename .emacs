(modify-frame-parameters nil '((wait-for-wm . nil)))

(defun load-magit()
  (interactive)
  (setq load-path (cons "~/src/magit" load-path))
  (require 'magit)
  (global-set-key "\C-xpS" 'magit-status)
  (setq magit-commit-all-when-nothing-staged 't) )
;;(global-set-key [f12] 'load-magit)
;; change magit diff colors
(eval-after-load 'magit
  '(progn
     (set-face-foreground 'magit-diff-add "green3")
     (set-face-foreground 'magit-diff-del "red3")
     ))
;;(load-magit)


;;(setq load-path (cons "~/src/emacs-git-gutter" load-path))
;;(require 'git-gutter)
;;(global-git-gutter-mode t)


(add-hook 'term-mode-hook
   (lambda ()
     ;; C-x is the prefix command, rather than C-c
     (term-set-escape-char ?\C-x)
     (define-key term-raw-map "\M-y" 'yank-pop)
     (define-key term-raw-map "\M-w" 'kill-ring-save)))

(setq erc-hide-list '("JOIN" "PART" "QUIT"))

(remove-hook 'find-file-hooks 'vc-find-file-hook) ;; stop this

(setq shift-select-mode nil)

(defconst my-cc-style
  '("stroustrup"
    (c-offsets-alist . ((innamespace . [0]))))) ;; do not indent inside namespace{...}
(c-add-style "my-cc-style" my-cc-style)

(defun my-c-mode ()
  "C mode with adjusted defaults.";
  (c-set-style "my-cc-style")
  (local-set-key  (kbd "C-c o") 'ff-find-other-file))
(add-hook 'c-mode-common-hook 'my-c-mode)
(add-to-list 'auto-mode-alist '("\\.h\\'" . c++-mode)) ;; headers as c++ mode

(add-to-list 'auto-mode-alist '("\\.cfm\\'" . html-mode))
(add-to-list 'auto-mode-alist '("\\.cfc\\'" . html-mode))

(setq inhibit-startup-message t)
(setq show-trailing-whitespace t)
(global-set-key "\C-x\C-b" 'bs-show)
(setq compilation-scroll-output "first-error")
(setq compilation-skip-threshold 2)
(setq compilation-read-command nil)
(setq compilation-auto-jump-to-first-error 1)

(fset 'c++-cout
      [?s ?t ?d ?: ?: ?c ?o ?u ?t ?  ?< ?< ?\S-  ?" ?" ?  ?< ?< ?  ?s ?t ?d ?: ?: ?e ?n ?d ?l ?\; left left left left left left left left left left left left left left left])
(global-set-key "\C-xc" 'c++-cout)

;;(show-paren-mode 1) ; show matching parens. slow?
(setq indent-tabs-mode nil) ;; use spaces instead of tabs

(menu-bar-mode -1) ; turns off menu bar
;;(tool-bar-mode -1) ; turns off tool bar
;;(scroll-bar-mode -1) ; turns off tool bar

;; ;; Preserve the owner and group of the file you're editing (this is
;; ;; especially important if you edit files as root):
;; (setq backup-by-copying-when-mismatch t)

;; (setq frame-title-format "%b - emacs")
(global-set-key "\C-cg" 'goto-line)
(global-set-key "\C-cs" 'eshell)
(setq eshell-scroll-show-maximum-output nil) ;; don't scroll the eshell window

;; this is for both Control-arrow and Meta-arrow navigation
;; use C-q <key> to get the keycodes
(global-set-key (kbd "<M-up>") 'backward-paragraph) ;; xterm
(global-set-key (kbd "[1;3A") 'backward-paragraph) ;; screen
(global-set-key (kbd "[1;5A") 'backward-paragraph) ;; screen

(global-set-key (kbd "<M-down>") 'forward-paragraph) ;; xterm
(global-set-key (kbd "[1;3B") 'forward-paragraph) ;; screen
(global-set-key (kbd "[1;5B") 'forward-paragraph) ;; screen

(global-set-key (kbd "[1;3C") 'forward-word) ;; screen
(global-set-key (kbd "[1;5C") 'forward-word) ;; screen

(global-set-key (kbd "[1;3D") 'backward-word) ;; screen
(global-set-key (kbd "[1;5D") 'backward-word) ;; screen

;;(setq font-lock-maximum-decoration 2)



(defun smart-indent ()
  "Indents region if mark is active, or current line otherwise."
  (interactive)
  (if mark-active
      (indent-region (region-beginning)
		     (region-end))
    (indent-for-tab-command)))


(defun smart-tab (arg)
 "Do the right thing about tabs"
 (interactive "*P")
 (cond
 
    ((active-minibuffer-window)     
     (minibuffer-complete))
  ;; in front of a word?
  ((save-excursion
     (forward-char -1)
     (looking-at "[a-zA-Z0-9]"))
   (dabbrev-expand nil))
  ((save-excursion
     (forward-char -1)
     (looking-at "[.>]"))
   (dabbrev-expand nil))
  ;; ok, just indent
  (t
   (smart-indent))))

(global-set-key [tab] 'smart-tab)
(global-set-key [(tab)] 'smart-tab)
(global-set-key "\t" 'smart-tab)

;; (defun my-c-kill-forward-into-nomenclature (&optional arg)
;;   "Kill forward to the end of a nomenclature section or word.  With
;; arg, do it arg times."
;;   (interactive "p")
;;   (save-excursion
;;     (set-mark (point))
;;     (c-forward-into-nomenclature arg)
;;     (kill-region (mark) (point))))

;; (defun my-c-kill-backward-into-nomenclature (&optional arg)
;;   "Kill backward to the beginning of a nomenclature section or word.
;; th arg, do it arg times."
;;   (interactive "p")
;;   (save-excursion
;;     (set-mark (point))
;;     (c-backward-into-nomenclature arg)
;;     (kill-region (mark) (point))))
;; (global-set-key [(control backspace)] 'my-c-kill-backward-into-nomenclature)
;; (global-set-key [(meta d)] 'my-c-kill-forward-into-nomenclature)


(line-number-mode 1)
(column-number-mode 1)
(setq scroll-step 1)

(setq delete-key-deletes-forward t)
(setq-default case-fold-search nil)
(setq progress-feedback-use-echo-area 1)

(defun yes-or-no-p (prompt) "just y/n, thanks" (y-or-n-p prompt) )

(global-set-key [f7] 'compile)
(global-set-key [f9] 'compile)
(global-set-key [f8] 'next-error)
(global-set-key [f11] 'previous-error)
(setq next-error-highlight t)
(setq compile-command "plink m.mk")

;; time/mail notification
;;(display-time)

;; Visual feedback on selections
(setq-default transient-mark-mode t)

;; ;; Always end a file with a newline
(setq require-final-newline t)


;; wheel mouse
;;(require 'mwheel)
;;(xterm-mouse-mode)
;(mouse-wheel-mode) 
;;(setq mouse-wheel-progressive-speed nil)

(require 'mouse)
(xterm-mouse-mode t)
(defun track-mouse (e)) 
(setq mouse-sel-mode t)

(defvar goto-last-change-undo nil
  "The `buffer-undo-list' entry of the previous \\[goto-last-change] command.")
(make-variable-buffer-local 'goto-last-change-undo)

;;;###autoload
(defun goto-last-change (&optional mark-point minimal-line-distance)
  "Set point to the position of the last change.
Consecutive calls set point to the position of the previous change.
With a prefix arg (optional arg MARK-POINT non-nil), set mark so \
\\[exchange-point-and-mark]
will return point to the current position."
  (interactive "P")
  ;; (unless (buffer-modified-p)
  ;;   (error "Buffer not modified"))
  (when (eq buffer-undo-list t)
    (error "No undo information in this buffer"))
  (when mark-point
    (push-mark))
  (unless minimal-line-distance
    (setq minimal-line-distance 10))
  (let ((position nil)
	(undo-list (if (and (eq this-command last-command)
			    goto-last-change-undo)
		       (cdr (memq goto-last-change-undo buffer-undo-list))
		     buffer-undo-list))
	undo)
    (while (and undo-list
                (or (not position)
                    (eql position (point))
                    (and minimal-line-distance
                         ;; The first invocation always goes to the last change, subsequent ones skip
                         ;; changes closer to (point) then minimal-line-distance.
                         (memq last-command '(goto-last-change
                                              goto-last-change-with-auto-marks))
                         (< (count-lines (min position (point-max)) (point))
                            minimal-line-distance))))
      (setq undo (car undo-list))
      (cond ((and (consp undo) (integerp (car undo)) (integerp (cdr undo)))
	     ;; (BEG . END)
	     (setq position (cdr undo)))
	    ((and (consp undo) (stringp (car undo))) ; (TEXT . POSITION)
	     (setq position (abs (cdr undo))))
	    ((and (consp undo) (eq (car undo) t))) ; (t HIGH . LOW)
	    ((and (consp undo) (null (car undo)))
	     ;; (nil PROPERTY VALUE BEG . END)
	     (setq position (cdr (last undo))))
	    ((and (consp undo) (markerp (car undo)))) ; (MARKER . DISTANCE)
	    ((integerp undo))		; POSITION
	    ((null undo))		; nil
	    (t (error "Invalid undo entry: %s" undo)))
      (setq undo-list (cdr undo-list)))
    (cond (position
	   (setq goto-last-change-undo undo)
	   (goto-char (min position (point-max))))
	  ((and (eq this-command last-command)
		goto-last-change-undo)
	   (setq goto-last-change-undo nil)
	   (error "No further undo information"))
	  (t
	   (setq goto-last-change-undo nil)
	   (error "Buffer not modified")))))

(defun goto-last-change-with-auto-marks (&optional minimal-line-distance)
  "Calls goto-last-change and sets the mark at only the first invocations
in a sequence of invocations."
  (interactive "P")
  (goto-last-change (not (or (eq last-command 'goto-last-change-with-auto-marks)
                             (eq last-command t)))
                    minimal-line-distance))


(global-set-key "\C-x\C-\\" 'goto-last-change)

(global-linum-mode 1)

(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(frame-background-mode (quote light))
 '(indent-tabs-mode nil)
 '(load-home-init-file t t)
 '(vc-handled-backends (quote (RCS CVS SVN SCCS Git Bzr Hg Mtn Arch))))

;; The following is used to get fast performance when running under
;; tmux, which defines TERM as screen-256color

(load "term/xterm")
 
;; derived from Emacs 22.1 term/xterm.el
 
(defun terminal-init-screen ()
  "Terminal initialization function for screen."
 
  (let ((map (make-sparse-keymap)))
 
    ;; tmux with its xterm-keys option turned on will generate these
    (define-key map "\e[1;2A" [S-up])
    (define-key map "\e[1;2B" [S-down])
    (define-key map "\e[1;2C" [S-right])
    (define-key map "\e[1;2D" [S-left])
    (define-key map "\e[1;2F" [S-end])
    (define-key map "\e[1;2H" [S-home])
 
    (define-key map "\e[1;5A" [C-up])
    (define-key map "\e[1;5B" [C-down])
    (define-key map "\e[1;5C" [C-right])
    (define-key map "\e[1;5D" [C-left])
    (define-key map "\e[1;5F" [C-end])
    (define-key map "\e[1;5H" [C-home])
 
    (define-key map "\e[1;6A" [C-S-up])
    (define-key map "\e[1;6B" [C-S-down])
    (define-key map "\e[1;6C" [C-S-right])
    (define-key map "\e[1;6D" [C-S-left])
    (define-key map "\e[1;6F" [C-S-end])
    (define-key map "\e[1;6H" [C-S-home])
 
    (define-key map "\e[1;3A" [A-up])
    (define-key map "\e[1;3B" [A-down])
    (define-key map "\e[1;3C" [A-right])
    (define-key map "\e[1;3D" [A-left])
    (define-key map "\e[1;3F" [A-end])
    (define-key map "\e[1;3H" [A-home])
 
    ;; This way we don't override terminfo-derived settings or settings
    ;; made in the .emacs file.
    (set-keymap-parent map (keymap-parent function-key-map))
    (set-keymap-parent function-key-map map))
 
  ;; Use the xterm color initialization code.
  (xterm-register-default-colors)
  (tty-set-up-initial-frame-faces))
