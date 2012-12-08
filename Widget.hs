module Widget where

import Prelude
import Yesod

import Foundation

formPageWidget :: Widget -> Enctype -> Widget
formPageWidget formWidget formEnctype = $(widgetFile "form")

guestPortalWidget :: [Entity Guest] -> Widget -> Enctype -> Widget
guestPortalWidget guestEntities formWidget formEnctype = $(widgetFile "guest-portal")
  where
    listWidget = guestListWidget guestEntities
    guestFormWidget = formPageWidget formWidget formEnctype

guestListWidget :: [Entity Guest] -> Widget
guestListWidget guestEntities = $(widgetFile "guest-list")

helloWidget :: Widget
helloWidget = $(widgetFile "hello")
