module Demo.TopAppBar exposing (Model, Msg(..), defaultModel, update, view)

import Demo.CatalogPage exposing (CatalogPage)
import Demo.Url as Url exposing (Url)
import Html exposing (Html, text)
import Html.Attributes exposing (style)
import Material.IconButton as IconButton
import Material.TopAppBar as TopAppBar
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
    { title = "Top App Bar"
    , prelude = "Top App Bars are a container for items such as application title, navigation icon, and action items."
    , resources =
        { materialDesignGuidelines = Just "https://material.io/go/design-app-bar-top"
        , documentation = Just "https://package.elm-lang.org/packages/aforemny/material-components-web-elm/latest/Material-TopAppBar"
        , sourceCode = Just "https://github.com/material-components/material-components-web/tree/master/packages/mdc-top-app-bar"
        }
    , hero =
        [ Html.div
            [ style "width" "480px"
            , style "height" "72px"
            ]
            [ TopAppBar.regular
                (TopAppBar.config |> TopAppBar.setAttributes [ style "position" "static" ])
                [ TopAppBar.section
                    [ TopAppBar.alignStart ]
                    [ IconButton.iconButton
                        (IconButton.config
                            |> IconButton.setAttributes [ TopAppBar.navigationIcon ]
                        )
                        "menu"
                    , Html.span [ TopAppBar.title ] [ text "Title" ]
                    ]
                , TopAppBar.section
                    [ TopAppBar.alignEnd ]
                    [ IconButton.iconButton
                        (IconButton.config
                            |> IconButton.setAttributes [ TopAppBar.actionItem ]
                        )
                        "file_download"
                    , IconButton.iconButton
                        (IconButton.config
                            |> IconButton.setAttributes [ TopAppBar.actionItem ]
                        )
                        "print"
                    , IconButton.iconButton
                        (IconButton.config
                            |> IconButton.setAttributes [ TopAppBar.actionItem ]
                        )
                        "more_vert"
                    ]
                ]
            ]
        ]
    , content =
        [ Html.div
            [ style "display" "-ms-flexbox"
            , style "display" "flex"
            , style "-ms-flex-wrap" "wrap"
            , style "flex-wrap" "wrap"
            , style "min-height" "200px"
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
        [ style "display" "inline-block"
        , style "-ms-flex" "1 1 45%"
        , style "flex" "1 1 45%"
        , style "-ms-flex-pack" "distribute"
        , style "justify-content" "space-around"
        , style "min-height" "200px"
        , style "min-width" "400px"
        , style "padding" "15px"
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
            [ style "width" "100%"
            , style "height" "200px"
            , Html.Attributes.src stringUrl
            ]
            []
        ]
