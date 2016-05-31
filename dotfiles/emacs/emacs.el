(scroll-bar-mode 0)
(tool-bar-mode 0)
(menu-bar-mode 0)
(transient-mark-mode 0)
(blink-cursor-mode 0)

(setq inhibit-startup-message t)
(global-hl-line-mode 1)

(custom-set-faces
 '(default ((t (:foreground "#ffffff"  :background "gray9"))))
 '(cursor  ((t (:background "white" ))))
 '(region  ((t (:foreground "black"  :background "white"))))

 '(highlight  ((t (:background "black"))))

 '(mode-line ((t (:foreground "white"  :background "cadet blue"))))
 '(fringe  ((t (:foreground "black" :background "black"))))


 '(font-lock-function-name-face ((t (:foreground "lemon chiffon"))))
 '(font-lock-variable-name-face ((t (:foreground "lemon chiffon"))))

 '(font-lock-keyword-face ((t (:foreground "CadetBlue1" :weight bold :slant italic))))
 '(font-lock-type-face ((t (:foreground "CadetBlue1" :weight bold :slant italic))))
 )

(setq scroll-margin 1
      scroll-conservatively 0
      scroll-up-aggressively 0.01
      Scroll-down-aggressively 0.01)
(setq-default scroll-up-aggressively 0.01
	      scroll-down-aggressively 0.01)
(setq auto-window-vscroll nil)

(defun my-c-mode-common-hook()
  (c-set-offset 'substatement-open 0)
  (setq c++-tab-always-indent t)
  (setq c-basic-offset 4)
  (setq c-indent-level 4)
  (c-set-offset 'case-label '+4)
  (setq tab-width 4)
  (setq indent-tabs-mode t)
  )

(add-hook 'c-mode-common-hook 'my-c-mode-common-hook)
(display-time)

(set-frame-parameter nil 'alpha '(100 100))
(defun toggle-transparency ()
   (interactive)
   (if (/= (cadr (frame-parameter nil 'alpha)) 100)
       (set-frame-parameter nil 'alpha '(100 100))
     (set-frame-parameter nil 'alpha '(85 0))))

(global-set-key (kbd "<f12>") 'toggle-transparency)

(require 'compile)

(setq my-makefile "build.sh")
(setq my-runfile "run.sh")

(defun find-project-directory-recursive()
  (interactive)
  (if (file-exists-p my-makefile) t
    (cd "../")
    (find-project-directory-recursive)))

(defun find-project-directory()
  (interactive)
  (setq find-project-from-directory default-directory)
  (switch-to-buffer-other-window "*compilation*")
  (cd find-project-from-directory)
  (find-project-directory-recursive))

(defun make-without-asking()
  (interactive)
  (if (find-project-directory) (compile my-makefile))
  (other-window 1))

(defun run-without-asking()
  (interactive)
  (if (find-project-directory) (compile my-runfile))
  (other-window 1))

(global-set-key (kbd "<f5>") 'make-without-asking)
(global-set-key (kbd "<f6>") 'run-without-asking)

(define-key global-map "\en" 'next-error)
(define-key global-map "\eN" 'previous-error)

(setq visible-bell 1)

(setq backup-directory-alist `(("." . "~/.saves")))
(setq backup-by-copying t)

(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(setq js-indent-level 2)

(add-hook 'before-save-hook 'delete-trailing-whitespace)
(global-set-key [f8] 'neotree-toggle)
(global-set-key (kbd "C-x o") 'switch-window)
