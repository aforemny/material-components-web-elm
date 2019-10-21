module Demo.LinearProgress exposing (Model, Msg, defaultModel, update, view)

import Demo.CatalogPage exposing (CatalogPage)
import Demo.Helper.ResourceLink as ResourceLink
import Html exposing (Html, text)
import Html.Attributes
import Material.LinearProgress exposing (bufferedLinearProgress, determinateLinearProgress, indeterminateLinearProgress, linearProgressConfig)
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
    , hero = [ determinateLinearProgress linearProgressConfig { progress = 0.5 } ]
    , content =
        [ Html.h3 [ Typography.subtitle1 ] [ text "Buffered" ]
        , bufferedLinearProgress linearProgressConfig
            { progress = 0.5, buffered = 0.75 }
        , Html.h3 [ Typography.subtitle1 ] [ text "Indeterminate" ]
        , indeterminateLinearProgress linearProgressConfig
        , Html.h3 [ Typography.subtitle1 ] [ text "Reversed" ]
        , determinateLinearProgress { linearProgressConfig | reverse = True }
            { progress = 0.5 }
        , Html.h3 [ Typography.subtitle1 ] [ text "Reversed Buffered" ]
        , bufferedLinearProgress { linearProgressConfig | reverse = True }
            { progress = 0.5, buffered = 0.75 }
        ]
    }
