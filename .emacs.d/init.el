
(require 'package)
(let* ((no-ssl (and (memq system-type '(windows-nt ms-dos))
                    (not (gnutls-available-p))))
       (proto (if no-ssl "http" "https")))
  ;; Comment/uncomment these two lines to enable/disable MELPA and MELPA Stable as desired
  (add-to-list 'package-archives (cons "melpa" (concat proto "://melpa.org/packages/")) t)
  ;;(add-to-list 'package-archives (cons "melpa-stable" (concat proto "://stable.melpa.org/packages/")) t)
  (when (< emacs-major-version 24)
    ;; For important compatibility libraries like cl-lib
    (add-to-list 'package-archives (cons "gnu" (concat proto "://elpa.gnu.org/packages/")))))
(package-initialize)

;;tab
;;(setq c-default-style "k&r"
;;         c-basic-offset 4)


;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

(require 'highlight-symbol)
(global-set-key (kbd "C-c U") 'hi-lock-unface-buffer)
(global-set-key (kbd "C-c h .") 'highlight-symbol-at-point)
(global-set-key (kbd "C-c s .") 'highlight-symbol-next)
(global-set-key (kbd "C-c S .") 'highlight-symbol-prev)
(global-set-key (kbd "C-c r .") 'highlight-symbol-query-replace)

;; auto-complete configs
(require 'auto-complete)
(setq ac-use-menu-map t)
(setq ac-menu-height 10)
(setq ac-candidate-limit 20)
(define-key ac-mode-map (kbd "M-TAB") 'auto-complete)

;; Adding hooks to most used langages
(add-hook 'julia-mode-hook 'my-julia-mode-hook)
(defun my-julia-mode-hook ()
  (highlight-symbol-mode 1)
  (hi-lock-mode 1)
  (auto-complete-mode 1)
  (setq ac-sources '(ac-source-words-in-same-mode-buffers ac-source-functions ac-source-filename)))

(add-hook 'JavaScript-mode-hook 'my-javascript-mode-hook)
(defun my-javascript-mode-hook ()
  (highlight-symbol-mode 1)
  (hi-lock-mode 1)
  (auto-complete-mode 1))

(add-hook 'c++-mode-hook 'my-c++-mode-hook)
(defun my-c++-mode-hook ()
  (highlight-symbol-mode 1)
  (hi-lock-mode 1)
  (auto-complete-mode 1))

(setq-default c-basic-offset 4
	      tab-width 4
             indent-tabs-mode t)


;; For Helm
(helm-mode 1)
(global-set-key (kbd "M-x") 'helm-M-x)
(global-set-key (kbd "C-x C-f") 'helm-find-files)
(global-set-key (kbd "C-c i m") 'helm-imenu)

;; Helm + Projectile
(require 'helm-projectile)
;; (global-set-key (kbd "C-x p s g") 'projectile-grep)
(helm-projectile-on)


;; show matching parenthesis
(show-paren-mode 1)


(setq-default case-fold-search nil) ;;case sensitive search
(setq column-number-mode t) ;; show column number
(when (version<= "26.0.50" emacs-version )
  (global-display-line-numbers-mode))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ac-trigger-commands (quote (self-insert-command)))
 '(ac-trigger-key nil)
 '(ansi-color-faces-vector
   [default default default italic underline success warning error])
 '(auto-insert-mode t)
 '(custom-enabled-themes (quote (wombat)))
 '(package-selected-packages
   (quote
	(markdown-mode flycheck-julia julia-mode monokai-alt-theme ess sr-speedbar helm-ag geben-helm-projectile ## helm highlight-symbol auto-highlight-symbol auto-complete yaml-mode multiple-cursors projectile)))
 '(speedbar-fetch-etags-command "ctagsforjulia"))

(load-theme 'monokai-alt t)

(add-to-list 'load-path "~/.emacs.d/lisp/julia-emacs/")
(require 'julia-mode)


;; For mouse mode
(unless window-system
  (require 'mouse)
  (xterm-mouse-mode t)
  (global-set-key [mouse-4] (lambda ()
                              (interactive)
                              (scroll-down 1)))
  (global-set-key [mouse-5] (lambda ()
                              (interactive)
                              (scroll-up 1)))
  (defun track-mouse (e))
  (setq mouse-sel-mode t)
)

;; Go to definition with mouse
;; (global-set-key (kbd <S-mouse-1>) 'xref-find-definitions)

;; for multiple cursors
(require 'multiple-cursors)
(global-set-key (kbd "M-n") 'mc/mark-next-like-this)
(global-set-key (kbd "M-N") 'mc/mark-next-like-this-word)
(global-set-key (kbd "C-c C-a") 'mc/edit-beginnings-of-lines)
(global-set-key (kbd "C-c C-e") 'mc/edit-ends-of-lines)
(global-unset-key (kbd "C-c <down-mouse-1>"))
(global-set-key (kbd "C-c <mouse-1>") 'mc/add-cursor-on-click)

;; ;; CTAGS ETAGS
;; ; https://www.emacswiki.org/emacs/EtagsTable
;; (require 'etags-table)
;; (setq etags-table-alist
;;       '(
;;         (".*\\.jl$" "/home/mauro/julia/julia-0.6/TAGS" "/home/mauro/.julia/v0.6/TAGS")
;;         ))
;; (setq tags-case-fold-search nil) ; case sensitive search

(defun create-tags (dir-name)
  "Create tags file."
  (interactive "DDirectory: ")
  (shell-command
   (format "/usr/local/Cellar/universal-ctags/HEAD-a20bb99/bin/ctags -R -e --options=/Users/vitornesello/ctags_folder/ctags --totals=yes --languages=julia %s" (directory-file-name dir-name)))
  )



;; For projectile package, that enables project-like functionality to emacs
(projectile-mode +1)
(define-key projectile-mode-map (kbd "s-p") 'projectile-command-map)
(define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)


(eval-after-load 'autoinsert
  '(define-auto-insert '("\\.cpp\\'" . "Cpp skeleton")
	 '(
	   \n "#include <stdio.h>" \n
	   "#include \""
	   (file-name-sans-extension
		(file-name-nondirectory (buffer-file-name)))
	   ".h\"" \n \n
        )))


;; autoinsert C/C++ header
(define-auto-insert
  (cons "\\.\\([Hh]\\|hh\\|hpp\\)\\'" " .h header")
  '(nil
	"// " (file-name-nondirectory buffer-file-name) "\n"
	"//\n"
	"// Description:\n"
	"//\n"
	(make-string 70 ?/) "\n\n"
	(let* ((noext (substring buffer-file-name 0 (match-beginning 0)))
		   (nopath (file-name-nondirectory noext))
		   (ident (concat (upcase nopath) "_H")))
	  (concat "#ifndef " ident "\n"
			  "#define " ident  " \n\n\n"

			  
			  "#include <stdio.h> \n"
			  "#include <cstdlib> \n"
			  "#include <iomanip> \n"
			  "#include <fstream> \n"
			  "#include <iostream> \n"
			  "#include <ilcplex/ilocplex.h> \n\n"
			  "using namespace std; \n"
			  
			  
			  "\n\n#endif // " ident "\n"))
	))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
