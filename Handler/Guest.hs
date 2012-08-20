module Handler.Guest where

import Import
import qualified Data.Text as T

guestForm :: Form Guest
guestForm = renderDivs $ Guest
    <$> areq textField "Name" Nothing
    <*> areq intField  "Age"  Nothing
    <*> areq boolField "Attend" Nothing
    <*> areq enumFieldList "Blood" Nothing

-- Enum系の型のドロップダウンのための関数
enumFieldList = selectFieldList enumPairs
enumPairs = map (T.pack . show &&& id ) $ [minBound..maxBound]

getGuestR :: Handler RepHtml
getGuestR = do
    (formWidget, formEnctype) <- generateFormPost guestForm
    defaultLayout $ $(widgetFile "form")

postGuestR :: Handler RepHtml
postGuestR = do
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
