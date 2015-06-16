{-# LANGUAGE ExistentialQuantification, DeriveDataTypeable #-}
module LibreOffice.UNO.RuntimeException where

import LibreOffice.UNO.Exception
import Text

import Data.Typeable
import qualified Control.Exception as E
import Foreign

newtype RuntimeException = RuntimeException Exception
    deriving Typeable

instance Show RuntimeException where
    show (RuntimeException e) = show e

instance E.Exception RuntimeException

{-
instance Storable RuntimeException where
   --sizeOf _ = unsafeDupablePerformIO $! peek exceptionSizeOf
   sizeOf _ = sizeOfPtr + sizeOfPtr
   alignment _ = sizeOfPtr
   peek eptr = RuntimeException <$> peekOUString (castPtr eptr)
                                <*> peekByteOff (castPtr eptr) (sizeOf (undefined :: Ptr a))
   poke = undefined
   -}

foreign import ccall "hsuno_runtimeExceptionGetMessage"
  runtimeExceptionGetMessage :: Ptr RuntimeException -> IO (Ptr OUString)

{-
data RuntimeException = forall e . E.Exception e => RuntimeException e
    deriving Typeable

instance E.Exception RuntimeException where
    toException = unoExceptionToException
    fromException = unoExceptionFromException

runtimeExceptionToException :: E.Exception e => e -> E.SomeException
runtimeExceptionToException = E.toException . RuntimeException

runtimeExceptionFromException :: E.Exception e => E.SomeException -> Maybe e
runtimeExceptionFromException x = do
    RuntimeException a <- E.fromException x
    cast a
    -}
