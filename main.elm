module Main exposing (..)

import Html exposing (..)
import Html.App as App
import Collage exposing (..)
import Element exposing (..)
import Tetronimo exposing (Tetronimo)

type Msg = Reset | Update

model : Tetronimo
model =
    Tetronimo.rotate Tetronimo.i


update : Msg -> Tetronimo -> Tetronimo
update msg tetronimo =
  case msg of
    Reset -> tetronimo
    Update -> tetronimo

view: Tetronimo -> Html a
view model =
    toHtml (collage 400 400  [Tetronimo.toForm model, Tetronimo.drawPivot model])


main: Program Never
main =
  App.beginnerProgram { model = model, view = view, update = update }