;;; magit-arcanist.el --- Magit popup for Arcanist interaction -*- lexical-binding:t ; -*-

;;; Copyright © 2018-2018 Jonathan Jin <jjin082693@gmail.com>

;; Author: Jonathan Jin <jjin082693@gmail.com>
;; URL: https://github.com/jinnovation/helm-exec
;; Keywords: magit, arcanist, vc, source-control
;; Version: 0.1.0

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

;; This package provides integration for Magit to natively interact with
;; Arcanist (https://secure.phabricator.com/book/phabricator/article/arcanist),
;; the CLI for Phabricator (https://phacility.com).

;;; Code:

(require 'magit)
(require 'magit-popup)
(require 'magit-arcanist-diff)

(defcustom magit-arcanist-key (kbd "@")
  "Key to invoke the magit-arcanist popup within Magit. This
needs to be set before the call to `magit-arcanist-enable'."
  :type 'string)

(defcustom magit-arcanist-arc-executable (executable-find "arc")
  "Path to the `arc' executable. `magit-arcanist-enable' will
fail if this path does not exist."
  :type 'string)

(defun magit-arcanist-land ()
  (ignore))

;;;###autoload
(defun magit-arcanist-feature (name)
  "Runs the following command: arc feature NAME."
  (interactive (list (magit-read-string "Feature branch name")))
  (magit-start-process "arc" nil "feature" name))

(magit-define-popup magit-arcanist-popup
  "Popup console for Arcanist commands."
  :actions '((?d "Diff" magit-arcanist-diff-popup)
             (?f "Feature" magit-arcanist-feature)
             (?l "Land" magit-arcanist-land))
  :max-action-columns 2)

(defun magit-arcanist--can-enable-p ()
  "Returns nil if preconditions for magit-arcanist initialization
are not met."
  (and (executable-find magit-arcanist-arc-executable)))

(defun magit-arcanist-enable ()
  "Enables magit-arcanist for use by binding `magit-arcanist-pop' to
`magit-arcanist-key' within `magit-mode-map'."
  (interactive)
  (progn
    (when (not (magit-arcanist--can-enable-p))
        (error "Arcanist executable does not exist: %s"
               magit-arcanist-arc-executable))

    (define-key magit-mode-map magit-arcanist-key 'magit-arcanist-popup)))

(provide 'magit-arcanist)

;;; magit-arcanist.el ends here
