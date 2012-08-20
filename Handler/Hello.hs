{-# LANGUAGE TupleSections, OverloadedStrings #-}
module Handler.Hello where

import Import

getHelloR :: Handler RepHtml
getHelloR = do
    let widget = $(widgetFile "hello")
    defaultLayout widget
