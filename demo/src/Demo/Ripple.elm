module Demo.Ripple exposing (Model, Msg(..), defaultModel, update, view)

import Demo.CatalogPage exposing (CatalogPage)
import Html exposing (text)
import Html.Attributes exposing (class, style)
import Material.Elevation as Elevation
import Material.Ripple as Ripple
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
    { title = "Ripple"
    , prelude = "Ripples are visual representations used to communicate the status of a component or interactive element."
    , resources =
        { materialDesignGuidelines = Just "https://material.io/go/design-states"
        , documentation = Just "https://package.elm-lang.org/packages/aforemny/material-components-web-elm/latest/Material-Ripple"
        , sourceCode = Just "https://github.com/material-components/material-components-web/tree/master/packages/mdc-ripple"
        }
    , hero = [ Html.div demoBox [ text "Click here!", Ripple.bounded Ripple.config ] ]
    , content =
        [ Html.h3 [ Typography.subtitle1 ] [ text "Bounded Ripple" ]
        , Html.div demoBox
            [ text "Interact with me!"
            , Ripple.bounded Ripple.config
            ]
        , Html.h3 [ Typography.subtitle1 ] [ text "Unbounded Ripple" ]
        , Html.div demoIcon
            [ text "favorite"
            , Ripple.unbounded Ripple.config
            ]
        , Html.h3 [ Typography.subtitle1 ] [ text "Theme Color: Primary" ]
        , Html.div demoBox
            [ text "Primary"
            , Ripple.bounded (Ripple.config |> Ripple.setColor (Just Ripple.primary))
            ]
        , Html.h3 [ Typography.subtitle1 ] [ text "Theme Color: Secondary" ]
        , Html.div demoBox
            [ text "Secondary"
            , Ripple.bounded (Ripple.config |> Ripple.setColor (Just Ripple.accent))
            ]
        ]
    }


demoBox : List (Html.Attribute msg)
demoBox =
    [ style "display" "flex"
    , style "align-items" "center"
    , style "justify-content" "center"
    , style "width" "200px"
    , style "height" "100px"
    , style "padding" "1rem"
    , style "cursor" "pointer"
    , style "user-select" "none"
    , style "background-color" "#fff"
    , style "overflow" "hidden"
    , style "position" "relative"
    , Elevation.z2
    , Html.Attributes.tabindex 0
    ]


demoIcon : List (Html.Attribute msg)
demoIcon =
    [ class "material-icons"
    , style "width" "24px"
    , style "height" "24px"
    , style "padding" "12px"
    , style "border-radius" "50%"
    , style "position" "relative"
    ]
