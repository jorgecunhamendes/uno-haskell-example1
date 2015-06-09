module LibreOffice.Util.TheMacroExpander where

import LibreOffice.Util.XMacroExpander
import UNO.Binary
import UNO.Service

import Control.Applicative ((<$>))
import Foreign.Ptr

data TheMacroExpander = TheMacroExpander (Ptr UnoInterface)

instance Service TheMacroExpander where
    getInterface (TheMacroExpander iface) = iface

instance XMacroExpander TheMacroExpander where
    -- use default implementation

theMacroExpanderNew :: IO (TheMacroExpander)
theMacroExpanderNew = TheMacroExpander <$> cTheMacroExpander_new

foreign import ccall "theMacroExpander_new" cTheMacroExpander_new
    :: IO (Ptr UnoInterface)
