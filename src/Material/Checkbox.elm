module Material.Checkbox exposing
    ( Config, config
    , setOnChange
    , State, setState
    , setDisabled
    , setAttributes
    , checkbox
    , checked, unchecked
    , indeterminate
    )

{-| Checkboxes allow the user to select one or more items from a set.


# Table of Contents

  - [Resources](#resources)
  - [Basic Usage](#basic-usage)
  - [Configuration](#configuration)
      - [Configuration Options](#configuration-options)
  - [Checkbox](#checkbox)
  - [Checked Checkbox](#checked-Checkbox)
  - [Indeterminate Checkbox](#indeterminate-checkbox)
  - [Disabled Checkbox](#disabled-checkbox)


# Resources

  - [Demo: Checkboxes](https://aforemny.github.io/material-components-web-elm/#checkbox)
  - [Material Design Guidelines: Selection Controls – Checkbox](https://material.io/go/design-checkboxes)
  - [MDC Web: Checkbox](https://github.com/material-components/material-components-web/tree/master/packages/mdc-checkbox)
  - [Sass Mixins (MDC Web)](https://github.com/material-components/material-components-web/tree/master/packages/mdc-checkbox#sass-mixins)


# Basic Usage

Note that checkboxes are usually used in conjunction with form fields. Refer to
[FormField](Material-FormField) for more information.

    import Material.Checkbox as Checkbox

    type Msg
        = Changed

    main =
        checkbox
            (Checkbox.config
                |> Checkbox.setState Checkbox.Unchecked
                |> Checkbox.setOnChange Changed
            )


# Configuration

@docs Config, config


## Configuration Options

@docs setOnChange
@docs State, setState
@docs setDisabled
@docs setAttributes


# Checkbox

@docs checkbox


# Checked Checkbox

To set the state of a checkbox, use its `setState` configuration option.

    Checkbox.checkbox
        (Checkbox.config |> Checkbox.setState (Just Checkbox.checked))

@docs checked, unchecked


# Indeterminate Checkbox

To set the state of a checkbox, use its `setState` configuration option.

    Checkbox.checkbox
        (Checkbox.config
            |> Checkbox.setState (Just Checkbox.indeterminate)
        )

@docs indeterminate


# Disabled Checkbox

To disable a checkbox, use its `setDisabled` configuration option. Disabled
checkboxes cannot be interacted with and have no visual interaction effect.

    Checkbox.checkbox
        (Checkbox.config |> Checkbox.setDisabled True)

-}

import Html exposing (Html, text)
import Html.Attributes exposing (class)
import Html.Events
import Json.Decode as Decode
import Json.Encode as Encode
import Material.Checkbox.Internal exposing (Config(..), State(..))
import Svg
import Svg.Attributes


{-| Configuration of a checkbox
-}
type alias Config msg =
    Material.Checkbox.Internal.Config msg


{-| Default configuration of a checkbox
-}
config : Config msg
config =
    Config
        { state = Nothing
        , disabled = False
        , additionalAttributes = []
        , onChange = Nothing
        }


{-| Specify a checkbox' state

A checkbox may be in `checked`, `unchecked` or `indeterminate` state.

-}
setState : Maybe State -> Config msg -> Config msg
setState state (Config config_) =
    Config { config_ | state = state }


{-| Specify whether a checkbox is disabled

Disabled checkboxes cannot be interacted with and have no visual interaction
effect.

-}
setDisabled : Bool -> Config msg -> Config msg
setDisabled disabled (Config config_) =
    Config { config_ | disabled = disabled }


{-| Specify additional attributes
-}
setAttributes : List (Html.Attribute msg) -> Config msg -> Config msg
setAttributes additionalAttributes (Config config_) =
    Config { config_ | additionalAttributes = additionalAttributes }


{-| Specify a message when the user changes a checkbox
-}
setOnChange : msg -> Config msg -> Config msg
setOnChange onChange (Config config_) =
    Config { config_ | onChange = Just onChange }


{-| State of a checkbox
-}
type alias State =
    Material.Checkbox.Internal.State


{-| Unchecked state
-}
unchecked : State
unchecked =
    Unchecked


{-| Checked state
-}
checked : State
checked =
    Checked


{-| Indeterminate state
-}
indeterminate : State
indeterminate =
    Indeterminate


{-| Checkbox view function
-}
checkbox : Config msg -> Html msg
checkbox ((Config { additionalAttributes }) as config_) =
    Html.node "mdc-checkbox"
        (List.filterMap identity
            [ rootCs
            , checkedProp config_
            , indeterminateProp config_
            , disabledProp config_
            ]
            ++ additionalAttributes
        )
        [ nativeControlElt config_
        , backgroundElt
        ]


rootCs : Maybe (Html.Attribute msg)
rootCs =
    Just (class "mdc-checkbox")


checkedProp : Config msg -> Maybe (Html.Attribute msg)
checkedProp (Config { state }) =
    Just (Html.Attributes.property "checked" (Encode.bool (state == Just Checked)))


indeterminateProp : Config msg -> Maybe (Html.Attribute msg)
indeterminateProp (Config { state }) =
    Just (Html.Attributes.property "indeterminate" (Encode.bool (state == Just Indeterminate)))


disabledProp : Config msg -> Maybe (Html.Attribute msg)
disabledProp (Config { disabled }) =
    Just (Html.Attributes.property "disabled" (Encode.bool disabled))


changeHandler : Config msg -> Maybe (Html.Attribute msg)
changeHandler (Config { state, onChange }) =
    -- Note: MDCList choses to send a change event to all checkboxes, thus we
    -- have to check here if the state actually changed.
    Maybe.map
        (\msg ->
            Html.Events.on "change"
                (Decode.at [ "target", "checked" ] Decode.bool
                    |> Decode.andThen
                        (\isChecked ->
                            if
                                (isChecked && state /= Just Checked)
                                    || (not isChecked && state /= Just Unchecked)
                            then
                                Decode.succeed msg

                            else
                                Decode.fail ""
                        )
                )
        )
        onChange


nativeControlElt : Config msg -> Html msg
nativeControlElt config_ =
    Html.input
        (List.filterMap identity
            [ Just (Html.Attributes.type_ "checkbox")
            , Just (class "mdc-checkbox__native-control")
            , checkedProp config_
            , indeterminateProp config_
            , changeHandler config_
            ]
        )
        []


backgroundElt : Html msg
backgroundElt =
    Html.div
        [ class "mdc-checkbox__background" ]
        [ Svg.svg
            [ Svg.Attributes.class "mdc-checkbox__checkmark"
            , Svg.Attributes.viewBox "0 0 24 24"
            ]
            [ Svg.path
                [ Svg.Attributes.class "mdc-checkbox__checkmark-path"
                , Svg.Attributes.fill "none"
                , Svg.Attributes.d "M1.73,12.91 8.1,19.28 22.79,4.59"
                ]
                []
            ]
        , Html.div [ class "mdc-checkbox__mixedmark" ] []
        ]
