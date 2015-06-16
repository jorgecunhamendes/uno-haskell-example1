module LibreOffice.UNO.Any where

data Any

class Anyable a where
  fromAny :: Any -> a
  toAny :: a -> Any

