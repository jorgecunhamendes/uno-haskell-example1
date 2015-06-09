module LibreOffice.Util.XMacroExpander where

import SAL.Types
import UNO.Binary
import UNO.Service
import Text

import Control.Monad
import Data.Text (Text)
import Foreign.Marshal.Utils
import Foreign.Ptr
import Foreign.Storable

foreign import ccall "expandMacros" cExpandMacros
  :: Ptr UnoInterface
  -> Ptr (Ptr Any)
  -> Ptr OUString
  -> IO (Ptr OUString)

methodType :: String
methodType = "com.sun.star.util.XMacroExpander::expandMacros"

class Service a => XMacroExpander a where
  expandMacro :: a -> Text -> IO Text
  expandMacro a str = do
    let expanderIfc = getInterface a
    inOUString <- hs_text_to_oustring str
    with nullPtr $ \ exceptionPtr -> do
      -- UNO call
      result <- cExpandMacros expanderIfc exceptionPtr inOUString
      -- check for exceptions
      exception <- peek exceptionPtr
      when (exception /= nullPtr) $ error "makeBinaryUnoCall exception"
      -- read result
      out <- hs_oustring_to_text result
      c_delete_oustring result
      -- the end
      return out
