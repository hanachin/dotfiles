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

;; バックアップファイルを.bakに集約
;; バックアップファイルについての設定
;; http://exlight.net/devel/emacs/backup_file/index.html
(setq make-backup-files t)
(setq backup-directory "~/.bak")
(if (and (boundp 'backup-directory)
         (not (fboundp 'make-backup-file-name-original)))
    (progn
      (fset 'make-backup-file-name-original
            (symbol-function 'make-backup-file-name))
      (defun make-backup-file-name (filename)
        (if (and (file-exists-p (expand-file-name backup-directory))
                 (file-directory-p (expand-file-name backup-directory)))
            (concat (expand-file-name backup-directory)
                    "/" (file-name-nondirectory filename))
          (make-backup-file-name-original filename)))))

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
(windmove-default-keybindings)
(setq windmove-wrap-around t)

;; C-hでバックスペース
(global-set-key "\C-h" 'backward-delete-char)

;; 起動画面を消す
(setq inhibit-startup-screen t)

;; 改行と同時にインデント
(setq indent-line-function 'indent-relative-maybe)
