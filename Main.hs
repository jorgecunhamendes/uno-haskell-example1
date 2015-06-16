{-# LANGUAGE OverloadedStrings #-}
module Main where

import LibreOffice.Lang.IllegalArgumentException
import LibreOffice.Util.TheMacroExpander
import LibreOffice.Util.XMacroExpander
import UNO.Binary

import qualified Control.Exception as E
import Data.Text (Text, unpack)

inText :: Text
inText = "test: $UNO_TYPES :test"

main :: IO ()
main = do
  unoBootstrap
  tME <- theMacroExpanderNew
  outText <- expandMacros tME inText `E.catch` illegalArgEx
  putStrLn (unpack outText)
  putStrLn "end of program"
  return ()

illegalArgEx :: IllegalArgumentException -> IO Text
illegalArgEx (IllegalArgumentException _ i) = do
    putStrLn ("IllegalArgumentException: " ++ show i)
    return "### ERROR ###"
