{-# OPTIONS  #-}
-----------------------------------------------------------------------------
-- |
-- Module      : Language.Python.Univer.Lexer
-- Copyright   : (c) 2009 Bernie Pope
-- License     : BSD-style
-- Maintainer  : bjpop@csse.unimelb.edu.au
-- Stability   : experimental
-- Portability : ghc
--
-- Lexical analysis for Python version 2.x and 3.x programs.
-----------------------------------------------------------------------------

module Language.Python.Univer.Lexer (
   -- * Lexical analysis
   lex,
   lexOneToken
) where

import Prelude hiding (lex)
import Language.Python.Univer.Parser.Lexer (lexToken, initStartCodeStack)
import Language.Python.Common.Token as Token
import Language.Python.Common.SrcLocation (initialSrcLocation)
import Language.Python.Common.ParserMonad
       (ParseState (input), P, runParser, execParser, ParseError, initialState)

initLexState :: String -> String -> ParseState
initLexState input srcName = 
   initialState (initialSrcLocation srcName) input initStartCodeStack

-- | Parse a string into a list of Python Tokens, or return an error. 
lex :: String -- ^ The input stream (python source code). 
    -> String -- ^ The name of the python source (filename or input device).
    -> Either ParseError [Token] -- ^ An error or a list of tokens.
lex input srcName =
   execParser lexer $ initLexState input srcName

-- | Try to lex the first token in an input string. Return either a parse error
-- or a pair containing the next token and the rest of the input after the token.
lexOneToken :: String -- ^ The input stream (python source code).
         -> String -- ^ The name of the python source (filename or input device).
         -> Either ParseError (Token, String) -- ^ An error or the next token and the rest of the input after the token. 
lexOneToken source srcName =
   case runParser lexToken state of
      Left err -> Left err
      Right (tok, state) -> Right (tok, input state)
   where state = initLexState source srcName

lexer :: P [Token]
lexer = loop []
   where
   loop toks = do
      tok <- lexToken
      case tok of
         EOFToken {} -> return (reverse toks)
         other -> loop (tok:toks)
