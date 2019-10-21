module Demo.Drawer exposing
    ( Model
    , Msg(..)
    , defaultModel
    , update
    , view
    )

import Demo.CatalogPage exposing (CatalogPage)
import Demo.Helper.ResourceLink as ResourceLink
import Html exposing (Html, text)
import Html.Attributes
import Material.Drawer as Drawer exposing (drawerContent, drawerHeader, drawerSubtitle, drawerTitle, permanentDrawer, permanentDrawerConfig)
import Material.Icon exposing (icon, iconConfig)
import Material.List exposing (list, listConfig, listItem, listItemConfig, listItemGraphic)
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
    { title = "Drawer"
    , prelude = "The navigation drawer slides in from the left and contains the navigation destinations for your app."
    , resources =
        { materialDesignGuidelines = Just "https://material.io/go/design-navigation-drawer"
        , documentation = Just "https://package.elm-lang.org/packages/aforemny/material-components-web-elm/latest/Material-Drawer"
        , sourceCode = Just "https://github.com/material-components/material-components-web/tree/master/packages/mdc-drawer"
        }
    , hero = heroDrawer
    , content =
        [ iframe "Permanent" "#permanent-drawer"
        , iframe "Dismissible" "#dismissible-drawer"
        , iframe "Modal" "#modal-drawer"
        ]
    }


heroDrawer : List (Html msg)
heroDrawer =
    [ permanentDrawer permanentDrawerConfig
        [ drawerHeader []
            [ Html.h3 [ drawerTitle ] [ text "Title" ]
            , Html.h6 [ drawerSubtitle ] [ text "Subtitle" ]
            ]
        , drawerContent []
            [ list listConfig
                [ listItem
                    { listItemConfig
                        | activated = True
                        , additionalAttributes = [ Html.Attributes.href "#drawer" ]
                    }
                    [ listItemGraphic [] [ icon iconConfig "inbox" ]
                    , text "Inbox"
                    ]
                , listItem
                    { listItemConfig
                        | additionalAttributes = [ Html.Attributes.href "#drawer" ]
                    }
                    [ listItemGraphic [] [ icon iconConfig "star" ]
                    , text "Star"
                    ]
                , listItem
                    { listItemConfig
                        | additionalAttributes = [ Html.Attributes.href "#drawer" ]
                    }
                    [ listItemGraphic [] [ icon iconConfig "send" ]
                    , text "Sent Mail"
                    ]
                , listItem
                    { listItemConfig
                        | additionalAttributes = [ Html.Attributes.href "#drawer" ]
                    }
                    [ listItemGraphic [] [ icon iconConfig "drafts" ]
                    , text "Drafts"
                    ]
                ]
            ]
        ]
    ]


iframe : String -> String -> Html msg
iframe label url =
    Html.div
        [ Html.Attributes.style "display" "inline-block"
        , Html.Attributes.style "-ms-flex" "1 1 80%"
        , Html.Attributes.style "flex" "1 1 80%"
        , Html.Attributes.style "-ms-flex-pack" "distribute"
        , Html.Attributes.style "justify-content" "space-around"
        , Html.Attributes.style "min-height" "400px"
        , Html.Attributes.style "min-width" "400px"
        , Html.Attributes.style "padding" "15px"
        ]
        [ Html.div
            []
            [ Html.a
                [ Html.Attributes.href url
                , Html.Attributes.target "_blank"
                ]
                [ Html.h3
                    [ Typography.subtitle1
                    ]
                    [ text label
                    ]
                ]
            ]
        , Html.iframe
            [ Html.Attributes.src url
            , Html.Attributes.style "height" "400px"
            , Html.Attributes.style "width" "100vw"
            , Html.Attributes.style "max-width" "780px"
            ]
            []
        ]
