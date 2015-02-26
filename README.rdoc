# bitmapped

[![Code Climate](https://codeclimate.com/github/ashleyconnor/bitmapped/badges/gpa.svg)](https://codeclimate.com/github/ashleyconnor/bitmapped) [![Build Status](https://travis-ci.org/ashleyconnor/bitmapped.svg)](https://travis-ci.org/ashleyconnor/bitmapped)

## Description

Bitmapped is an command-line editor which allows you to create and edit bitmap-like text images.

## Features

Bitmapped accepts various commands to create and edit bitmap-like text images:

| Command             | Description                                                | Key | Parameters                          |
|---------------------|------------------------------------------------------------|-----|-------------------------------------|
| Initiate Bitmap     | Initiates a Bitmap of the given size                       | I   | Columns:Int, Rows:Int               |
| Clear               | Clears the Bitmap setting all cells to "0"                 | C   |                                     |
| Color Cell          | Colors the cell at the given co-ordinates                  | L   | Column:Int Row:Int Color:String     |
| Vertically Line     | Colors multiple cells on specified column between rows X Y | V   | Column:Int Row:X Row:Y Color:String |
| Horizontal Line     | Colors multiple cells on specified row between rows X Y    | H   | Row:X Row:Y Row:Int Color:String    |
| Fill (Paint Bucket) | Fills a given cell and surrounding cells of the same color | F   | Column:Int Row:Int Color:String     |
| Exit                | Exits the CLI program                                      | X   |                                     |


## Examples
    bundle exec bitmapped
    > I 5 6
    > L 2 3 A
    > S
    +---+---+---+---+---+
    | 0 | 0 | 0 | 0 | 0 |
    | 0 | 0 | 0 | 0 | 0 |
    | 0 | 0 | 0 | 0 | 0 |
    | 0 | 0 | 0 | 0 | 0 |
    | 0 | 0 | 0 | 0 | 0 |
    | 0 | 0 | 0 | 0 | 0 |
    +---+---+---+---+---+
    > F 3 3 J
    > V 2 3 4 W
    > H 3 4 2 Z
    > S
    +---+---+---+---+---+
    | J | J | J | J | J |
    | J | J | Z | Z | J |
    | J | W | J | J | J |
    | J | W | J | J | J |
    | J | J | J | J | J |
    | J | J | J | J | J |
    +---+---+---+---+---+

## Requirements
    Ruby 2.0+
## Install

    $ gem install bitmapped

## TODO

### Copyright

Copyright (c) 2015 **Ashley Connor**

See LICENSE.txt for details.