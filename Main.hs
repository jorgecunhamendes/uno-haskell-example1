{-# LANGUAGE ForeignFunctionInterface
           , OverloadedStrings #-}
module Main where

import Text

import Control.Monad
import Data.Text (Text, unpack)
import Foreign.C
import Foreign.Marshal.Array
import Foreign.Marshal.Utils
import Foreign.Ptr
import Foreign.Storable

data UnoInterface
data Any

inText :: Text
inText = "test: $UNO_TYPES :test"

methodType :: String
methodType = "com.sun.star.util.XMacroExpander::expandMacros"

foreign import ccall "setUp" setUp
  :: IO (Ptr UnoInterface) -- uno_Interface *

foreign import ccall "makeBinaryUnoCall" makeBinaryUnoCall
  :: Ptr UnoInterface        -- uno_Interface * UNO interface
  -> CString                 -- char const * method type
  -> Ptr (Ptr UString)       -- void * result
  -> Ptr (Ptr (Ptr UString)) -- void ** arguments
  -> Ptr (Ptr Any)           -- uno_Any ** exception
  -> IO ()

main :: IO ()
main = do
  -- bootstrap
  expanderIfc <- setUp
  -- initialize arguments
  inOUString   <- hs_text_to_oustring inText
  inUString    <- oustringToUString inOUString
  with nullPtr $ \ resultPtr ->
    with inUString $ \ inUStringPtr ->
      withArray [inUStringPtr] $ \ args ->
        with nullPtr $ \ exceptionPtr ->
          withCString methodType $ \ cMethodType -> do
            -- UNO call
            makeBinaryUnoCall expanderIfc cMethodType resultPtr args exceptionPtr
            -- check for exceptions
            exception <- peek exceptionPtr
            when (exception /= nullPtr) $ error "makeBinaryUnoCall exception"
            -- read result
            result <- peek resultPtr
            oustr <- ustringToOUString result
            out <- hs_oustring_to_text oustr
            c_delete_oustring oustr
            -- the end
            putStrLn (unpack out)
  return ()
