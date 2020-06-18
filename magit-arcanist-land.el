;;; magit-arcanist-land.el --- land functionality -*- lexical-binding:t ; -*-

;;; Copyright © 2019-2019 Philipp Fehre <philipp@fehre.co.uk>

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
;; This library implements Arcanist land functionality.

;; Code:

(defun magit-arcanist--do-land (&optional flags)
  "Runs `arc land' using FLAGS, e.g. \"--preview\"."
  (interactive (magit-arcanist-land-arguments))
  (magit-arcanist--run-arc-cmd "land" flags))

(magit-define-popup magit-arcanist-land-popup
  "Popup console for Arcanist land commands."
  :switches '((?p "Preview" "--preview")
              (?k "Keep branch" "--keep-branch"))
  :actions '((?l "Land" magit-arcanist--do-land)))

(provide 'magit-arcanist-land)

;;; magit-arcanist-land.el ends here
