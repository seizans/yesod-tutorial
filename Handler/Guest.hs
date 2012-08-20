module Handler.Guest where

import Import

getGuestR :: GuestId -> Handler RepHtml
getGuestR guestId = do
    guest <- runDB $ get404 guestId
    (formWidget, formEnctype) <- generateFormPost $ guestForm' guest
    defaultLayout $ $(widgetFile "form")

putGuestR :: GuestId -> Handler RepHtml
putGuestR guestId = undefined

deleteGuestR :: GuestId -> Handler RepHtml
deleteGuestR guestId = undefined


getGuestCreateR :: Handler RepHtml
getGuestCreateR = do
    (formWidget, formEnctype) <- generateFormPost guestForm
    defaultLayout $ $(widgetFile "form")

postGuestCreateR :: Handler RepHtml
postGuestCreateR = do
    ((formResult, formWidget), formEnctype) <- runFormPost guestForm
    case formResult of
        FormSuccess guest -> do
            _guestId <- runDB $ insert guest
            defaultLayout $ $(widgetFile "form")
        _ -> defaultLayout $ $(widgetFile "form")

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
