module Handler.FormTest where

import Import

getFormTestR :: Handler RepHtml
getFormTestR = do
    (fWidget, fEnctype) <- generateFormPost itemForm
    defaultLayout $ formPageWidget fWidget fEnctype

postFormTestR :: Handler RepHtml
postFormTestR = do
    ((fResult, fWidget), fEnctype) <- runFormPost itemForm
    case fResult of
        FormMissing -> liftIO $ print "FORM MISSING"
        FormFailure ts -> liftIO $ print ts
        FormSuccess i -> liftIO $ print i
    defaultLayout $ formPageWidget fWidget fEnctype
