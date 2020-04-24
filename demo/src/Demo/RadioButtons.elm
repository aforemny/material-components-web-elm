module Demo.RadioButtons exposing (Model, Msg(..), defaultModel, update, view)

import Demo.CatalogPage exposing (CatalogPage)
import Demo.Helper.ResourceLink as ResourceLink
import Dict exposing (Dict)
import Html exposing (Html, text)
import Html.Attributes exposing (style)
import Material.FormField as FormField
import Material.Radio as Radio
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


update : Msg -> Model -> Model
update msg model =
    case msg of
        Set group index ->
            { model | radios = Dict.insert group index model.radios }


isSelected : String -> String -> Model -> Bool
isSelected group index model =
    Dict.get group model.radios
        |> Maybe.map ((==) index)
        |> Maybe.withDefault False


view : Model -> CatalogPage Msg
view model =
    { title = "Radio Button"
    , prelude = "Buttons communicate an action a user can take. They are typically placed throughout your UI, in places like dialogs, forms, cards, and toolbars."
    , resources =
        { materialDesignGuidelines = Just "https://material.io/go/design-radio-buttons"
        , documentation = Just "https://package.elm-lang.org/packages/aforemny/material-components-web-elm/latest/Material-Radio"
        , sourceCode = Just "https://github.com/material-components/material-components-web/tree/master/packages/mdc-radio"
        }
    , hero = [ heroRadioGroup model ]
    , content =
        [ Html.h3 [ Typography.subtitle1 ] [ text "Radio Buttons" ]
        , exampleRadioGroup model
        ]
    }


heroRadio : Model -> String -> String -> Html Msg
heroRadio model group index =
    Radio.radio
        (Radio.config
            |> Radio.setChecked (isSelected group index model)
            |> Radio.setOnChange (Set group index)
            |> Radio.setAttributes [ style "margin" "0 10px" ]
        )


heroRadioGroup : Model -> Html Msg
heroRadioGroup model =
    Html.div []
        [ heroRadio model "hero" "radio-buttons-hero-radio-1"
        , heroRadio model "hero" "radio-buttons-hero-radio-2"
        ]


radio : Model -> String -> String -> String -> Html Msg
radio model group index label =
    FormField.formField
        (FormField.config
            |> FormField.setLabel label
            |> FormField.setFor (Just index)
            |> FormField.setOnClick (Set group index)
            |> FormField.setAttributes [ style "margin" "0 10px" ]
        )
        [ Radio.radio
            (Radio.config
                |> Radio.setChecked (isSelected group index model)
                |> Radio.setOnChange (Set group index)
            )
        ]


exampleRadioGroup : Model -> Html Msg
exampleRadioGroup model =
    Html.div []
        [ radio model "example" "radio-buttons-example-radio-1" "Radio 1"
        , radio model "example" "radio-buttons-example-radio-2" "Radio 2"
        ]
