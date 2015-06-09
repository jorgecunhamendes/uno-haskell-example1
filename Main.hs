{-# LANGUAGE OverloadedStrings #-}
module Main where

import LibreOffice.Util.TheMacroExpander
import LibreOffice.Util.XMacroExpander
import UNO.Binary

import Data.Text (Text, unpack)

inText :: Text
inText = "test: $UNO_TYPES :test"

main :: IO ()
main = do
  unoBootstrap
  tME <- theMacroExpanderNew
  outText <- expandMacro tME inText
  putStrLn (unpack outText)
  return ()
