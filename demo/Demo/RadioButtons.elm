module Demo.RadioButtons exposing (Model, Msg(..), defaultModel, update, view)

import Demo.Helper.Hero as Hero
import Demo.Helper.ResourceLink as ResourceLink
import Demo.Page as Page exposing (Page)
import Dict exposing (Dict)
import Html exposing (Html, text)
import Html.Attributes
import Material.FormField as FormField exposing (formField, formFieldConfig)
import Material.Radio as Radio exposing (radio, radioConfig)
import Material.Typography as Typography
import Platform.Cmd exposing (Cmd, none)


type alias Model =
    { radios : Dict String String
    }


defaultModel : Model
defaultModel =
    { radios =
        Dict.fromList
            [ ( "hero", "radio-buttons-hero-radio-1" )
            , ( "example", "radio-buttons-example-radio-1" )
            ]
    }


type Msg
    = Set String String


update : (Msg -> m) -> Msg -> Model -> ( Model, Cmd m )
update lift msg model =
    case msg of
        Set group index ->
            ( { model | radios = Dict.insert group index model.radios }, Cmd.none )


isSelected : String -> String -> Model -> Bool
isSelected group index model =
    Dict.get group model.radios
        |> Maybe.map ((==) index)
        |> Maybe.withDefault False


heroRadio : (Msg -> m) -> Model -> String -> String -> Html m
heroRadio lift model group index =
    radio
        { radioConfig
            | checked = isSelected group index model
            , onClick = Just (lift (Set group index))
            , additionalAttributes =
                [ Html.Attributes.style "margin" "0 10px" ]
        }


heroRadioGroup : (Msg -> m) -> Model -> Html m
heroRadioGroup lift model =
    Html.div []
        [ heroRadio lift model "hero" "radio-buttons-hero-radio-1"
        , heroRadio lift model "hero" "radio-buttons-hero-radio-2"
        ]


radio_ : (Msg -> m) -> Model -> String -> String -> String -> Html m
radio_ lift model group index label =
    formField
        { formFieldConfig
            | additionalAttributes =
                [ Html.Attributes.style "margin" "0 10px" ]
        }
        [ radio
            { radioConfig
                | checked = isSelected group index model
                , onClick = Just (lift (Set group index))
            }
        , Html.label [ Html.Attributes.for index ] [ text label ]
        ]


exampleRadioGroup : (Msg -> m) -> Model -> Html m
exampleRadioGroup lift model =
    Html.div []
        [ radio_ lift model "example" "radio-buttons-example-radio-1" "Radio 1"
        , radio_ lift model "example" "radio-buttons-example-radio-2" "Radio 2"
        ]


view : (Msg -> m) -> Page m -> Model -> Html m
view lift page model =
    page.body "Radio Button"
        "Buttons communicate an action a user can take. They are typically placed throughout your UI, in places like dialogs, forms, cards, and toolbars."
        [ Hero.view [] [ heroRadioGroup lift model ]
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
            [ Html.h3 [ Typography.subtitle1 ] [ text "Radio Buttons" ]
            , exampleRadioGroup lift model
            ]
        ]
