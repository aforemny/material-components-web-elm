module Demo.Page exposing
    ( Page
    , demos
    , header
    , hero
    , toolbar
    )

import Demo.Url as Url exposing (Url)
import Html exposing (Html, text)
import Html.Attributes
import Html.Events
import Material.IconButton as IconButton exposing (iconButton, iconButtonConfig)
import Material.TopAppBar as TopAppBar exposing (topAppBar, topAppBarConfig)
import Material.Typography as Typography


type alias Page m =
    { toolbar : Html m
    , body : String -> String -> List (Html m) -> Html m
    }


toolbar : Url -> Html m
toolbar url =
    topAppBar
        { topAppBarConfig
            | additionalAttributes =
                [ Html.Attributes.class "catalog-top-app-bar" ]
        }
        [ TopAppBar.section
            [ TopAppBar.alignStart
            ]
            [ Html.a
                [ Html.Attributes.href (Url.toString Url.StartPage)
                ]
                [ iconButton
                    { iconButtonConfig
                        | additionalAttributes = [ TopAppBar.navigationIcon ]
                    }
                    (if url == Url.StartPage then
                        "menu"

                     else
                        "arrow_back"
                    )
                ]
            , Html.span
                [ TopAppBar.title
                , Html.Attributes.style "text-transform" "uppercase"
                , Html.Attributes.style "font-weight" "400"
                ]
                [ text "Material Components for Elm" ]
            ]
        ]


header : String -> Html m
header title =
    Html.h1
        [ Typography.headline5 ]
        [ text title ]


hero : List (Html.Attribute m) -> List (Html m) -> Html m
hero options =
    Html.section
        (Html.Attributes.class "hero"
            :: Html.Attributes.style "display" "-webkit-box"
            :: Html.Attributes.style "display" "-ms-flexbox"
            :: Html.Attributes.style "display" "flex"
            :: Html.Attributes.style "-webkit-box-orient" "horizontal"
            :: Html.Attributes.style "-webkit-box-direction" "normal"
            :: Html.Attributes.style "-ms-flex-flow" "row nowrap"
            :: Html.Attributes.style "flex-flow" "row nowrap"
            :: Html.Attributes.style "-webkit-box-align" "center"
            :: Html.Attributes.style "-ms-flex-align" "center"
            :: Html.Attributes.style "align-items" "center"
            :: Html.Attributes.style "-webkit-box-pack" "center"
            :: Html.Attributes.style "-ms-flex-pack" "center"
            :: Html.Attributes.style "justify-content" "center"
            :: Html.Attributes.style "min-height" "360px"
            :: Html.Attributes.style "background-color" "rgba(0, 0, 0, 0.05)"
            :: Html.Attributes.style "padding" "24px"
            :: options
        )


demos : List (Html m) -> Html m
demos nodes =
    Html.div
        [ Html.Attributes.style "padding-bottom" "20px" ]
        (Html.h2
            [ Typography.headline6
            , Html.Attributes.style "border-bottom" "1px solid rgba(0,0,0,.87)"
            ]
            [ text "Demos" ]
            :: nodes
        )
