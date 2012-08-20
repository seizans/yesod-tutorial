module Handler.FormTest where

import Import

data ItemForm = ItemForm
    { itemFormName      :: Text
    , itemFormPrice     :: Int
    , itemFormAvailable :: Bool
    , itemFormMemo      :: Maybe Text
    }
  deriving Show

itemForm :: Form ItemForm
itemForm = renderBootstrap $ ItemForm
    <$> areq textField "Name" Nothing
    <*> areq intField "Price" Nothing
    <*> areq boolField "Available" Nothing
    <*> aopt textField "Memo" Nothing

getFormTestR :: Handler RepHtml
getFormTestR = do
    (formWidget, formEnctype) <- generateFormPost itemForm
    let widget = $(widgetFile "form")
    defaultLayout widget

postFormTestR :: Handler RepHtml
postFormTestR = error "Not yet implemented: postFormTestR"
