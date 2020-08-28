module Tabler
( Item (Item, Link)
, mkColumn
, Column
, Style (Style, table, td, th, tr)
, default_style
, mkTable
) where

import Data.List (transpose)
import System.IO

tag :: String -> String -> String
tag t body = "<"++t++">" ++ body ++ "</"++t++">\n"

tagn :: String -> String -> String
tagn t body = "<"++t++">\n" ++ body ++ "</"++t++">\n"

tagt :: String -> String -> String
tagt t body = "\t<"++t++">" ++ body ++ "</"++t++">\n"

data Title = Title String
instance Show Title where
    show (Title title) = tagt "th" title


data Item = Item String | Link String String
instance Show Item where
    show (Item name) = tagt "td" name
    show (Link name url) = tagt "td" $ "<a href=\"" ++ url ++ "\">" ++ name ++ "</a>"

data Column = Column Title [Item]

mkColumn :: String -> [Item] -> Column
mkColumn str items = Column (Title str) items

data Table = Table [Title] [[Item]]
instance Show Table where
    show (Table titles rows) = tagn "table" $ titles' ++ rows'
        where   titles' = tr $ join (map show titles)
                rows' = join $ map (tr . join) $ map (map show) rows
                tr = tagn "tr"
                join str = foldl (++) "" str

data Style = Style { body :: String
                   , table :: String
                   , td :: String
                   , th :: String
                   , tr :: String
                   }
instance Show Style where
    show style = tagn "head" $
                 tagn "style" $
                 "\tbody {" ++ body style ++ "}\n\
                 \\ttable {" ++ (table style) ++ "}\n\
                 \\ttd {" ++ (td style) ++ "}\n\
                 \\tth {" ++ (th style) ++ "}\n\
                 \\ttr:nth-child(even) {" ++ (tr style) ++ "}\n"

default_style = Style { body = "", table = "", td = "", th = "", tr = "" }


html :: Style -> String -> String
html style body = top ++ (tagn "html" (show style ++ (tagn "body" body)))
    where   top = "<!DOCTYPE html>\n"


convert :: [Column] -> Table
convert columns = Table titles rows
    where   titles = map (\(Column title _) -> title) columns
            rows = transpose $ fixLengths $ map (\(Column _ row) -> row) columns

fixLengths :: [[Item]] -> [[Item]]
fixLengths lists = map addMissing lists
    where max_len = maximum $ map length lists
          missingCount l = max_len - length l
          addMissing l = l ++ replicate (missingCount l) (Item "")


mkTable :: FilePath -> Style -> [Column] -> IO ()
mkTable filepath style columns = writeFile filepath $ html style $ show $ convert columns
