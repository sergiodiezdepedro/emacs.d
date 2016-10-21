(setq user-full-name "Sergio Díez de Pedro")
(setq user-mail-address "sergio.d.depedro@gmail.com")

(custom-set-variables

 '(column-number-mode t)
 
 '(cursor-type (quote bar))
 
 '(custom-enabled-themes (quote (seti)))
 
 '(display-time-24hr-format t)
 '(display-time-mode t)
 
 '(global-visual-line-mode t)
 
 '(helm-mode 1)
 
 '(inhibit-startup-screen t)
 
 '(markdown-command "markdown")
 
 '(org-agenda-files
   (quote
    ("~/Dropbox/org/tareas.org.txt" "~/Dropbox/org/formacion_front-end.org" "~/Dropbox/org/notas_sobre_org-mode.org")))
 '(org-directory "~/Dropbox/org")
 '(org-export-backends (quote (ascii html icalendar latex md)))
 '(org-footnote-auto-adjust t)
 '(org-footnote-define-inline nil)
 '(org-footnote-section "Notas")
 '(show-paren-mode 1)

 )

(custom-set-faces

 )

;;Directorio para modos menores y utilidades sin repositorio
(add-to-list 'load-path "~/.emacs.d/lisp/")

(when window-system
  (tool-bar-mode -1))

;; Mostrar los número de línea como en los editores habituales.
;;(global-linum-mode 1)

;;Mover el cursor entre términos camelCase
(global-subword-mode 1)

(require 'package)
(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/") t)
(add-to-list 'package-archives
             '("melpa-stable" . "https://stable.melpa.org/packages/") t)
(add-to-list 'package-archives
             '("melpa" . "http://melpa.milkbox.net/packages/") t)
(when (< emacs-major-version 24)
  ;; For important compatibility libraries like cl-lib
  (add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/")))

(package-initialize)

(require 'org)
(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)
(setq org-log-done t)

;; Org Capture
(setq org-default-notes-file (concat org-directory "/notas.org"))
(define-key global-map "\C-cc" 'org-capture)
(setq org-capture-templates
      '(("t" "Tareas" entry (file+headline "~/Dropbox/org/tareas.org" "Tareas")
             "* TODO %?\n  %i\n  %a")
        ("d" "Diario" entry (file+datetree "~/Dropbox/org/diario.org")
	 "* %?\nAnotado el %U\n  %i\n  %a")
        ("n" "Nota" entry (file "~/Dropbox/org/notas.org")
               "* %? :NOTA:\n%U\n%a\n" :clock-in t :clock-resume t)))
        

(setq org-src-fontify-natively t)

;; Compatibilidad de selección de texto en Org Mode
(setq org-support-shift-select t)

(require 'org-bullets)
(add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))

(require 'powerline)
(powerline-center-theme)

;;Temas de MELPA
;;(load-theme 'monokai t)
(load-theme 'seti t)

;; Auto-complete
(require 'auto-complete)
(global-auto-complete-mode t)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/elpa/auto-complete-20160827.649/dict")
(require 'auto-complete-config) 
(ac-config-default)

;; Modo menor Emmet
(add-hook 'html-mode-hook 'emmet-mode)
(add-hook 'css-mode-hook 'emmet-mode)

;; active Babel languages
(org-babel-do-load-languages
 'org-babel-load-languages
 '((sh . t)
   (js . t)
   (python . t)
   ))

;; Ido Mode
;;(setq ido-enable-flex-matching t)
;;(setq ido-everywhere t)
;;(ido-mode 1)

;; Helm Mode
(require 'helm-config)
(global-set-key (kbd "M-x") 'helm-M-x)
(global-set-key (kbd "C-x C-f") 'helm-find-files)
(global-set-key (kbd "C-x C-b") 'helm-buffers-list)  
(global-set-key (kbd "C-c h g") 'helm-google-suggest)

;;js2 Mode como editor de JS
(add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))

;; autopair
(require 'autopair)
(autopair-global-mode)

;; web-beautify
(eval-after-load 'js2-mode
  '(define-key js2-mode-map (kbd "C-c b") 'web-beautify-js))
;; Or if you're using 'js-mode' (a.k.a 'javascript-mode')
(eval-after-load 'js
  '(define-key js-mode-map (kbd "C-c b") 'web-beautify-js))

(eval-after-load 'json-mode
  '(define-key json-mode-map (kbd "C-c b") 'web-beautify-js))

(eval-after-load 'sgml-mode
  '(define-key html-mode-map (kbd "C-c b") 'web-beautify-html))

(eval-after-load 'web-mode
  '(define-key web-mode-map (kbd "C-c b") 'web-beautify-html))

(eval-after-load 'css-mode
  '(define-key css-mode-map (kbd "C-c b") 'web-beautify-css))

;;yasnippet
(require 'yasnippet)
(yas-global-mode 1)
(setq yas-snippet-dirs
      '("~/.emacs.d/snippets"))

;; Org-Reveal
(require 'ox-reveal)
(setq org-reveal-root "http://cdn.jsdelivr.net/reveal.js/3.0.0/")
(setq org-reveal-mathjax t)

;; multiple-cursors
(require 'multiple-cursors)
(global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)
(global-set-key (kbd "C->") 'mc/mark-next-like-this)
(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-S-<mouse-1>") 'mc/add-cursor-on-click)

;; ace-window
(global-set-key (kbd "M-p") 'ace-window)

;; Habilitar la exportación a .odt (OpenDocument Text) en Org-Mode
;; La opción está deshabilitada por defecto en Org 8.x
(eval-after-load "org"
  '(require 'ox-odt nil t))

;;Abrir los bookmarks al inicio de Emacs
(require 'bookmark)
(bookmark-bmenu-list)
(switch-to-buffer "*Bookmark List*")

;; Definir F8 para ver la imagen en una etiqueta <img>
(global-set-key (kbd "<f8>") 'find-file-at-point)

;; undo-tree-mode
(global-undo-tree-mode 1)
;; make ctrl-z undo
(global-set-key (kbd "C-z") 'undo)
;; make ctrl-Z redo
(defalias 'redo 'undo-tree-redo)
(global-set-key (kbd "C-S-z") 'redo)

;; Marcado de pareja de etiquetas HTML
(require 'hl-tags-mode)
(add-hook 'sgml-mode-hook (lambda () (hl-tags-mode 1)))
(add-hook 'nxml-mode-hook (lambda () (hl-tags-mode 1)))

;; Magit
(global-set-key (kbd "C-x g") 'magit-status)
(global-set-key (kbd "C-x M-g") 'magit-dispatch-popup)

;; Textile Mode
(require 'textile-mode)
(add-to-list 'auto-mode-alist '("\\.textile\\'" . textile-mode))
;; Exportación desde Org Mode
(require 'ox-textile)
