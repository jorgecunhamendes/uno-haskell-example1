module UNO.Binary where

data UnoInterface

foreign import ccall "bootstrap" unoBootstrap
  :: IO ()
