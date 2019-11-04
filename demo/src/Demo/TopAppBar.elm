module Demo.TopAppBar exposing (Model, Msg(..), defaultModel, update, view)

import Demo.CatalogPage exposing (CatalogPage)
import Demo.Url as Url exposing (Url)
import Dict exposing (Dict)
import Html exposing (Html, text)
import Html.Attributes
import Html.Events
import Material.IconButton exposing (iconButton, iconButtonConfig)
import Material.TopAppBar as TopAppBar exposing (prominentTopAppBar, shortCollapsedTopAppBar, shortTopAppBar, topAppBar, topAppBarConfig)
import Material.Typography as Typography


type alias Model =
    {}


type alias Example =
    {}


defaultExample : Example
defaultExample =
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
    { title = "Top App Bar"
    , prelude = "Top App Bars are a container for items such as application title, navigation icon, and action items."
    , resources =
        { materialDesignGuidelines = Just "https://material.io/go/design-app-bar-top"
        , documentation = Just "https://package.elm-lang.org/packages/aforemny/material-components-web-elm/latest/Material-TopAppBar"
        , sourceCode = Just "https://github.com/material-components/material-components-web/tree/master/packages/mdc-top-app-bar"
        }
    , hero =
        [ Html.div
            [ Html.Attributes.style "width" "480px"
            , Html.Attributes.style "height" "72px"
            ]
            [ topAppBar
                { topAppBarConfig
                    | additionalAttributes =
                        [ Html.Attributes.style "position" "static" ]
                }
                [ TopAppBar.section
                    [ TopAppBar.alignStart
                    ]
                    [ iconButton
                        { iconButtonConfig
                            | additionalAttributes =
                                [ TopAppBar.navigationIcon ]
                        }
                        "menu"
                    , Html.span [ TopAppBar.title ] [ text "Title" ]
                    ]
                , TopAppBar.section
                    [ TopAppBar.alignEnd
                    ]
                    [ iconButton
                        { iconButtonConfig
                            | additionalAttributes = [ TopAppBar.actionItem ]
                        }
                        "file_download"
                    , iconButton
                        { iconButtonConfig
                            | additionalAttributes = [ TopAppBar.actionItem ]
                        }
                        "print"
                    , iconButton
                        { iconButtonConfig
                            | additionalAttributes = [ TopAppBar.actionItem ]
                        }
                        "more_vert"
                    ]
                ]
            ]
        ]
    , content =
        [ Html.div
            [ Html.Attributes.style "display" "-ms-flexbox"
            , Html.Attributes.style "display" "flex"
            , Html.Attributes.style "-ms-flex-wrap" "wrap"
            , Html.Attributes.style "flex-wrap" "wrap"
            , Html.Attributes.style "min-height" "200px"
            ]
            [ iframe "Standard" Url.StandardTopAppBar
            , iframe "Fixed" Url.FixedTopAppBar
            , iframe "Dense" Url.DenseTopAppBar
            , iframe "Prominent" Url.ProminentTopAppBar
            , iframe "Short" Url.ShortTopAppBar
            , iframe "Short - Always Collapsed" Url.ShortCollapsedTopAppBar
            ]
        ]
    }


iframe : String -> Url -> Html msg
iframe title url =
    let
        stringUrl =
            Url.toString url
    in
    Html.div
        [ Html.Attributes.style "display" "inline-block"
        , Html.Attributes.style "-ms-flex" "1 1 45%"
        , Html.Attributes.style "flex" "1 1 45%"
        , Html.Attributes.style "-ms-flex-pack" "distribute"
        , Html.Attributes.style "justify-content" "space-around"
        , Html.Attributes.style "min-height" "200px"
        , Html.Attributes.style "min-width" "400px"
        , Html.Attributes.style "padding" "15px"
        ]
        [ Html.div []
            [ Html.a
                [ Html.Attributes.href stringUrl
                , Html.Attributes.target "_blank"
                ]
                [ Html.h3 [ Typography.subtitle1 ] [ text title ]
                ]
            ]
        , Html.iframe
            [ Html.Attributes.style "width" "100%"
            , Html.Attributes.style "height" "200px"
            , Html.Attributes.src stringUrl
            ]
            []
        ]
