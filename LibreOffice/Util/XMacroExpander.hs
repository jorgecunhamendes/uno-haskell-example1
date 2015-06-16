module LibreOffice.Util.XMacroExpander where

import LibreOffice.Lang.IllegalArgumentException
import SAL.Types
import UNO.Binary
import UNO.Service
import Text

import qualified Control.Exception as E
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
  expandMacros :: a -> Text -> IO Text
  expandMacros a str = do
    let expanderIfc = getInterface a
    inOUString <- hs_text_to_oustring str
    with nullPtr $ \ exceptionPtr -> do
      -- UNO call
      result <- cExpandMacros expanderIfc exceptionPtr inOUString
      -- check for exceptions
      aException <- peek exceptionPtr
      -- uncomment next line to throw exception for testing
      -- (putStrLn "throwing" >> anyToIllegalArgumentException exceptionPtr >>= E.throw)
      when (aException /= nullPtr) (putStrLn "throwing" >> anyToIllegalArgumentException exceptionPtr >>= E.throw)
      -- when (aException /= nullPtr) $ error "expandMacros"
      -- read result
      out <- hs_oustring_to_text result
      c_delete_oustring result
      -- the end
      return out
