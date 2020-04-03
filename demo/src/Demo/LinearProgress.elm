module Demo.LinearProgress exposing (Model, Msg, defaultModel, update, view)

import Demo.CatalogPage exposing (CatalogPage)
import Demo.Helper.ResourceLink as ResourceLink
import Html exposing (Html, text)
import Html.Attributes
import Material.LinearProgress as LinearProgress
import Material.Typography as Typography


type alias Model =
    {}


defaultModel : Model
defaultModel =
    {}


type Msg
    = NoOp


update : Msg -> Model -> Model
update msg model =
    model


view : Model -> CatalogPage Msg
view model =
    { title = "Linear Progress Indicator"
    , prelude = "Progress indicators display the length of a process or express an unspecified wait time."
    , resources =
        { materialDesignGuidelines = Just "https://material.io/go/design-progress-indicators"
        , documentation = Just "https://package.elm-lang.org/packages/aforemny/material-components-web-elm/latest/Material-LinearProgress"
        , sourceCode = Just "https://github.com/material-components/material-components-web/tree/master/packages/mdc-linear-progress"
        }
    , hero = [ LinearProgress.determinate LinearProgress.config { progress = 0.5 } ]
    , content =
        [ Html.h3 [ Typography.subtitle1 ] [ text "Buffered" ]
        , LinearProgress.buffered LinearProgress.config { progress = 0.5, buffered = 0.75 }
        , Html.h3 [ Typography.subtitle1 ] [ text "Indeterminate" ]
        , LinearProgress.indeterminate LinearProgress.config
        , Html.h3 [ Typography.subtitle1 ] [ text "Reversed" ]
        , LinearProgress.determinate
            (LinearProgress.config |> LinearProgress.setReverse True)
            { progress = 0.5 }
        , Html.h3 [ Typography.subtitle1 ] [ text "Reversed Buffered" ]
        , LinearProgress.buffered (LinearProgress.config |> LinearProgress.setReverse True)
            { progress = 0.5, buffered = 0.75 }
        ]
    }
