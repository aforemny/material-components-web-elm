module Demo.Fabs exposing (Model, Msg(..), defaultModel, update, view)

import Demo.CatalogPage exposing (CatalogPage)
import Demo.Helper.ResourceLink as ResourceLink
import Html exposing (Html, text)
import Html.Attributes
import Html.Events
import Material.Fab exposing (extendedFab, extendedFabConfig, fab, fabConfig)
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
    { title = "Floating Action Button"
    , prelude = "Floating action buttons represents the primary action in an application. Only one floating action button is recommended per screen to represent the most common action."
    , resources =
        { materialDesignGuidelines = Just "https://material.io/go/design-fab"
        , documentation = Just "https://package.elm-lang.org/packages/aforemny/material-components-web-elm/latest/Material-Fab"
        , sourceCode = Just "https://github.com/material-components/material-components-web/blob/master/packages/mdc-fab/"
        }
    , hero = [ fab fabConfig "favorite_border" ]
    , content =
        [ Html.h3 [ Typography.subtitle1 ] [ text "Standard Floating Action Button" ]
        , fab fabConfig "favorite_border"
        , Html.h3 [ Typography.subtitle1 ] [ text "Mini Floating Action Button" ]
        , fab { fabConfig | mini = True } "favorite_border"
        , Html.h3 [ Typography.subtitle1 ] [ text "Extended FAB" ]
        , extendedFab { extendedFabConfig | icon = Just "add" } "Create"
        , Html.h3 [ Typography.subtitle1 ]
            [ text "Extended FAB (Text label followed by icon)" ]
        , extendedFab { extendedFabConfig | icon = Just "add", trailingIcon = True }
            "Create"
        , Html.h3 [ Typography.subtitle1 ] [ text "Extended FAB (without icon)" ]
        , extendedFab extendedFabConfig "Create"
        , Html.h3 [ Typography.subtitle1 ] [ text "FAB (Shaped)" ]
        , Html.div [ Html.Attributes.style "display" "flex" ]
            [ fab
                { fabConfig
                    | additionalAttributes =
                        [ Html.Attributes.style "border-radius" "50% 0"
                        , Html.Attributes.style "margin-right" "24px"
                        ]
                }
                "favorite_border"
            , fab
                { fabConfig
                    | mini = True
                    , additionalAttributes =
                        [ Html.Attributes.style "border-radius" "8px"
                        , Html.Attributes.style "margin-right" "24px"
                        ]
                }
                "favorite_border"
            , extendedFab { extendedFabConfig | icon = Just "add" } "Create"
            ]
        ]
    }
