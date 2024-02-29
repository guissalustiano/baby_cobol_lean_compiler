{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RecordWildCards   #-}

module Lib
    ( 
    Parser,
    Identifier(..),
    identifier
    ) where

import Data.Void
import Text.Megaparsec hiding (State)
import Text.Megaparsec.Char
import Control.Applicative hiding (many)
import Control.Monad
import qualified Data.Text as T
import qualified Text.Megaparsec.Char.Lexer as L

type Parser = Parsec Void String

newtype Identifier = Identifier String
    deriving (Show, Eq)

-- From https://serokell.io/blog/parser-combinators-in-haskell#identifiers
identifier :: Parser Identifier
identifier = Identifier <$> label "identifier" ((:) <$> (letterChar <|> char '_') <*> many (alphaNumChar <|> char '_'))

data Expr = 
    Accept Identifier

parseAccept :: Parser Expr
parseAccept = do
    void (string "ACCEPT")
    space
    Accept <$> identifier



