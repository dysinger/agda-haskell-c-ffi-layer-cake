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

-------------
-- Helpers --
-------------

infixl 1 _&_

_&_ : ∀ {a} {A : Set a} {B : Set a} → (m₁ : IO A) → (m₂ : IO B) → IO B
_&_ x₁ x₂ = ♯ x₁ >> ♯ x₂

----------
-- Main --
----------

main : P.IO H.Unit
main = run (♯ (♯ hello >> ♯ lift hsHello) >> ♯ lift cHello)
