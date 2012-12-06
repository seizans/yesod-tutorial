module Model where

import Prelude
import Yesod
import Data.Text (Text)
import Database.Persist.Quasi

data Blood = A | B | O | AB
  deriving (Show, Read, Eq, Ord, Enum, Bounded)
derivePersistField "Blood"

share [mkPersist sqlSettings, mkMigrate "migrateAll"] [persist|

User
    ident Text
    password Text Maybe
    UniqueUser ident
Email
    email Text
    user UserId Maybe
    verkey Text Maybe
    UniqueEmail email

Guest
    name   Text
    age    Int
    attend Bool
    blood  Blood

|]
