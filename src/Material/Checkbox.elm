module Material.Checkbox exposing (checkbox, checkboxConfig, CheckboxConfig, CheckboxState(..))

{-| Checkboxes allow the user to select one or more items from a set.


# Table of Contents

  - [Resources](#resources)
  - [Basic Usage](#basic-usage)
  - [Checkbox](#checkbox)
  - [Checked Checkbox](#checked-Checkbox)
  - [Indeterminate Checkbox](#indeterminate-checkbox)
  - [Disabled Checkbox](#disabled-checkbox)


# Resources

  - [Demo: Checkboxes](https://aforemny.github.io/material-components-web-elm/#checkboxes)
  - [Material Design Guidelines: Selection Controls – Checkbox](https://material.io/go/design-checkboxes)
  - [MDC Web: Checkbox](https://github.com/material-components/material-components-web/tree/master/packages/mdc-checkbox)
  - [Sass Mixins (MDC Web)](https://github.com/material-components/material-components-web/tree/master/packages/mdc-checkbox#sass-mixins)


# Basic Usage

Note that checkboxes are usually used in conjunction with form fields. Refer to
[FormField](Material-FormField) for more information.

    import Material.Checkbox as Checkbox
        exposing
            ( checkbox
            , checkboxConfig
            )

    type Msg
        = CheckboxClicked

    main =
        checkbox
            { checkboxConfig
                | state = Checkbox.Unchecked
                , onChange = Just CheckboxClicked
            }


# Checkbox

@docs checkbox, checkboxConfig, CheckboxConfig, CheckboxState


# Checked Checkbox

To set the state of a checkbox to checked, set its `state` configuration field
to `Checked`. To set its state to unchecked, use `Unchecked`.

    checkbox { checkboxConfig | state = Checkbox.Checked }


# Indeterminate Checkbox

To set the state of a checkbox to indeterminate, set its `state` configuration
field to `Indeterminate`.

    checkbox
        { checkboxConfig | state = Checkbox.Indeterminate }


# Disabled Checkbox

To disable a checkbox, set its disabled configuration field to True. Disabled
checkboxes cannot be interacted with and have no visual interaction effect.

    checkbox { checkboxConfig | disabled = True }

-}

import Html exposing (Html, text)
import Html.Attributes exposing (class)
import Html.Events
import Json.Decode as Decode
import Json.Encode as Encode
import Svg
import Svg.Attributes


{-| Configuration of a checkbox
-}
type alias CheckboxConfig msg =
    { state : CheckboxState
    , disabled : Bool
    , additionalAttributes : List (Html.Attribute msg)
    , onChange : Maybe msg
    }


{-| Default configuration of a checkbox
-}
checkboxConfig : CheckboxConfig msg
checkboxConfig =
    { state = Unchecked
    , disabled = False
    , additionalAttributes = []
    , onChange = Nothing
    }


{-| -}
type CheckboxState
    = Unchecked
    | Checked
    | Indeterminate


{-| Checkbox view function
-}
checkbox : CheckboxConfig msg -> Html msg
checkbox config =
    Html.node "mdc-checkbox"
        (List.filterMap identity
            [ rootCs
            , checkedProp config
            , indeterminateProp config
            , disabledProp config
            ]
            ++ config.additionalAttributes
        )
        [ nativeControlElt config
        , backgroundElt
        ]


rootCs : Maybe (Html.Attribute msg)
rootCs =
    Just (class "mdc-checkbox")


checkedProp : CheckboxConfig msg -> Maybe (Html.Attribute msg)
checkedProp { state } =
    Just (Html.Attributes.property "checked" (Encode.bool (state == Checked)))


indeterminateProp : CheckboxConfig msg -> Maybe (Html.Attribute msg)
indeterminateProp { state } =
    Just (Html.Attributes.property "indeterminate" (Encode.bool (state == Indeterminate)))


disabledProp : CheckboxConfig msg -> Maybe (Html.Attribute msg)
disabledProp { disabled } =
    Just (Html.Attributes.property "disabled" (Encode.bool disabled))


changeHandler : CheckboxConfig msg -> Maybe (Html.Attribute msg)
changeHandler { state, onChange } =
    -- Note: MDCList choses to send a change event to all checkboxes, thus we
    -- have to check here if the state actually changed.
    Maybe.map
        (\msg ->
            Html.Events.on "change"
                (Decode.at [ "target", "checked" ] Decode.bool
                    |> Decode.andThen
                        (\checked ->
                            if
                                (checked && state /= Checked)
                                    || (not checked && state /= Unchecked)
                            then
                                Decode.succeed msg

                            else
                                Decode.fail ""
                        )
                )
        )
        onChange


nativeControlElt : CheckboxConfig msg -> Html msg
nativeControlElt config =
    Html.input
        (List.filterMap identity
            [ Just (Html.Attributes.type_ "checkbox")
            , Just (class "mdc-checkbox__native-control")
            , checkedProp config
            , indeterminateProp config
            , changeHandler config
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
