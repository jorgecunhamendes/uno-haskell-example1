# Haskell UNO Language Binding – Example 1

This repository contains a sample program that uses the LibreOffice UNO. The
goal is to get an idea how to structure the Haskell UNO language binding.

## Requirements

   - GHC
   - cabal-install (with support for sandboxes)
   - LibreOffice SDK

Note that some older versions might not be suitable.

## Setting Up

These instructions are for a quick try. Other setups are possible.

   - Clone the repository
   - Initialize the sandbox (`cabal sandbox init`)
   - Install dependencies (`cabal install text`)
   - Set LO_INSTDIR to LibreOffice's installation directory (e.g., `export LO_INSTDIR=/path/to/LibreOffice`)
   - Compile (`make`)
   - Run (`make run`)
