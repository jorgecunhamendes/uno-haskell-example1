{-# LANGUAGE ExistentialQuantification, DeriveDataTypeable #-}
module LibreOffice.UNO.Exception where

import Text

import Control.Applicative ((<$>),(<*>))
import Data.Text (Text, unpack)
import Data.Typeable
import qualified Control.Exception as E
import Foreign
-- import Foreign.C

data XInterface

type Context = Ptr XInterface

data Exception = Exception Text Context
    deriving Typeable

-- data Exception = forall e . E.Exception e => Exception e
    -- deriving Typeable

instance Show Exception where
    show (Exception msg _) = "Exception: " ++ unpack msg

instance E.Exception Exception

sizeOfPtr :: Int
sizeOfPtr = sizeOf (undefined :: Ptr a)

foreign import ccall "&exceptionSizeOf" exceptionSizeOf :: Ptr Int
foreign import ccall "&exceptionAlignment" exceptionAlignment :: Ptr Int

instance Storable Exception where
   --sizeOf _ = unsafeDupablePerformIO $! peek exceptionSizeOf
   sizeOf _ = sizeOfPtr + sizeOfPtr
   alignment _ = sizeOfPtr
   peek eptr = Exception <$> peekOUString (castPtr eptr)
                         <*> peekByteOff (castPtr eptr) (sizeOf (undefined :: Ptr a))
   poke = undefined

foreign import ccall "hsuno_exceptionGetMessage"
  exceptionGetMessage :: Ptr Exception -> IO (Ptr OUString)

{-
unoExceptionToException :: E.Exception e => e -> E.SomeException
unoExceptionToException = E.toException . Exception

unoExceptionFromException :: E.Exception e => E.SomeException -> Maybe e
unoExceptionFromException x = do
    Exception a <- E.fromException x
    cast a
    -}
