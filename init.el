;; -*- lexical-binding: t; -*-

;; by default same directory where the emacs directory is
(setq org-roam-directory (file-truename (concat user-emacs-directory "../roam/" )))

(add-to-list 'load-path (concat user-emacs-directory "org-roam/" ))
(add-to-list 'load-path (concat user-emacs-directory "consult-org-roam/" ))

(setq debug-on-error t)

(require 'org)

(use-package vertico
  :ensure t
  ;;:custom
  ;; (vertico-scroll-margin 0) ;; Different scroll margin
  ;; (vertico-count 20) ;; Show more candidates
  ;; (vertico-resize t) ;; Grow and shrink the Vertico minibuffer
  ;; (vertico-cycle t) ;; Enable cycling for `vertico-next/previous'
  :init
  (vertico-mode))

(use-package dash
  :ensure t
  )

(use-package magit
  :ensure t
  )

(use-package magit-section
  :ensure t
  )

(use-package emacsql
  :ensure t
  )

(require 'org-roam)


(global-set-key (kbd "C-c n l") 'org-roam-buffer-toggle)
(global-set-key (kbd "C-c n f") 'org-roam-node-find)
(global-set-key (kbd "C-c n g") 'org-roam-graph)
(global-set-key (kbd "C-c n i") 'org-roam-node-insert)
(global-set-key (kbd "C-c n c") 'org-roam-capture)
(global-set-key (kbd "C-c n j") 'org-roam-dailies-capture-today)

;;(setq org-roam-node-display-template (concat "${title:*} " (propertize "${tags:10}" 'face 'org-tag)))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun my--org-roam-format (node)
  "formats the node"
  (format "%-40s %s"
          (if (org-roam-node-title node)
              (propertize (org-roam-node-title node) 'face 'org-todo)
            "")
          (file-name-nondirectory (org-roam-node-file node))))
  
(setq org-roam-node-display-template 'my--org-roam-format)

;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package consult
  :ensure t
  )

(require 'consult-org-roam)

(consult-org-roam-mode 1)

(setq consult-org-roam-grep-func #'consult-ripgrep)
(setq consult-org-roam-buffer-narrow-key ?r)
(setq consult-org-roam-buffer-after-buffers nil)

(global-set-key (kbd "C-c n e") 'consult-org-roam-file-find)
(global-set-key (kbd "C-c n b") 'consult-org-roam-backlinks)
(global-set-key (kbd "C-c n B") 'consult-org-roam-backlinks-recursive)
(global-set-key (kbd "C-c n l") 'consult-org-roam-forward-links)
(global-set-key (kbd "C-c n r") 'consult-org-roam-search)


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
