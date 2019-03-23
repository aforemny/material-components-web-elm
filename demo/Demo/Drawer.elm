module Demo.Drawer exposing
    ( Model
    , Msg(..)
    , defaultModel
    , subscriptions
    , update
    , view
    )

import Demo.Helper.Hero as Hero
import Demo.Helper.ResourceLink as ResourceLink
import Demo.Page as Page exposing (Page)
import Html exposing (Html, text)
import Html.Attributes
import Material.Drawer as Drawer
import Material.List as Lists
import Material.Typography as Typography


type alias Model =
    {}


defaultModel : Model
defaultModel =
    {}


type Msg
    = NoOp


update : (Msg -> m) -> Msg -> Model -> ( Model, Cmd m )
update lift msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )


example : String -> String -> Html m
example label url =
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
                [ Html.Attributes.href ("." ++ url)
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
            [ Html.Attributes.src ("./index.html" ++ url)
            , Html.Attributes.style "height" "400px"
            , Html.Attributes.style "width" "100vw"
            , Html.Attributes.style "max-width" "780px"
            ]
            []
        ]


view : (Msg -> m) -> Page m -> Model -> Html m
view lift page model =
    page.body "Drawer"
        "The navigation drawer slides in from the left and contains the navigation destinations for your app."
        [ Hero.view []
            [ Drawer.view lift
                "permanent-drawer-drawer"
                model.mdc
                []
                [ Drawer.header
                    []
                    [ Html.h3
                        [ Drawer.title ]
                        [ text "Title" ]
                    , Html.h6
                        [ Drawer.subTitle ]
                        [ text "subtext" ]
                    ]
                , Drawer.content []
                    [ Lists.nav []
                        [ Lists.a
                            [ Html.Attributes.href "#drawer"
                            , Lists.activated
                            ]
                            [ Lists.graphicIcon [] "inbox"
                            , text "Inbox"
                            ]
                        , Lists.a
                            [ Html.Attributes.href "#drawer"
                            ]
                            [ Lists.graphicIcon [] "star"
                            , text "Star"
                            ]
                        , Lists.a
                            [ Html.Attributes.href "#drawer"
                            ]
                            [ Lists.graphicIcon [] "send"
                            , text "Sent Mail"
                            ]
                        , Lists.a
                            [ Html.Attributes.href "#drawer"
                            ]
                            [ Lists.graphicIcon [] "drafts"
                            , text "Drafts"
                            ]
                        ]
                    ]
                ]
            ]
        , Html.h2
            [ Typography.headline6
            , Html.Attributes.style "border-bottom" "1px solid rgba(0,0,0,.87)"
            ]
            [ text "Resources"
            ]
        , ResourceLink.view
            { link = "https://material.io/go/design-navigation-drawer"
            , title = "Material Design Guidelines"
            , icon = "images/material.svg"
            , altText = "Material Design Guidelines icon"
            }
        , ResourceLink.view
            { link = "https://material.io/components/web/catalog/drawers/"
            , title = "Documentation"
            , icon = "images/ic_drive_document_24px.svg"
            , altText = "Documentation icon"
            }
        , ResourceLink.view
            { link = "https://github.com/material-components/material-components-web/tree/master/packages/mdc-drawer"
            , title = "Source Code (Material Components Web)"
            , icon = "images/ic_code_24px.svg"
            , altText = "Source Code"
            }
        , Page.demos
            [ example "Permanent" "#permanent-drawer"
            , example "Dismissible" "#dismissible-drawer"
            , example "Modal" "#modal-drawer"
            ]
        ]


subscriptions : (Msg -> m) -> Model -> Sub m
subscriptions lift model =
    Sub.none
