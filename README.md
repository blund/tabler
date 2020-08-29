# tabler
A tool for making html tables

## What is this?
Writing HTML tables is a drag, and I wanted to have some easily editable tables
on my personal website, but still keep it to just a plain HTML file.

This is why I decided to write a simple utility to do the work of writing out
the boilerplate a html table needs.

There still is quite a bit of boilerplate-work to use this, so I might just
write a parser for friendly input language.

## How do I use this?

As for now, the table is defined in a Haskell-file.
The various columns in your table are defined like this:
```
example = mkColumn "This is the title of the column!"
    [ Item "This is how you write out plain text"
    , Link "And this is a link!" "https://example.com"
    ]
```

Next we define what we want the output file to be called, and where we want it to be:
```
output_file = "example.html"
```


You can also configure the style of the table. This is a bit.. wonky as of right now, but you do it by just passing some css as strings. This is likely to change.

```
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
```

And there we have it! Everything we had to is done. Now we just define
the main-function and add the columns we want into the list like this:
```
main = mkTable output_file style [example, your_table, endless_possibilites]
```
And run this main file with this function
```
ghc -e main yourfile.hs
```

Thins to do:
* HTML configuration will be made more clean at a later point.
* Define a syntax and write a parser so we don't have to write all this boilerplate code..
