# bitmapped

[![Code Climate](https://codeclimate.com/github/ashleyconnor/bitmapped/badges/gpa.svg)](https://codeclimate.com/github/ashleyconnor/bitmapped) [![Build Status](https://travis-ci.org/ashleyconnor/bitmapped.svg)](https://travis-ci.org/ashleyconnor/
bitmapped) [![Build Status](https://drone.io/github.com/ashleyconnor/bitmapped/status.png)](https://drone.io/github.com/ashleyconnor/bitmapped/latest) [![Gem Version](https://badge.fury.io/rb/bitmapped.svg)](http://badge.fury.io/rb/bitmapped)

## Description

Bitmapped is an command-line editor which allows you to create and edit bitmap-like text images.

## Features

Bitmapped accepts various commands to create and edit bitmap-like text images:

| Command             | Description                                                | Key | Parameters                             |
|---------------------|------------------------------------------------------------|-----|----------------------------------------|
| Initiate Bitmap     | Initiates a Bitmap of the given size                       | I   | Columns:Int, Rows:Int                  |
| Clear               | Clears the Bitmap setting all cells to "0"                 | C   |                                        |
| Color Cell          | Colors the cell at the given co-ordinates                  | L   | Column:Int, Row:Int, Color:String      |
| Vertically Line     | Colors multiple cells on specified column between rows X Y | V   | Column:Int, Row:X, Row:Y, Color:String |
| Horizontal Line     | Colors multiple cells on specified row between rows X Y    | H   | Row:X, Row:Y, Row:Int, Color:String    |
| Fill (Paint Bucket) | Fills a given cell and surrounding cells of the same color | F   | Column:Int, Row:Int, Color:String      |
| Show Table      | Displays the table on the CLI                                   | S   |                                        |
| Show Pretty Table      | Displays a pretty table on the CLI                                   | T   |                                        |
| Mirror          | Mirrors the image along the vertical axis                       | M   |                                        |
| Rotate          | Rotates the image 90 degrees clockwise                          | R   |                                        |
| Invert          | Inverts image swapping colors with opposites (Z>A, Y>B, X>C etc)| N   |                                        |
| Exit                | Exits the program                                          | X   |                                        |


## Examples
    bitmapped
    > I 5 6
    > L 2 3 A
    > S
    OOOOO
    OOOOO
    OAOOO
    OOOOO
    OOOOO
    OOOOO
    > F 3 3 J
    > V 2 3 4 W
    > H 3 4 2 Z
    > S
    JJJJJ
    JJZZJ
    JWJJJ
    JWJJJ
    JJJJJ
    JJJJJ
    > R
    > S
    JJJJJJ
    JJWWJJ
    JJJJZJ
    JJJJZJ
    JJJJJJ
    > M
    > S
    JJJJJJ
    JJWWJJ
    JZJJJJ
    JZJJJJ
    JJJJJJ
    > N
    > S
    QQQQQQ
    QQDDQQ
    QAQQQQ
    QAQQQQ
    QQQQQQ
    > T
    +---+---+---+---+---+---+
    | Q | Q | Q | Q | Q | Q |
    | Q | Q | D | D | Q | Q |
    | Q | A | Q | Q | Q | Q |
    | Q | A | Q | Q | Q | Q |
    | Q | Q | Q | Q | Q | Q |
    +---+---+---+---+---+---+

## Requirements
    Ruby 2.0+
## Install

    $ gem install bitmapped

## TODO

* Refactor tests

### Copyright

Copyright (c) 2015 **Ashley Connor**

See LICENSE.txt for details.