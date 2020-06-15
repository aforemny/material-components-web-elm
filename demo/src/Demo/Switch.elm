module Demo.Switch exposing (Model, Msg(..), defaultModel, update, view)

import Browser.Dom
import Demo.CatalogPage exposing (CatalogPage)
import Dict exposing (Dict)
import Html exposing (Html, text)
import Html.Attributes
import Material.Button as Button
import Material.FormField as FormField
import Material.Switch as Switch
import Material.Typography as Typography
import Task


type alias Model =
    { switches : Dict String Bool }


defaultModel : Model
defaultModel =
    { switches = Dict.fromList [ ( "hero-switch", True ) ] }


type Msg
    = Toggle String
    | Focus String
    | Focused (Result Browser.Dom.Error ())


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Toggle id ->
            ( { model
                | switches =
                    Dict.update id
                        (\state -> Just (not (Maybe.withDefault False state)))
                        model.switches
              }
            , Cmd.none
            )

        Focus id ->
            ( model, Task.attempt Focused (Browser.Dom.focus id) )

        Focused _ ->
            ( model, Cmd.none )


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
        , Html.h3 [ Typography.subtitle1 ] [ text "Focus Switch" ]
        , focusSwitch model
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


focusSwitch : Model -> Html Msg
focusSwitch model =
    let
        id =
            "my-switch"
    in
    Html.div []
        [ FormField.formField
            (FormField.config
                |> FormField.setLabel (Just "off/on")
                |> FormField.setFor (Just id)
                |> FormField.setOnClick (Toggle id)
                |> FormField.setAttributes [ Html.Attributes.id "my-form-field" ]
            )
            [ Switch.switch
                (Switch.config
                    |> Switch.setChecked (isChecked id model)
                    |> Switch.setOnChange (Toggle id)
                    |> Switch.setAttributes [ Html.Attributes.id id ]
                )
            ]
        , text "\u{00A0}"
        , Button.raised
            (Button.config |> Button.setOnClick (Focus "my-switch"))
            "Focus switch"
        , Button.raised
            (Button.config |> Button.setOnClick (Focus "my-form-field"))
            "Focus form field"
        ]
