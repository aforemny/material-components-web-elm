module Demo.Switch exposing (Model, Msg(..), defaultModel, update, view)

import Demo.Helper.Hero as Hero
import Demo.Helper.ResourceLink as ResourceLink
import Demo.Page as Page exposing (Page)
import Dict exposing (Dict)
import Html exposing (Html, text)
import Html.Attributes
import Html.Events
import Material.FormField as FormField exposing (formField, formFieldConfig)
import Material.Switch as Switch exposing (switch, switchConfig)
import Material.Typography as Typography
import Platform.Cmd exposing (Cmd, none)


type alias Model =
    { switches : Dict String Bool
    }


defaultModel : Model
defaultModel =
    { switches = Dict.fromList [ ( "switch-hero-switch", True ) ]
    }


type Msg
    = Toggle String


update : (Msg -> m) -> Msg -> Model -> ( Model, Cmd m )
update lift msg model =
    case msg of
        Toggle index ->
            let
                switches =
                    Dict.update index
                        (\state ->
                            Just <|
                                case state of
                                    Just True ->
                                        False

                                    _ ->
                                        True
                        )
                        model.switches
            in
            ( { model | switches = switches }, Cmd.none )


isOn : String -> Model -> Bool
isOn index model =
    Dict.get index model.switches
        |> Maybe.withDefault False


heroSwitch : (Msg -> m) -> Model -> Html m
heroSwitch lift model =
    let
        index =
            "switch-hero-switch"
    in
    formField formFieldConfig
        [ switch
            { switchConfig
                | checked = isOn index model
                , onClick = Just (lift (Toggle index))
            }
        , Html.label [ Html.Attributes.for index ] [ text "off/on" ]
        ]


exampleSwitch : (Msg -> m) -> Model -> Html m
exampleSwitch lift model =
    let
        index =
            "switch-example-switch"
    in
    formField formFieldConfig
        [ switch
            { switchConfig
                | checked = isOn index model
                , onClick = Just (lift (Toggle index))
            }
        , Html.label [ Html.Attributes.for index ] [ text "off/on" ]
        ]


view : (Msg -> m) -> Page m -> Model -> Html m
view lift page model =
    page.body "Switch"
        "Switches communicate an action a user can take. They are typically placed throughout your UI, in places like dialogs, forms, cards, and toolbars."
        [ Hero.view [] [ heroSwitch lift model ]
        , Html.h2
            [ Typography.headline6
            , Html.Attributes.style "border-bottom" "1px solid rgba(0,0,0,.87)"
            ]
            [ text "Resources"
            ]
        , ResourceLink.view
            { link = "https://material.io/go/design-switches"
            , title = "Material Design Guidelines"
            , icon = "images/material.svg"
            , altText = "Material Design Guidelines icon"
            }
        , ResourceLink.view
            { link = "https://material.io/components/web/catalog/input-controls/switches/"
            , title = "Documentation"
            , icon = "images/ic_drive_document_24px.svg"
            , altText = "Documentation icon"
            }
        , ResourceLink.view
            { link = "https://github.com/material-components/material-components-web/tree/master/packages/mdc-switch"
            , title = "Source Code (Material Components Web)"
            , icon = "images/ic_code_24px.svg"
            , altText = "Source Code"
            }
        , Page.demos
            [ Html.h3 [ Typography.subtitle1 ] [ text "Switch" ]
            , exampleSwitch lift model
            ]
        ]
