module Demo.Typography exposing (view)

import Demo.Helper.Hero as Hero
import Demo.Helper.ResourceLink as ResourceLink
import Demo.Page exposing (Page)
import Html exposing (Html, text)
import Html.Attributes
import Material.Typography as Typography


view : Page m -> Html m
view page =
    page.body "Typography"
        "Roboto is the standard typeface on Android and Chrome."
        [ Html.div
            [ Html.Attributes.class "demo-wrapper"
            ]
            [ Html.h1 [ Typography.headline5 ] [ text "Typography" ]
            , Html.p
                [ Typography.body1
                ]
                [ text """
Roboto is the standard typeface on Android and Chrome.
                       """
                ]
            , Hero.view []
                [ Html.h1 [ Typography.headline1 ] [ text "Typography" ]
                ]
            , Html.h2
                [ Typography.headline6
                , Html.Attributes.style "border-bottom" "1px solid rgba(0,0,0,.87)"
                ]
                [ text "Resources"
                ]
            , ResourceLink.view
                { link = "https://material.io/go/design-typography"
                , title = "Material Design Guidelines"
                , icon = "images/material.svg"
                , altText = "Material Design Guidelines icon"
                }
            , ResourceLink.view
                { link = "https://material.io/components/web/catalog/typography/"
                , title = "Documentation"
                , icon = "images/ic_drive_document_24px.svg"
                , altText = "Documentation icon"
                }
            , ResourceLink.view
                { link = "https://github.com/material-components/material-components-web/tree/master/packages/mdc-typography"
                , title = "Source Code (Material Components Web)"
                , icon = "images/ic_code_24px.svg"
                , altText = "Source Code"
                }
            , Html.h2
                [ Typography.headline6
                , Html.Attributes.style "border-bottom" "1px solid rgba(0,0,0,.87)"
                ]
                [ text "Demos"
                ]
            , example
            ]
        ]


example : Html m
example =
    Html.section
        [ Html.Attributes.class "demo-typography--section"
        , Typography.typography
        ]
        [ Html.h1 [ Typography.headline1 ] [ text "Headline 1" ]
        , Html.h2 [ Typography.headline2 ] [ text "Headline 2" ]
        , Html.h3 [ Typography.headline3 ] [ text "Headline 3" ]
        , Html.h4 [ Typography.headline4 ] [ text "Headline 4" ]
        , Html.h5 [ Typography.headline5 ] [ text "Headline 5" ]
        , Html.h6 [ Typography.headline6 ] [ text "Headline 6" ]
        , Html.h6 [ Typography.subtitle1 ] [ text "Subtitle 1" ]
        , Html.h6 [ Typography.subtitle2 ] [ text "Subtitle 2" ]
        , Html.p
            [ Typography.body1
            ]
            [ text "Body 1. Lorem ipsum dolor sit amet, consectetur adipisicing elit. Quos blanditiis tenetur unde suscipit, quam beatae rerum inventore consectetur, neque doloribus, cupiditate numquam dignissimos laborum fugiat deleniti? Eum quasi quidem quibusdam."
            ]
        , Html.p
            [ Typography.body2
            ]
            [ text "Body 2. Lorem ipsum dolor sit amet consectetur adipisicing elit. Cupiditate aliquid ad quas sunt voluptatum officia dolorum cumque, possimus nihil molestias sapiente necessitatibus dolor saepe inventore, soluta id accusantium voluptas beatae."
            ]
        , Html.div
            [ Typography.button
            ]
            [ text "Button text"
            ]
        , Html.div
            [ Typography.caption
            ]
            [ text "Caption text"
            ]
        , Html.div
            [ Typography.overline
            ]
            [ text "Overline text"
            ]
        ]
