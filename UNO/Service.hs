module UNO.Service where

import UNO.Binary

import Foreign.Ptr

class Service a where
    getInterface :: a -> Ptr UnoInterface
