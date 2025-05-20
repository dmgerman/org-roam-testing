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

(defun dmg-org-roam-to-string (st)
  "Make sure we have ST is a string. if it is a list, concatenate it."
  (cond
   ((stringp st) st)
   ((listp st) (mapconcat 'identity st " "))
   (t "")))
      
(defun dmg-org-roam-truncate (st width)
  "Return ST as a string of length WIDTH. Using spaces for padding"
  (truncate-string-to-width (dmg-org-roam-to-string st) width nil ? ))

(defun dmg-org-roam-format-tags (tags width)
  "Return TAGS as a string of width WIDTH.
Prefixes every tag with #."
  (dmg-org-roam-truncate 
   (mapconcat (lambda (tag) (concat "#" tag)) tags " ")
   width))
  
(defun dmg-org-roam-format (node)
  "Sample function to format a NODE.
This function is equivalent to the following template
 (setq org-roam-node-display-template
              (concat 
                (propertize \"${todo} \" 'face 'org-todo)
                \"${todo:10} \"
                (propertize \"${tags:30} \" 'face 'org-tag)
                \"${title} \"
                \"${file}\"
                \"${olp}\"
                ))"
  (let (
        (formatted-node     (concat (org-roam-node-todo node)
                                    " "
                                    (propertize
                                     (dmg-org-roam-format-tags (org-roam-node-tags node) 30))
                                    " " (org-roam-node-title node)
                                    " " (org-roam-node-file node)
                                    " "
                                    (string-join (org-roam-node-olp node) " > "))
                            ))
    (cons
     (propertize formatted-node 'node node)
     node)))

(setq org-roam-node-display-template 'dmg-org-roam-format)

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


