module Handler.FormTest where

import Import

getFormTestR :: Handler RepHtml
getFormTestR = do
    (formWidget, formEnctype) <- generateFormPost itemForm
    let widget = $(widgetFile "form")
    defaultLayout widget

postFormTestR :: Handler RepHtml
postFormTestR = do
    ((formResult, formWidget), formEnctype) <- runFormPost itemForm
    case formResult of
        FormMissing -> liftIO $ print "FORM MISSING"
        FormFailure ts -> liftIO $ print ts
        FormSuccess itemForm -> liftIO $ print itemForm
    defaultLayout $ $(widgetFile "form")
