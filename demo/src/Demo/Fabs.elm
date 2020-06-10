module Demo.Fabs exposing (Model, Msg(..), defaultModel, update, view)

import Demo.CatalogPage exposing (CatalogPage)
import Html exposing (text)
import Html.Attributes exposing (style)
import Material.Fab as Fab
import Material.Fab.Extended as ExtendedFab
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
    , hero = [ Fab.fab Fab.config "favorite_border" ]
    , content =
        [ Html.h3 [ Typography.subtitle1 ] [ text "Standard Floating Action Button" ]
        , Fab.fab Fab.config "favorite_border"
        , Html.h3 [ Typography.subtitle1 ] [ text "Mini Floating Action Button" ]
        , Fab.fab (Fab.config |> Fab.setMini True) "favorite_border"
        , Html.h3 [ Typography.subtitle1 ] [ text "Extended FAB" ]
        , ExtendedFab.fab (ExtendedFab.config |> ExtendedFab.setIcon (Just "add"))
            "Create"
        , Html.h3 [ Typography.subtitle1 ]
            [ text "Extended FAB (Text label followed by icon)" ]
        , ExtendedFab.fab
            (ExtendedFab.config
                |> ExtendedFab.setIcon (Just "add")
                |> ExtendedFab.setTrailingIcon True
            )
            "Create"
        , Html.h3 [ Typography.subtitle1 ] [ text "Extended FAB (without icon)" ]
        , ExtendedFab.fab ExtendedFab.config "Create"
        , Html.h3 [ Typography.subtitle1 ] [ text "FAB (Shaped)" ]
        , Html.div [ style "display" "flex" ]
            [ Fab.fab
                (Fab.config
                    |> Fab.setAttributes
                        [ style "border-radius" "50% 0"
                        , style "margin-right" "24px"
                        ]
                )
                "favorite_border"
            , Fab.fab
                (Fab.config
                    |> Fab.setMini True
                    |> Fab.setAttributes
                        [ style "border-radius" "8px"
                        , style "margin-right" "24px"
                        ]
                )
                "favorite_border"
            , ExtendedFab.fab (ExtendedFab.config |> ExtendedFab.setIcon (Just "add"))
                "Create"
            ]
        ]
    }
