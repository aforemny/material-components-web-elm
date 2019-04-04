module Demo.Buttons exposing (Model, Msg(..), defaultModel, update, view)

import Demo.Helper.ResourceLink as ResourceLink
import Demo.Page as Page exposing (Page)
import Html exposing (Html, text)
import Html.Attributes
import Material.Button as Button exposing (button, buttonConfig, outlinedButton, raisedButton, unelevatedButton)
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
    page.body "Button"
        "Buttons communicate an action a user can take. They are typically placed throughout your UI, in places like dialogs, forms, cards, and toolbars."
        [ Page.hero [] heroButtons
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
            [ buttonsRow "Text Button" button buttonConfig
            , buttonsRow "Raised Button" raisedButton buttonConfig
            , buttonsRow "Unelevated Button" unelevatedButton buttonConfig
            , buttonsRow "Outlined Button" outlinedButton buttonConfig
            , buttonsRow "Shaped Button"
                unelevatedButton
                { buttonConfig
                    | additionalAttributes =
                        [ Html.Attributes.style "border-radius" "18px" ]
                }
            ]
        ]


heroMargin : List (Html.Attribute m)
heroMargin =
    [ Html.Attributes.style "margin" "16px 32px" ]


heroButtons : List (Html m)
heroButtons =
    [ button { buttonConfig | additionalAttributes = heroMargin } "Text"
    , raisedButton { buttonConfig | additionalAttributes = heroMargin } "Raised"
    , unelevatedButton { buttonConfig | additionalAttributes = heroMargin } "Unelevated"
    , outlinedButton { buttonConfig | additionalAttributes = heroMargin } "Outlined"
    ]


rowMargin : List (Html.Attribute m)
rowMargin =
    [ Html.Attributes.style "margin" "8px 16px" ]


buttonsRow : String -> (Button.Config m -> String -> Html m) -> Button.Config m -> Html m
buttonsRow title button buttonConfig =
    Html.div []
        [ Html.h3 [ Typography.subtitle1 ] [ text title ]
        , Html.div []
            [ button
                { buttonConfig
                    | additionalAttributes = buttonConfig.additionalAttributes ++ rowMargin
                }
                "Default"
            , button
                { buttonConfig
                    | dense = True
                    , additionalAttributes = buttonConfig.additionalAttributes ++ rowMargin
                }
                "Dense"
            , button
                { buttonConfig
                    | icon = Just "favorite"
                    , additionalAttributes = buttonConfig.additionalAttributes ++ rowMargin
                }
                "Icon"
            ]
        ]
