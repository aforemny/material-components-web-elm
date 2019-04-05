module Demo.Elevation exposing (Model, Msg(..), defaultModel, update, view)

import Demo.CatalogPage exposing (CatalogPage)
import Demo.Helper.ResourceLink as ResourceLink
import Html exposing (Html, text)
import Html.Attributes
import Material.Elevation as Elevation
import Material.Typography as Typography


type alias Model =
    {}


defaultModel : Model
defaultModel =
    {}


type Msg
    = NoOp


update : (Msg -> msg) -> Msg -> Model -> ( Model, Cmd msg )
update lift msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )


view : Model -> CatalogPage Msg
view model =
    { title = "Elevation"
    , prelude = "Elevation is the relative depth, or distance, between two surfaces along the z-axis."
    , resources =
        { materialDesignGuidelines = Just "https://material.io/go/design-elevation"
        , documentation = Just "https://material.io/components/web/catalog/elevation/"
        , sourceCode = Just "https://github.com/material-components/material-components-web/tree/master/packages/mdc-elevation"
        }
    , hero = heroElevation
    , content =
        [ Html.div demoContainer
            (List.map
                (\z ->
                    Html.div (Elevation.z z :: demoSurface)
                        [ text (String.fromInt z ++ "dp") ]
                )
                (List.range 0 24)
            )
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
    [ Html.Attributes.style "display" "-ms-inline-flexbox"
    , Html.Attributes.style "display" "inline-flex"
    , Html.Attributes.style "-ms-flex-pack" "distribute"
    , Html.Attributes.style "justify-content" "space-around"
    , Html.Attributes.style "min-height" "100px"
    , Html.Attributes.style "min-width" "200px"
    , Html.Attributes.style "-ms-flex-align" "center"
    , Html.Attributes.style "align-items" "center"
    , Html.Attributes.style "width" "120px"
    , Html.Attributes.style "height" "48px"
    , Html.Attributes.style "margin" "24px"
    , Html.Attributes.style "background-color" "#212121"
    , Html.Attributes.style "color" "#f0f0f0"
    ]


demoContainer : List (Html.Attribute msg)
demoContainer =
    [ Html.Attributes.class "elevation-demo-container"
    , Html.Attributes.style "display" "flex"
    , Html.Attributes.style "flex-flow" "row wrap"
    , Html.Attributes.style "justify-content" "space-between"
    ]


demoSurface : List (Html.Attribute msg)
demoSurface =
    [ Html.Attributes.style "display" "-ms-inline-flexbox"
    , Html.Attributes.style "display" "inline-flex"
    , Html.Attributes.style "-ms-flex-pack" "distribute"
    , Html.Attributes.style "justify-content" "space-around"
    , Html.Attributes.style "min-height" "100px"
    , Html.Attributes.style "min-width" "200px"
    , Html.Attributes.style "margin" "15px"
    , Html.Attributes.style "-ms-flex-align" "center"
    , Html.Attributes.style "align-items" "center"
    ]
