module Hello where

import Foreign.Haskell as H
import IO.Primitive    as P

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
  hsHello : P.IO H.Unit
  cHello  : P.IO H.Unit

{-# COMPILED hsHello Hello.hsHello #-}
{-# COMPILED cHello  Hello.cHello  #-}

-------------
-- Helpers --
-------------

infixl 1 _&_

_&_ : ∀ {a} {A : Set a} {B : Set a} → IO A → IO B → IO B
_&_ x₁ x₂ = ♯ x₁ >> ♯ x₂

----------
-- Main --
----------

hello : IO H.Unit
hello = agHello & lift cHello & lift hsHello

main : P.IO H.Unit
main = run hello
