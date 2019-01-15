module Demo.Checkbox exposing (Msg(..), defaultModel, update, view)

import Dict
import Html exposing (Html, text)
import Material.Checkbox as Checkbox exposing (checkbox, checkboxConfig)
import Material.Typography as Typography


defaultModel =
    { states =
        Dict.fromList
            [ ( "checked-hero-checkbox", Checkbox.Checked )
            , ( "unchecked-hero-checkbox", Checkbox.Unchecked )
            , ( "unchecked-checkbox", Checkbox.Unchecked )
            , ( "indeterminate-checkbox", Checkbox.Indeterminate )
            , ( "checked-checkbox", Checkbox.Checked )
            ]
    }


type Msg
    = Toggle String


update msg model =
    case msg of
        Toggle id ->
            let
                toggle state =
                    case state of
                        Checkbox.Checked ->
                            Checkbox.Unchecked

                        Checkbox.Unchecked ->
                            Checkbox.Checked

                        Checkbox.Indeterminate ->
                            Checkbox.Checked
            in
            ( { model
                | states = Dict.update id (Maybe.map Checkbox.toggle) model.states
              }
            , Cmd.none
            )


view model =
    let
        myCheckbox id =
            checkbox
                { checkboxConfig
                    | state =
                        model.states
                            |> Dict.get id
                            |> Maybe.withDefault Checkbox.Indeterminate
                    , onClick = Just (Toggle id)
                }
    in
    Html.div []
        [ Html.h1 [ Typography.headline5 ] [ text "Checkbox" ]
        , Html.p [ Typography.body1 ]
            [ text
                """
                Checkboxes allow the user to select multiple options from a set.
                """
            ]
        , Html.div []
            [ Html.div []
                [ myCheckbox "checked-hero-checkbox"
                , myCheckbox "unchecked-hero-checkbox"
                ]
            ]
        , Html.h2 [ Typography.headline6 ] [ text "Resources" ]
        , Html.h2 [ Typography.headline6 ] [ text "Demos" ]
        , Html.div []
            [ Html.h3 [ Typography.subtitle1 ] [ text "Unchecked" ]
            , Html.div [] [ myCheckbox "unchecked-checkbox" ]
            , Html.h3 [ Typography.subtitle1 ] [ text "Indeterminate" ]
            , Html.div [] [ myCheckbox "indeterminate-checkbox" ]
            , Html.h3 [ Typography.subtitle1 ] [ text "Checked" ]
            , Html.div [] [ myCheckbox "checked-checkbox" ]
            ]
        ]
