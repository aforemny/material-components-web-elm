module Demo.Elevation exposing (Model, Msg(..), defaultModel, update, view)

import Demo.CatalogPage exposing (CatalogPage)
import Html exposing (Html, text)
import Html.Attributes exposing (class, style)
import Material.Elevation as Elevation


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
    { title = "Elevation"
    , prelude = "Elevation is the relative depth, or distance, between two surfaces along the z-axis."
    , resources =
        { materialDesignGuidelines = Just "https://material.io/go/design-elevation"
        , documentation = Just "https://package.elm-lang.org/packages/aforemny/material-components-web-elm/latest/Material-Elevation"
        , sourceCode = Just "https://github.com/material-components/material-components-web/tree/master/packages/mdc-elevation"
        }
    , hero = heroElevation
    , content =
        [ Html.div demoContainer
            [ Html.div (Elevation.z0 :: demoSurface) [ text "0dp" ]
            , Html.div (Elevation.z1 :: demoSurface) [ text "1dp" ]
            , Html.div (Elevation.z2 :: demoSurface) [ text "2dp" ]
            , Html.div (Elevation.z3 :: demoSurface) [ text "3dp" ]
            , Html.div (Elevation.z4 :: demoSurface) [ text "4dp" ]
            , Html.div (Elevation.z5 :: demoSurface) [ text "5dp" ]
            , Html.div (Elevation.z6 :: demoSurface) [ text "6dp" ]
            , Html.div (Elevation.z7 :: demoSurface) [ text "7dp" ]
            , Html.div (Elevation.z8 :: demoSurface) [ text "8dp" ]
            , Html.div (Elevation.z9 :: demoSurface) [ text "9dp" ]
            , Html.div (Elevation.z10 :: demoSurface) [ text "10dp" ]
            , Html.div (Elevation.z11 :: demoSurface) [ text "11dp" ]
            , Html.div (Elevation.z12 :: demoSurface) [ text "12dp" ]
            , Html.div (Elevation.z13 :: demoSurface) [ text "13dp" ]
            , Html.div (Elevation.z14 :: demoSurface) [ text "14dp" ]
            , Html.div (Elevation.z15 :: demoSurface) [ text "15dp" ]
            , Html.div (Elevation.z16 :: demoSurface) [ text "16dp" ]
            , Html.div (Elevation.z17 :: demoSurface) [ text "17dp" ]
            , Html.div (Elevation.z18 :: demoSurface) [ text "18dp" ]
            , Html.div (Elevation.z19 :: demoSurface) [ text "19dp" ]
            , Html.div (Elevation.z20 :: demoSurface) [ text "20dp" ]
            , Html.div (Elevation.z21 :: demoSurface) [ text "21dp" ]
            , Html.div (Elevation.z22 :: demoSurface) [ text "22dp" ]
            , Html.div (Elevation.z23 :: demoSurface) [ text "23dp" ]
            , Html.div (Elevation.z24 :: demoSurface) [ text "24dp" ]
            ]
        ]
    }


heroElevation : List (Html msg)
heroElevation =
    [ Html.div (Elevation.z0 :: heroSurface) [ text "Flat 0dp" ]
    , Html.div (Elevation.z8 :: heroSurface) [ text "Raised 8dp" ]
    , Html.div (Elevation.z16 :: heroSurface) [ text "Raised 16dp" ]
    ]


heroSurface : List (Html.Attribute msg)
heroSurface =
    [ style "display" "-ms-inline-flexbox"
    , style "display" "inline-flex"
    , style "-ms-flex-pack" "distribute"
    , style "justify-content" "space-around"
    , style "min-height" "100px"
    , style "min-width" "200px"
    , style "-ms-flex-align" "center"
    , style "align-items" "center"
    , style "width" "120px"
    , style "height" "48px"
    , style "margin" "24px"
    , style "background-color" "#212121"
    , style "color" "#f0f0f0"
    ]


demoContainer : List (Html.Attribute msg)
demoContainer =
    [ class "elevation-demo-container"
    , style "display" "flex"
    , style "flex-flow" "row wrap"
    , style "justify-content" "space-between"
    ]


demoSurface : List (Html.Attribute msg)
demoSurface =
    [ style "display" "-ms-inline-flexbox"
    , style "display" "inline-flex"
    , style "-ms-flex-pack" "distribute"
    , style "justify-content" "space-around"
    , style "min-height" "100px"
    , style "min-width" "200px"
    , style "margin" "15px"
    , style "-ms-flex-align" "center"
    , style "align-items" "center"
    ]
