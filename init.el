(add-to-list 'load-path "~/.emacs.d/")
(require 'package)

(add-to-list 'package-archives
             '("marmalade" . "http://marmalade-repo.org/packages/"))
(package-initialize)

(defun turn-on-paredit () (paredit-mode 1))
(add-hook 'clojure-mode-hook 'turn-on-paredit)

(setq visible-bell t)

(defun clojure-slime-maybe-compile-and-load-file ()
  "Call function `slime-compile-and-load-file' if current buffer is connected to a swank server.Meant to be used in `after-save-hook'."
  (when (and (eq major-mode 'clojure-mode) (slime-connected-p))
    (slime-compile-and-load-file)))

(add-hook 'after-save-hook 'clojure-slime-maybe-compile-and-load-file)

(autoload 'paredit-mode "paredit"   
  "Minor mode for pseudo-structurally editing Lisp code."   
  t)   
;(add-hook 'lisp-mode-hook (lambda () (paredit-mode +1)))   
(mapc (lambda (mode)   
      (let ((hook (intern (concat (symbol-name mode)   
                   "-mode-hook"))))   
      (add-hook hook (lambda () (paredit-mode +1)))))   
     '(emacs-lisp lisp inferior-lisp slime slime-repl)) 
