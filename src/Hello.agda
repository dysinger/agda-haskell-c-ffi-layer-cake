module Hello where

import Foreign.Haskell as H
import IO.Primitive    as P

open import Coinduction
open import Data.Unit
open import IO

----------
-- Agda --
----------

hello : IO ⊤
hello = putStrLn "hello (agda)"

-----------------------------------------
-- FFI to Haskell & to C (via Haskell) --
-----------------------------------------

{-# IMPORT Hello #-}

postulate
  hsHello : P.IO H.Unit
  cHello  : P.IO H.Unit

{-# COMPILED hsHello Hello.hsHello #-}
{-# COMPILED cHello  Hello.cHello  #-}

----------
-- Main --
----------

main : P.IO H.Unit
main = run (♯ (♯ hello >> ♯ lift hsHello) >> ♯ lift cHello)
