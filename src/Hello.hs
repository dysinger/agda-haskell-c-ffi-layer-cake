{-# LANGUAGE ForeignFunctionInterface #-}

module Hello where

import Foreign
import Foreign.C.Types

-------------
-- Haskell --
-------------

hsHello :: IO ()
hsHello = putStrLn "hello (haskell)"

-------------
-- FFI (C) --
-------------

foreign import ccall "hello.h hello"
  cHello :: IO ()
