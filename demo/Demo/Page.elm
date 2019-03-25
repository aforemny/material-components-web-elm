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
import Material.Icon as Icon exposing (icon, iconConfig)
import Material.TopAppBar as TopAppBar exposing (topAppBar, topAppBarConfig)
import Material.Typography as Typography


type alias Page m =
    { toolbar : String -> Html m
    , navigate : Url -> m
    , body : String -> String -> List (Html m) -> Html m
    }


toolbar :
    String
    -> (Url -> m)
    -> Url
    -> String
    -> Html m
toolbar idx navigate url title =
    topAppBar
        { topAppBarConfig
            | additionalAttributes =
                [ Html.Attributes.class "catalog-top-app-bar" ]
        }
        [ TopAppBar.section
            [ TopAppBar.alignStart
            ]
            [ Html.div
                [ Html.Attributes.class "catalog-back"
                , Html.Attributes.style "padding-right" "24px"
                ]
                [ case url of
                    Url.StartPage ->
                        Html.img
                            [ Html.Attributes.class "mdc-toolbar__menu-icon"
                            , Html.Attributes.src "images/ic_component_24px_white.svg"
                            ]
                            []

                    _ ->
                        icon
                            { iconConfig
                                | additionalAttributes =
                                    [ Html.Events.onClick (navigate Url.StartPage) ]
                            }
                            "arrow_back"
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
        (List.reverse
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
                :: Html.Attributes.style "height" "360px"
                :: Html.Attributes.style "min-height" "360px"
                :: Html.Attributes.style "background-color" "rgba(0, 0, 0, 0.05)"
                :: Html.Attributes.style "padding" "24px"
                :: options
            )
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
