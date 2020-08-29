import Tabler

-- | This is an example configuration for writing a html table with Tabler.
-- Below you will see three variables of the type 'Column'. These define the
-- different columns that will be in the resulting table.

-- You define a column using the 'mkColumn' function.
-- It takes two arguments, the name of the column as a string and a
-- list of the cells in the column.
--
-- These cells can be of two types, 'Link' or 'Item'.
-- Links are made with the Link-constructor and two strings.
-- The first tis the text to display and the second is the url to open.
-- 'Item's are just strings. These might be renamed to Text, but Item does for now
-- Items are made simply using the Item-constructor and passing the string you want
-- to display
--
-- At the bottom of the file we define a few more things..


resources :: Column
resources = mkColumn "Resources"
    [ Link "HTML TablesTables" "https://www.w3schools.com/html/html_tables.asp"
    , Link "HTML Links" "https://www.w3schools.com/html/html_links.asp"
    , Link "Haskell function reference" "http://zvon.org/other/haskell/Outputglobal/index.html"
    , Link "Project GitHub" "https://github.com/blund/tabler"
    ]

todos :: Column
todos = mkColumn "Todo:"
    [ Item "[x] Write example file"
    , Item "[ ] Define syntax"
    , Item "[ ] Write parser"
    ]

distractions :: Column
distractions = mkColumn "Distractions"
    [ Link "Scorchfountain" "https://www.youtube.com/watch?v=ojT99rDmq5M&list=PLXX7Rp0iXj0l998LmVC6xIRHjtj2Pr2VI"
    , Link "Godless country" "https://www.youtube.com/watch?v=awcQ9-QvZLs"
    , Link "Closet cat" "https://www.youtube.com/watch?v=HVC6RL3TyZI"
    ]

-- | Here we have the final things to define.
-- First we have the 'output_file', which is where the resulting
-- html file will be written.

output_file :: FilePath
output_file = "example.html"

-- | Here is the style defined. This is just simple html/css stuff as strings.
-- Think I might just keep it this way for now.

style :: Style
style = default_style
        { table = "font-family: arial;\
                \ border-collapse: collapse;\
                \ margin: 0 auto;\
                \ text-align: center;\
                \ width: 80%;"
        , td =  "border: 1px solid #dddddd;\
                \ text-align: left;\
                \ padding: 8px;"
        , th =  td style
        , tr =  "background-color: #dddddd;"
        }

-- | And here is the main function! Here we simply pass the
-- filepath defined above, our desired style (can be 'default_style' too)
-- and at last the list of columns to print. mkTable will take care of
-- converting this to a nice html file.

main :: IO ()
main = mkTable output_file style [resources, todos, distractions]
