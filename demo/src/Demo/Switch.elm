module Demo.Switch exposing (Model, Msg(..), defaultModel, update, view)

import Demo.CatalogPage exposing (CatalogPage)
import Dict exposing (Dict)
import Html exposing (Html, text)
import Material.FormField as FormField
import Material.Switch as Switch
import Material.Typography as Typography


type alias Model =
    { switches : Dict String Bool }


defaultModel : Model
defaultModel =
    { switches = Dict.fromList [ ( "hero-switch", True ) ] }


type Msg
    = Toggle String


update : Msg -> Model -> Model
update msg model =
    case msg of
        Toggle id ->
            { model
                | switches =
                    Dict.update id
                        (\state -> Just (not (Maybe.withDefault False state)))
                        model.switches
            }


isChecked : String -> Model -> Bool
isChecked id model =
    Maybe.withDefault False (Dict.get id model.switches)


view : Model -> CatalogPage Msg
view model =
    { title = "Switch"
    , prelude = "Switches communicate an action a user can take. They are typically placed throughout your UI, in places like dialogs, forms, cards, and toolbars."
    , resources =
        { materialDesignGuidelines = Just "https://material.io/go/design-switches"
        , documentation = Just "https://package.elm-lang.org/packages/aforemny/material-components-web-elm/latest/Material-Switch"
        , sourceCode = Just "https://github.com/material-components/material-components-web/tree/master/packages/mdc-switch"
        }
    , hero = heroSwitch model
    , content =
        [ Html.h3 [ Typography.subtitle1 ] [ text "Switch" ]
        , demoSwitch model
        ]
    }


heroSwitch : Model -> List (Html Msg)
heroSwitch model =
    let
        id =
            "hero-switch"
    in
    [ FormField.formField
        (FormField.config
            |> FormField.setLabel (Just "off/on")
            |> FormField.setFor (Just id)
            |> FormField.setOnClick (Toggle id)
        )
        [ Switch.switch
            (Switch.config
                |> Switch.setChecked (isChecked id model)
                |> Switch.setOnChange (Toggle id)
            )
        ]
    ]


demoSwitch : Model -> Html Msg
demoSwitch model =
    let
        id =
            "demo-switch"
    in
    FormField.formField
        (FormField.config
            |> FormField.setLabel (Just "off/on")
            |> FormField.setFor (Just id)
            |> FormField.setOnClick (Toggle id)
        )
        [ Switch.switch
            (Switch.config
                |> Switch.setChecked (isChecked id model)
                |> Switch.setOnChange (Toggle id)
            )
        ]
