-----------------------------------------------------------------------------
-- |
-- Module      : Language.Python.Univer
-- Copyright   : (c) 2009 Bernie Pope
-- License     : BSD-style
-- Maintainer  : bjpop@csse.unimelb.edu.au
-- Stability   : experimental
-- Portability : ghc
--
-- A convenient re-export of the parser and lexer for version 2.x and 3.x of
-- Python.
-----------------------------------------------------------------------------

module Language.Python.Univer (
  -- * The parser
  module Language.Python.Univer.Parser,
  -- * The lexer
  module Language.Python.Univer.Lexer
) where

import Language.Python.Univer.Parser
import Language.Python.Univer.Lexer
