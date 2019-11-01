module Material.Switch exposing (switch, SwitchConfig, switchConfig)

{-| Switches toggle the state of a single setting on or off. They are the
preferred way to adjust settings on mobile.


# Table of Contents

  - [Resources](#resources)
  - [Basic Usage](#basic-usage)
  - [Switch](#switch)
  - [On Switch](#on-switch)
  - [Disabled Switch](#disabled-switch)


# Resources

  - [Demo: Switches](https://aforemny.github.io/material-components-web-elm/#switches)
  - [Material Design Guidelines: Selection Controls – Switches](https://material.io/go/design-switches)
  - [MDC Web: Switch](https://github.com/material-components/material-components-web/tree/master/packages/mdc-switch)
  - [Sass Mixins (MDC Web)](https://github.com/material-components/material-components-web/tree/master/packages/mdc-switch#sass-mixins)


# Basic Usage

Note that switches are usually used in conjunction with form fields. Refer to
[FormField](Material-FormField) for more information.

    import Material.Switch exposing (switch, switchConfig)

    type Msg
        = SwitchClicked

    main =
        switch
            { switchConfig
                | checked = True
                , onChange = Just SwitchClicked
            }


# Switch

@docs switch, SwitchConfig, switchConfig


# On Switch

To set the state of a switch, set its `checked` configuration field to a `Bool`
value.

    switch { switchConfig | checked = True }


# Disabled Switch

To disable a switch, set its `disabled` configuration field to `True`. Disabled
switches cannot be interacted with and have no visual interaction effect.

    switch { switchConfig | disabled = True }

-}

import Html exposing (Html, text)
import Html.Attributes exposing (class)
import Html.Events
import Json.Decode as Decode
import Json.Encode as Encode


{-| Configuration of a switch
-}
type alias SwitchConfig msg =
    { checked : Bool
    , disabled : Bool
    , additionalAttributes : List (Html.Attribute msg)
    , onChange : Maybe msg
    }


{-| Default configuration of a switch
-}
switchConfig : SwitchConfig msg
switchConfig =
    { checked = False
    , disabled = False
    , additionalAttributes = []
    , onChange = Nothing
    }


{-| Switch view function
-}
switch : SwitchConfig msg -> Html msg
switch config =
    Html.node "mdc-switch"
        (List.filterMap identity
            [ rootCs
            , checkedProp config
            , disabledProp config
            ]
            ++ config.additionalAttributes
        )
        [ trackElt
        , thumbUnderlayElt config
        ]


rootCs : Maybe (Html.Attribute msg)
rootCs =
    Just (class "mdc-switch")


checkedProp : SwitchConfig msg -> Maybe (Html.Attribute msg)
checkedProp { checked } =
    Just (Html.Attributes.property "checked" (Encode.bool checked))


disabledProp : SwitchConfig msg -> Maybe (Html.Attribute msg)
disabledProp { disabled } =
    Just (Html.Attributes.property "disabled" (Encode.bool disabled))


nativeControlCs : Maybe (Html.Attribute msg)
nativeControlCs =
    Just (class "mdc-switch__native-control")


switchRoleAttr : Maybe (Html.Attribute msg)
switchRoleAttr =
    Just (Html.Attributes.attribute "role" "switch")


checkboxTypeAttr : Maybe (Html.Attribute msg)
checkboxTypeAttr =
    Just (Html.Attributes.type_ "checkbox")


changeHandler : SwitchConfig msg -> Maybe (Html.Attribute msg)
changeHandler config =
    Maybe.map (Html.Events.on "change" << Decode.succeed) config.onChange


trackElt : Html msg
trackElt =
    Html.div [ class "mdc-switch__track" ] []


thumbUnderlayElt : SwitchConfig msg -> Html msg
thumbUnderlayElt config =
    Html.div [ class "mdc-switch__thumb-underlay" ] [ thumbElt config ]


thumbElt : SwitchConfig msg -> Html msg
thumbElt config =
    Html.div [ class "mdc-switch__thumb" ] [ nativeControlElt config ]


nativeControlElt : SwitchConfig msg -> Html msg
nativeControlElt config =
    Html.input
        (List.filterMap identity
            [ nativeControlCs
            , checkboxTypeAttr
            , switchRoleAttr
            , checkedProp config
            , changeHandler config
            ]
        )
        []
