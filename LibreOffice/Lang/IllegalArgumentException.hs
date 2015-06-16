{-# LANGUAGE ExistentialQuantification, DeriveDataTypeable #-}
module LibreOffice.Lang.IllegalArgumentException where

import SAL.Types
import Text

import Data.Int
import Data.Text (Text)
import Data.Typeable
import qualified Control.Exception as E
import Foreign

data IllegalArgumentException
    = IllegalArgumentException Text Int16 -- ^ArgumentPosition
    deriving (Show, Typeable)

instance E.Exception IllegalArgumentException

peekIllegalArgumentException :: Ptr IllegalArgumentException -> IO IllegalArgumentException
peekIllegalArgumentException eptr = do  
    msg <- peekOUString =<< illegalArgumentExceptionGetMessage eptr
    idx <- illegalArgumentExceptionGetArgumentPosition eptr
    print (IllegalArgumentException msg idx)
    return (IllegalArgumentException msg idx)

foreign import ccall "hsuno_illegalArgumentExceptionGetMessage"
    illegalArgumentExceptionGetMessage :: Ptr IllegalArgumentException -> IO (Ptr OUString)

foreign import ccall "hsuno_illegalArgumentExceptionGetArgumentPosition"
    illegalArgumentExceptionGetArgumentPosition :: Ptr IllegalArgumentException -> IO Int16

foreign import ccall "anyToIllegalArgumentException" cAnyToIllegalArgumentException
  :: Ptr (Ptr Any) -> IO (Ptr IllegalArgumentException)

anyToIllegalArgumentException :: Ptr (Ptr Any) -> IO IllegalArgumentException
anyToIllegalArgumentException aptr = do
    eptr <- cAnyToIllegalArgumentException aptr
    peekIllegalArgumentException eptr
