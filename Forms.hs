module Forms where

import Prelude hiding (writeFile, readFile, head, tail, init, last)
import Yesod hiding (Route(..))
import Foundation
import Data.Monoid (Monoid (mappend, mempty, mconcat), (<>))
import Control.Applicative ((<$>), (<*>), pure)
import Control.Arrow ((&&&))
import Data.Text (Text)
import qualified Data.Text as T

-- Enum系の型のドロップダウンのための関数
enumFieldList = selectFieldList enumPairs
enumPairs = map (T.pack . show &&& id ) $ [minBound..maxBound]


guestForm :: Form Guest
guestForm = renderDivs $ Guest
    <$> areq textField "Name" Nothing
    <*> areq intField  "Age"  Nothing
    <*> areq boolField "Attend" Nothing
    <*> areq enumFieldList "Blood" Nothing

guestForm' :: Guest -> Form Guest
guestForm' guest = renderDivs $ Guest
    <$> areq textField "Name" (Just $ guestName guest)
    <*> areq intField  "Age"  (Just $ guestAge guest)
    <*> areq boolField "Attend" (Just $ guestAttend guest)
    <*> areq enumFieldList "Blood" (Just $ guestBlood guest)


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
