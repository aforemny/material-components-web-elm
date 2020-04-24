module Main exposing (main)

import Browser
import Html exposing (Html, text)
import Material.Button as Button
import Material.Typography as Typography


type alias Model =
    { count : Int }


initialModel : Model
initialModel =
    { count = 0 }


type Msg
    = Increment
    | Decrement


update : Msg -> Model -> Model
update msg model =
    case msg of
        Increment ->
            { model | count = model.count + 1 }

        Decrement ->
            { model | count = model.count - 1 }


view : Model -> Html Msg
view model =
    Html.div [ Typography.typography ]
        [ Button.raised (Button.config |> Button.setOnClick Increment) "+1"
        , Html.div [] [ text <| String.fromInt model.count ]
        , Button.raised (Button.config |> Button.setOnClick Decrement) "-1"
        ]


main : Program () Model Msg
main =
    Browser.sandbox
        { init = initialModel
        , view = view
        , update = update
        }
