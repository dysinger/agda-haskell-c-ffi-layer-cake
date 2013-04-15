module Hello where

import Foreign.Haskell as Hask
import IO.Primitive    as Prim

open import Coinduction
open import Data.Unit
open import IO

----------
-- Agda --
----------

agHello : IO ⊤
agHello = putStrLn "hello (agda)"

-----------------------------------------
-- FFI to Haskell & to C (via Haskell) --
-----------------------------------------

{-# IMPORT Hello #-}

postulate
  hsHello : Prim.IO Hask.Unit
  cHello  : Prim.IO Hask.Unit

{-# COMPILED hsHello Hello.hsHello #-}
{-# COMPILED cHello  Hello.cHello  #-}

-------------
-- Helpers --
-------------

infixl 1 _&_

_&_ : ∀ {a} {A : Set a} {B : Set a} → IO A → IO B → IO B
_&_ m₁ m₂ = ♯ m₁ >> ♯ m₂

----------
-- Main --
----------

hello : IO Hask.Unit
hello = agHello & lift cHello & lift hsHello

main : Prim.IO Hask.Unit
main = run hello
