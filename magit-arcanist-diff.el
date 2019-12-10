;;; magit-arcanist-diff.el --- diff functionality -*- lexical-binding:t ; -*-

;;; Copyright © 2018-2018 Jonathan Jin <jjin082693@gmail.com>

;; This file is NOT part of GNU Emacs.

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 3, or (at your option)
;; any later version.
;;
;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.
;;
;; You should have received a copy of the GNU General Public License
;; along with GNU Emacs; see the file COPYING.  If not, write to the
;; Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor,
;; Boston, MA 02110-1301, USA.

;;; Commentary:
;; This library implements Arcanist diff functionality.

;; Code:

(require 'magit-popup)

(defun magit-arcanist--do-diff (&optional flags)
  "Runs `arc diff' using FLAGS, e.g. \"--nolint\"."
  (interactive (magit-arcanist-diff-arguments))
  (magit-arcanist--run-arc-cmd "diff" flags))

(magit-define-popup magit-arcanist-diff-popup
  "Popup console for Arcanist diff commands."
  :switches '((?l "No lint" "--nolint")
              (?u "No unit tests" "--nounit")
              (?c "No coverage info" "--no-coverage")
              (?b "browse" "--browse"))
  :actions '((?d "Diff" magit-arcanist--do-diff)))

(provide 'magit-arcanist-diff)

;;; magit-arcanist-diff.el ends here
