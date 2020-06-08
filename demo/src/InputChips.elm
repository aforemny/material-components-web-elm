module InputChips exposing (..)

import Browser
import Browser.Dom
import Browser.Events
import Html exposing (Html, text)
import Html.Attributes exposing (style)
import Html.Events
import Json.Decode as Decode
import Json.Encode as Encode
import Material.Chip.Choice as ChoiceChip
import Material.Chip.Input as InputChip
import Material.ChipSet.Choice as ChoiceChipSet
import Material.ChipSet.Input as InputChipSet
import Task exposing (Task)


main =
    Browser.element
        { init = init
        , update = update
        , subscriptions = subscriptions
        , view = view
        }


type alias Model =
    { input : String
    , words : List String
    , leftPadding : Float
    }


init : () -> ( Model, Cmd Msg )
init flags =
    ( { input = ""
      , words = [ "Portland", "Biking" ]
      , leftPadding = 0
      }
    , getLeftPadding
    )


getLeftPadding : Cmd Msg
getLeftPadding =
    Browser.Dom.getElement "chip-set-wrapper"
        |> Task.map (\{ element } -> element.width)
        |> Task.attempt PaddingChanged


type Msg
    = InputChanged String
    | KeyPressed Int
    | PaddingChanged (Result Browser.Dom.Error Float)
    | Resized Int Int
    | Deleted String


subscriptions : Model -> Sub Msg
subscriptions model =
    Browser.Events.onResize Resized


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        InputChanged newInput ->
            ( { model | input = newInput }, Cmd.none )

        KeyPressed keyCode ->
            let
                enter =
                    13

                backspace =
                    8

                trimmedInput =
                    String.trim model.input
            in
            if keyCode == enter then
                ( { model
                    | input = ""
                    , words =
                        if
                            not <|
                                String.isEmpty trimmedInput
                                    || List.member trimmedInput model.words
                        then
                            model.words ++ [ trimmedInput ]

                        else
                            model.words
                  }
                , getLeftPadding
                )

            else if keyCode == backspace && model.input == "" then
                ( { model | words = List.take (List.length model.words - 1) model.words }
                , getLeftPadding
                )

            else
                ( model, Cmd.none )

        PaddingChanged (Err _) ->
            ( model, Cmd.none )

        PaddingChanged (Ok leftPadding) ->
            ( { model | leftPadding = leftPadding }, Cmd.none )

        Resized width height ->
            ( model, getLeftPadding )

        Deleted word ->
            ( { model | words = List.filter ((/=) word) model.words }, getLeftPadding )


view : Model -> Html Msg
view model =
    Html.div
        [ style "position" "relative"
        , style "display" "flex"
        , style "min-height" "48px"
        , style "max-width" "100vw"
        , style "overflow-x" "auto"
        ]
        [ Html.input
            [ Html.Events.onInput InputChanged
            , Html.Events.on "keydown" (Decode.map KeyPressed Html.Events.keyCode)
            , Html.Attributes.value model.input
            , style "position" "absolute"
            , style "display" "flex"
            , style "width" "100%"
            , style "height" "100%"
            , style "margin" "0"
            , style "border" "none"
            , style "padding" ("0 0 0 " ++ String.fromFloat model.leftPadding ++ "px")
            , style "box-sizing" "border-box"
            ]
            []
        , Html.div
            [ Html.Attributes.id "chip-set-wrapper" ]
            [ InputChipSet.chipSet
                (InputChipSet.config
                    { toLabel = identity
                    }
                )
                (List.map
                    (\label ->
                        ( label
                        , InputChip.chip
                            (InputChip.config
                                |> InputChip.setOnDelete (Deleted label)
                            )
                            label
                        )
                    )
                    model.words
                )
            ]
        , Html.node "style"
            [ Html.Attributes.type_ "text/css" ]
            [ text
                """
                .mdc-chipset--input {
                  pointer-events: none;
                  flex-wrap: nowrap; }
                .mdc-chipset--input .mdc-touch-target-wrapper {
                  pointer-events: auto; }
                """
            ]
        ]
