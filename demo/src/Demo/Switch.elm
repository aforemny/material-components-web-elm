module Demo.Switch exposing (Model, Msg(..), defaultModel, update, view)

import Demo.CatalogPage exposing (CatalogPage)
import Demo.Helper.ResourceLink as ResourceLink
import Dict exposing (Dict)
import Html exposing (Html, text)
import Html.Attributes
import Html.Events
import Material.FormField exposing (formField, formFieldConfig)
import Material.Switch exposing (switch, switchConfig)
import Material.Typography as Typography
import Platform.Cmd exposing (Cmd, none)


type alias Model =
    { switches : Dict String Bool
    }


defaultModel : Model
defaultModel =
    { switches = Dict.fromList [ ( "hero-switch", True ) ]
    }


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
    [ formField
        { formFieldConfig
            | label = "off/on"
            , for = Just id
            , onClick = Just (Toggle id)
        }
        [ switch
            { switchConfig
                | checked = isChecked id model
                , onChange = Just (Toggle id)
            }
        ]
    ]


demoSwitch : Model -> Html Msg
demoSwitch model =
    let
        id =
            "demo-switch"
    in
    formField
        { formFieldConfig
            | label = "off/on"
            , for = Just id
            , onClick = Just (Toggle id)
        }
        [ switch
            { switchConfig
                | checked = isChecked id model
                , onChange = Just (Toggle id)
            }
        ]
