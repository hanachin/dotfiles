;; Emacsの設定をやり直した！ - (define -ayalog '()) http://ayato.hateblo.jp/entry/20140112/1389533972
(require 'package)
(add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/") t)
(package-initialize)

;; http://emacs-jp.github.io/packages/package-management/package-el.html
(defvar my/favorite-packages
  '(
    auto-complete
    popup
    ruby-end
    inf-ruby
    popwin
    multiple-cursors
    magit
    ))

(require 'cl-lib)
(let ((packages (cl-loop for pkg in my/favorite-packages
                            when (not (package-installed-p pkg))
                            collect pkg)))
  (when packages
    (package-refresh-contents)
    (dolist (pkg packages)
        (package-install pkg))))

(require 'popwin)
(popwin-mode 1)

;; https://github.com/magnars/multiple-cursors.el
(require 'multiple-cursors)
(global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)
(global-set-key (kbd "C->") 'mc/mark-next-like-this)
(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)

;; EmacsWiki: Meta Key Problems
;; http://www.emacswiki.org/emacs/MetaKeyProblems#toc15
(setq mac-option-key-is-meta nil)
(setq mac-command-key-is-meta t)
(setq mac-command-modifier 'meta)
(setq mac-option-modifier nil)

;; ASCII.jp：～師範！ Emacsとviって使わないといけないんですか!?～｜行っとけ！　Ubuntu道場！
;; http://ascii.jp/elem/000/000/539/539039/index-3.html
;; Emacsを終了するかy/nで確認
(setq confirm-kill-emacs 'y-or-n-p)

;; 空白のみを使ってインデントする
(setq-default indent-tabs-mode nil)
;; タブを空白2つで表示n
(setq-default tab-width 2)

;; Undo回数を増やす
(setq undo-limit 800000)
(setq undo-strong-limit 1200000)

;; ~/.emacs.d/backupsにバックアップファイルを集約
;; https://www.emacswiki.org/emacs/AutoSave
(setq backup-directory-alist `(("." . ,(concat user-emacs-directory "backups"))))

;; ファイルの削除でゴミ箱に入れる。ディレクトリの削除で問題が出たら以下参照。
;; problem in `delete-directory` with enabled `delete-by-removing-to-trash` - Stack Overflow
;; http://stackoverflow.com/questions/2583541/problem-in-delete-directory-with-enabled-delete-by-removing-to-trash
(setq delete-by-moving-to-trash t)

;; Meadow/Emacs memo: ウィンドウ/バッファの操作
;; http://www.bookshelf.jp/soft/meadow_29.html
(defun my-make-scratch (&optional arg)
  (interactive)
  (progn
    ;; "*scratch*" を作成して buffer-list に放り込む
    (set-buffer (get-buffer-create "*scratch*"))
    (funcall initial-major-mode)
    (erase-buffer)
    (when (and initial-scratch-message (not inhibit-startup-message))
      (insert initial-scratch-message))
    (or arg (progn (setq arg 0)
                   (switch-to-buffer "*scratch*")))
    (cond ((= arg 0) (message "*scratch* is cleared up."))
          ((= arg 1) (message "another *scratch* is created")))))

(defun my-buffer-name-list ()
  (mapcar (function buffer-name) (buffer-list)))

(add-hook 'kill-buffer-query-functions
          ;; *scratch* バッファで kill-buffer したら内容を消去するだけにする
          (function (lambda ()
                      (if (string= "*scratch*" (buffer-name))
                          (progn (my-make-scratch 0) nil)
                        t))))

(add-hook 'after-save-hook
          ;; *scratch* バッファの内容を保存したら *scratch* バッファを新しく作る
          (function (lambda ()
                      (unless (member "*scratch*" (my-buffer-name-list))
                        (my-make-scratch 1)))))

;; Emacsの基本設定: 麦汁三昧
;; http://mugijiru.seesaa.net/article/203900890.html#
;; keybindの提案
(setq suggest-key-bindings t)
;; yes/noをy/nに
(fset 'yes-or-no-p 'y-or-n-p)

;; orgにS-矢印が乗っ取られるのが嫌で設定いじってみた: 麦汁三昧
;; http://mugijiru.seesaa.net/article/200967484.html
;; (windmove-default-keybindings)
;; (setq windmove-wrap-around t)
(windmove-default-keybindings 'meta)

;; C-hでバックスペース
(global-set-key "\C-h" 'backward-delete-char)

;; 起動画面を消す
(setq inhibit-startup-screen t)

;; 改行と同時にインデント
(setq indent-line-function 'indent-relative-maybe)

;; http://www.emacswiki.org/emacs/RubyMode
(add-to-list 'auto-mode-alist
             '("\\.\\(?:gemspec\\|irbrc\\|gemrc\\|rake\\|rb\\|ru\\|thor\\)\\'" . ruby-mode))
(add-to-list 'auto-mode-alist
             '("\\(Capfile\\|Gemfile\\(?:\\.[a-zA-Z0-9._-]+\\)?\\|[rR]akefile\\)\\'" . ruby-mode))
(add-to-list 'auto-mode-alist
             '("\\.haml_i18n_lint" . ruby-mode))

;; whitespace
(setq-default show-trailing-whitespace t)
(add-hook 'before-save-hook 'delete-trailing-whitespace)

(setq ruby-insert-encoding-magic-comment nil)

(set-face-attribute 'default nil
                    :family "Ricty"
                    :height 120)
;; (setq font-use-system-font t)


(setq x-alt-keysym 'meta)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (inf-ruby smartrep ruby-end popwin multiple-cursors markdown-mode magit e2wm color-theme-solarized auto-install auto-complete anything))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
