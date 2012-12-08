module Widget where

import Prelude
import Yesod

import Foundation

formPageWidget :: Widget -> Enctype -> Widget
formPageWidget formWidget formEnctype = $(widgetFile "form")
