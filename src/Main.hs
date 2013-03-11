module Main where

import System.Environment (getArgs)
import qualified Language.Python.Univer.Lexer as UniverLexer
import qualified Language.Python.Univer.Parser as UniverParser
import qualified Language.Python.Version3.Lexer as Version3Lexer
import qualified Language.Python.Version3.Parser as Version3Parser

main = do
  filename <- fmap head getArgs
  content  <- readFile filename
  putStrLn (show (UniverParser.parseModule content filename))
  putStrLn ""
  putStrLn (show (Version3Parser.parseModule content filename))
