module Demo.Buttons exposing (Model, Msg(..), defaultModel, update, view)

import Demo.Helper.Hero as Hero
import Demo.Helper.ResourceLink as ResourceLink
import Demo.Page as Page exposing (Page)
import Html exposing (Html, text)
import Html.Attributes
import Material.Button as Button exposing (button, buttonConfig)
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


view : (Msg -> m) -> Page m -> Model -> Html m
view lift page model =
    let
        textButtons idx =
            example idx
                lift
                { title = "Text Button"
                , mapConfig = \config -> config
                }

        raisedButtons idx =
            example idx
                lift
                { title = "Raised Button"
                , mapConfig = \config -> { config | variant = Button.Raised }
                }

        unelevatedButtons idx =
            example idx
                lift
                { title = "Unelevated Button"
                , mapConfig = \config -> { buttonConfig | variant = Button.Unelevated }
                }

        outlinedButtons idx =
            example idx
                lift
                { title = "Outlined Button"
                , mapConfig = \config -> { buttonConfig | variant = Button.Outlined }
                }

        shapedButtons idx =
            example idx
                lift
                { title = "Shaped Button"
                , mapConfig =
                    \config ->
                        { config
                            | variant = Button.Unelevated
                            , additionalAttributes =
                                config.additionalAttributes
                                    ++ [ Html.Attributes.style "border-radius" "18px"
                                       ]
                        }
                }
    in
    page.body "Button"
        "Buttons communicate an action a user can take. They are typically placed throughout your UI, in places like dialogs, forms, cards, and toolbars."
        [ Hero.view []
            [ button
                { buttonConfig
                    | additionalAttributes =
                        [ Html.Attributes.style "margin" "16px 32px"
                        ]
                }
                "Text"
            , button
                { buttonConfig
                    | variant = Button.Raised
                    , additionalAttributes =
                        [ Html.Attributes.style "margin" "16px 32px" ]
                }
                "Raised"
            , button
                { buttonConfig
                    | variant = Button.Unelevated
                    , additionalAttributes =
                        [ Html.Attributes.style "margin" "16px 32px" ]
                }
                "Unelevated"
            , button
                { buttonConfig
                    | variant = Button.Outlined
                    , additionalAttributes =
                        [ Html.Attributes.style "margin" "16px 32px" ]
                }
                "Outlined"
            ]
        , Html.h2
            [ Typography.headline6
            , Html.Attributes.style "border-bottom" "1px solid rgba(0,0,0,.87)"
            ]
            [ text "Resources"
            ]
        , ResourceLink.view
            { link = "https://material.io/go/design-buttons"
            , title = "Material Design Guidelines"
            , icon = "images/material.svg"
            , altText = "Material Design Guidelines icon"
            }
        , ResourceLink.view
            { link = "https://material.io/components/web/catalog/buttons/"
            , title = "Documentation"
            , icon = "images/ic_drive_document_24px.svg"
            , altText = "Documentation icon"
            }
        , ResourceLink.view
            { link = "https://github.com/material-components/material-components-web/tree/master/packages/mdc-button"
            , title = "Source Code (Material Components Web)"
            , icon = "images/ic_code_24px.svg"
            , altText = "Source Code"
            }
        , Page.demos
            [ textButtons "buttons-text-buttons"
            , raisedButtons "buttons-raised-buttons"
            , unelevatedButtons "buttons-unelevated-buttons"
            , outlinedButtons "buttons-outlined-buttons"
            , shapedButtons "buttons-shaped-buttons"
            ]
        ]


example :
    String
    -> (Msg -> m)
    ->
        { title : String
        , mapConfig : Button.Config m -> Button.Config m
        }
    -> Html m
example idx lift { title, mapConfig } =
    Html.div
        []
        [ Html.h3
            [ Typography.subtitle1
            ]
            [ text title
            ]
        , Html.div
            []
            [ button
                (mapConfig
                    { buttonConfig
                        | additionalAttributes =
                            [ Html.Attributes.style "margin" "8px 16px" ]
                    }
                )
                "Default"
            , button
                (mapConfig
                    { buttonConfig
                        | dense = True
                        , additionalAttributes =
                            [ Html.Attributes.style "margin" "8px 16px" ]
                    }
                )
                "Dense"
            , button
                (mapConfig
                    { buttonConfig
                        | icon = Just "favorite"
                        , additionalAttributes =
                            [ Html.Attributes.style "margin" "8px 16px" ]
                    }
                )
                "Icon"
            ]
        ]
