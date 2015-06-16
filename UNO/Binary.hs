module UNO.Binary where

import LibreOffice.UNO.Exception
import SAL.Types

import Foreign

data UnoInterface

foreign import ccall "bootstrap" unoBootstrap
  :: IO ()

foreign import ccall "anyToException" cAnyToException
  :: Ptr Any -> IO (Ptr Exception)

anyToException :: Ptr Any -> IO Exception
anyToException aptr = cAnyToException aptr >>= peek
