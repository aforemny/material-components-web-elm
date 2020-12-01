module Demo.CircularProgress exposing (Model, Msg, defaultModel, update, view)

import Demo.CatalogPage exposing (CatalogPage)
import Html exposing (text)
import Html.Attributes
import Material.CircularProgress as CircularProgress
import Material.Typography as Typography


type alias Model =
    {}


defaultModel : Model
defaultModel =
    {}


type Msg
    = NoOp


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    ( model, Cmd.none )


view : Model -> CatalogPage Msg
view model =
    { title = "Circular Progress Indicator"
    , prelude = "Progress indicators display the length of a process or express an unspecified wait time."
    , resources =
        { materialDesignGuidelines =
            Just "https://material.io/go/design-progress-indicators"
        , documentation =
            Just
                "https://package.elm-lang.org/packages/aforemny/material-components-web-elm/latest/Material-CircularProgress"
        , sourceCode =
            Just
                "https://github.com/material-components/material-components-web/tree/master/packages/mdc-circular-progress"
        }
    , hero = [ CircularProgress.determinate CircularProgress.config { progress = 0.67 } ]
    , content =
        [ Html.h3 [ Typography.subtitle1 ] [ text "Large" ]
        , CircularProgress.indeterminate
            (CircularProgress.config
                |> CircularProgress.setSize CircularProgress.large
            )
        , Html.h3 [ Typography.subtitle1 ] [ text "Medium" ]
        , CircularProgress.indeterminate
            (CircularProgress.config
                |> CircularProgress.setSize CircularProgress.medium
            )
        , Html.h3 [ Typography.subtitle1 ] [ text "Small" ]
        , CircularProgress.indeterminate
            (CircularProgress.config
                |> CircularProgress.setSize CircularProgress.small
            )
        , Html.h3 [ Typography.subtitle1 ] [ text "Four Colored" ]
        , CircularProgress.indeterminate
            (CircularProgress.config
                |> CircularProgress.setFourColored True
            )
        , Html.node "style"
            [ Html.Attributes.type_ "text/css" ]
            [ text
                """
                .mdc-circular-progress__color-1
                .mdc-circular-progress__indeterminate-circle-graphic {
                  stroke: #000; }
                .mdc-circular-progress__color-2
                .mdc-circular-progress__indeterminate-circle-graphic {
                  stroke: #f00; }
                .mdc-circular-progress__color-3
                .mdc-circular-progress__indeterminate-circle-graphic {
                  stroke: #0f0; }
                .mdc-circular-progress__color-4
                .mdc-circular-progress__indeterminate-circle-graphic {
                  stroke: #00f; }
                """
            ]
        ]
    }
