module Demo.Buttons exposing (Model, Msg(..), defaultModel, update, view)

import Demo.Helper.Hero as Hero
import Demo.Helper.ResourceLink as ResourceLink
import Demo.Page as Page exposing (Page)
import Html exposing (Html, text)
import Html.Attributes
import Material.Button as Button
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
                , additionalOptions = []
                }

        raisedButtons idx =
            example idx
                lift
                { title = "Raised Button"
                , additionalOptions = [ Button.raised ]
                }

        unelevatedButtons idx =
            example idx
                lift
                { title = "Unelevated Button"
                , additionalOptions = [ Button.unelevated ]
                }

        outlinedButtons idx =
            example idx
                lift
                { title = "Outlined Button"
                , additionalOptions = [ Button.outlined ]
                }

        shapedButtons idx =
            example idx
                lift
                { title = "Shaped Button"
                , additionalOptions =
                    [ Button.unelevated
                    , Html.Attributes.style "border-radius" "18px"
                    ]
                }
    in
    page.body "Button"
        "Buttons communicate an action a user can take. They are typically placed throughout your UI, in places like dialogs, forms, cards, and toolbars."
        [ Hero.view []
            [ Button.view lift
                "buttons-hero-button-text"
                model.mdc
                [ Button.ripple
                , Html.Attributes.style "margin" "16px 32px"
                ]
                [ text "Text"
                ]
            , Button.view lift
                "buttons-hero-button-raised"
                model.mdc
                [ Button.ripple
                , Button.raised
                , Html.Attributes.style "margin" "16px 32px"
                ]
                [ text "Raised"
                ]
            , Button.view lift
                "buttons-hero-button-unelevated"
                model.mdc
                [ Button.ripple
                , Button.unelevated
                , Html.Attributes.style "margin" "16px 32px"
                ]
                [ text "Unelevated"
                ]
            , Button.view lift
                "buttons-hero-button-outlined"
                model.mdc
                [ Button.ripple
                , Button.outlined
                , Html.Attributes.style "margin" "16px 32px"
                ]
                [ text "Outlined"
                ]
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
        , additionalOptions : List (Html.Attribute m)
        }
    -> Html m
example idx lift { title, additionalOptions } =
    Html.div
        []
        [ Html.h3
            [ Typography.subtitle1
            ]
            [ text title
            ]
        , Html.div
            []
            [ Button.view lift
                (idx ++ "-default-button")
                (Html.Attributes.style "margin" "8px 16px"
                    :: Button.ripple
                    :: additionalOptions
                )
                [ text "Default" ]
            , Button.view lift
                (idx ++ "-dense-button")
                (Html.Attributes.style "margin" "8px 16px"
                    :: Button.ripple
                    :: Button.dense
                    :: additionalOptions
                )
                [ text "Dense" ]
            , Button.view lift
                (idx ++ "-icon-button")
                (Html.Attributes.style "margin" "8px 16px"
                    :: Button.ripple
                    :: Button.icon "favorite"
                    :: additionalOptions
                )
                [ text "Icon" ]
            ]
        ]
