{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RecordWildCards   #-}

module Lib
    ( 
    Parser,

    Identifier(..),
    identifier,
    Atomic(..),
    atomic,

    Expr(..),
    accept,

    add,
    add2,
    add3
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

data Atomic = 
    AIdentifier Identifier
    | ALiteral Integer
    deriving (Show, Eq)

data Expr = 
    Accept Identifier
    | Add [Atomic] [Identifier] -- sources, targets
    deriving (Show, Eq)

-- From https://serokell.io/blog/parser-combinators-in-haskell#identifiers
identifier :: Parser Identifier
identifier = Identifier <$> label "identifier" ((:) <$> (letterChar <|> char '_') <*> many (alphaNumChar <|> char '_' <|> char '-'))

atomic :: Parser Atomic
atomic = (AIdentifier <$> identifier) <|> (ALiteral <$> L.decimal)

accept :: Parser Expr
accept = Accept <$> (string "ACCEPT" *> space *> identifier)

add :: Parser Expr
add = try add3 <|> add2

add2 :: Parser Expr
add2 = do
    string "ADD" *> space
    sources <- atomic

    space *> string "TO" *> space
    target <- identifier

    return $ Add [sources] [target]

add3 :: Parser Expr
add3 = do
    string "ADD" *> space
    sources <- atomic `sepBy1` space

    space *> string "TO" *> space
    target <- atomic

    space *> string "GIVING" *> space
    givings <- identifier `sepBy1` space

    return $ Add (target:sources) givings


