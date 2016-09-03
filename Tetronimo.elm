module Tetronimo exposing (..)

import Block exposing (Block)
import Basics exposing (..)
import Color exposing (..)
import Collage exposing (..)
import List

type alias Location = (Int, Int)

type alias Pivot = { r : Float, c : Float }

type alias Tetronimo = { shape : List Location
                        , block: Block
                        , pivot : Pivot
                        , rows : Int
                        , cols : Int
                       }

toForm : Tetronimo -> Form
toForm { shape, block } =
    let form = Block.toForm block
        translate (row, col) = move ((toFloat col) * Block.size,
                                 (toFloat row) * Block.size) form
        forms = List.map translate shape
    in group forms



i : Tetronimo
i = { shape = [ (1, 0)
              , (0, 0)
              , (-1, 0)
              , (-2, 0)]
     , block = Block Color.lightBlue
     , pivot = { c = 0.5, r = -0.5}
     , rows = 4
     , cols = 1
    }

j : Tetronimo
j = { shape = [         (1, 0)
                        , (0, 0)
            , (-1, -1), (-1, 0)]
     , block = Block Color.blue
     , pivot = { r = 0.0, c = 0.0 }
     , rows = 3
     , cols = 2
    }

drawPivot : Tetronimo -> Form
drawPivot { pivot } =
    let dot = circle 5 |> filled Color.black
        translate = move ( pivot.c  * Block.size , pivot.r * Block.size )
    in translate dot

rotateLocation : Pivot -> Float -> Location -> Location
rotateLocation pivot angle (row, col) =
    let rowOrigin = (toFloat row) - pivot.r
        colOrigin = (toFloat col) - pivot.c
        (s, c) = (sin(angle), cos(angle))
        rowRotated = rowOrigin * c - colOrigin * s
        colRotated = rowOrigin * s + colOrigin * c
    in (round <| rowRotated + pivot.r, round <| colRotated + pivot.c)

rotate: Tetronimo -> Tetronimo
rotate tetronimo =
    let rotateHelper = rotateLocation tetronimo.pivot (degrees 90)
        newShape = List.map rotateHelper tetronimo.shape
    in { tetronimo | shape = newShape,
                        rows = tetronimo.cols
                        , cols = tetronimo.rows}

