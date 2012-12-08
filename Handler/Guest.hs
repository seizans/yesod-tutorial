module Handler.Guest where

import Import

getGuestsR :: Handler RepHtml
getGuestsR = do
    guestEntities <- runDB $ selectList [] []
    -- GuestEntity は { entityKey :: GuestId, entityVal :: Guest } という感じ
    (fWidget, fEnctype) <- generateFormPost guestForm
    defaultLayout $ guestPortalWidget guestEntities fWidget fEnctype

getGuestR :: GuestId -> Handler RepHtml
getGuestR guestId = do
    guest <- runDB $ get404 guestId
    (fWidget, fEnctype) <- generateFormPost $ guestForm' (Just guest)
    defaultLayout $ formPageWidget fWidget fEnctype

putGuestR :: GuestId -> Handler RepHtml
putGuestR guestId = do
    ((fResult, fWidget), fEnctype) <- runFormPost guestForm
    case fResult of
        FormSuccess guest -> do
            runDB $ do
                _guest <- get404 guestId
                update guestId
                    [ GuestName   =. guestName   guest
                    , GuestAge    =. guestAge    guest
                    , GuestAttend =. guestAttend guest
                    , GuestBlood  =. guestBlood  guest
                    ]
            defaultLayout $ formPageWidget fWidget fEnctype
        _ -> defaultLayout $ formPageWidget fWidget fEnctype

deleteGuestR :: GuestId -> Handler RepHtml
deleteGuestR guestId = do
    runDB $ do
        _guest <- get404 guestId
        delete guestId
    defaultLayout helloWidget


getGuestCreateR :: Handler RepHtml
getGuestCreateR = do
    (fWidget, fEnctype) <- generateFormPost guestForm
    defaultLayout $ formPageWidget fWidget fEnctype

postGuestCreateR :: Handler RepHtml
postGuestCreateR = do
    ((fResult, fWidget), fEnctype) <- runFormPost guestForm
    case fResult of
        FormSuccess guest -> do
            _guestId <- runDB $ insert guest
            defaultLayout $ formPageWidget fWidget fEnctype
        _ -> defaultLayout $ formPageWidget fWidget fEnctype

getGuestInsertTestR :: Handler RepHtml
getGuestInsertTestR = do
    let guest = Guest
            { guestName   = "Shimazaki Seizan"
            , guestAge    = 29
            , guestAttend = True
            , guestBlood  = O
            }
    _guestId <- runDB $ insert guest
    defaultLayout helloWidget
