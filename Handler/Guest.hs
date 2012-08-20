module Handler.Guest where

import Import

getGuestR :: Handler RepHtml
getGuestR = error "Not yet implemented: getGuestR"

postGuestR :: Handler RepHtml
postGuestR = error "Not yet implemented: postGuestR"

getGuestInsertTestR :: Handler RepHtml
getGuestInsertTestR = do
    let guest = Guest
            { guestName   = "Shimazaki Seizan"
            , guestAge    = 29
            , guestAttend = True
            , guestBlood  = O
            }
    _guestId <- runDB $ insert guest
    defaultLayout $ $(widgetFile "hello")
