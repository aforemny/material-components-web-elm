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
                | on = True
                , onClick = Just SwitchClicked
            }


# Switch

@docs switch, SwitchConfig, switchConfig


# On Switch

To set the state of a switch, set its `on` configuration field to a `Bool`
value.

    switch { switchConfig | on = True }


# Disabled Switch

To disable a switch, set its `disabled` configuration field to `True`. Disabled
switches cannot be interacted with and have no visual interaction effect.

    switch { switchConfig | disabled = True }

-}

import Html exposing (Html, text)
import Html.Attributes exposing (class)
import Html.Events
import Json.Decode as Decode


{-| Configuration of a switch
-}
type alias SwitchConfig msg =
    { checked : Bool
    , disabled : Bool
    , additionalAttributes : List (Html.Attribute msg)
    , onClick : Maybe msg
    }


{-| Default configuration of a switch
-}
switchConfig : SwitchConfig msg
switchConfig =
    { checked = False
    , disabled = False
    , additionalAttributes = []
    , onClick = Nothing
    }


{-| Switch view function
-}
switch : SwitchConfig msg -> Html msg
switch config =
    Html.node "mdc-switch"
        (List.filterMap identity
            [ rootCs
            , checkedAttr config
            , disabledAttr config
            ]
            ++ config.additionalAttributes
        )
        [ trackElt
        , thumbUnderlayElt config
        ]


rootCs : Maybe (Html.Attribute msg)
rootCs =
    Just (class "mdc-switch")


checkedAttr : SwitchConfig msg -> Maybe (Html.Attribute msg)
checkedAttr { checked } =
    if checked then
        Just (Html.Attributes.attribute "checked" "")

    else
        Nothing


disabledAttr : SwitchConfig msg -> Maybe (Html.Attribute msg)
disabledAttr { disabled } =
    if disabled then
        Just (Html.Attributes.attribute "disabled" "")

    else
        Nothing


nativeControlCs : Maybe (Html.Attribute msg)
nativeControlCs =
    Just (class "mdc-switch__native-control")


switchRoleAttr : Maybe (Html.Attribute msg)
switchRoleAttr =
    Just (Html.Attributes.attribute "role" "switch")


checkboxTypeAttr : Maybe (Html.Attribute msg)
checkboxTypeAttr =
    Just (Html.Attributes.type_ "checkbox")


clickHandler : SwitchConfig msg -> Maybe (Html.Attribute msg)
clickHandler config =
    Maybe.map (\msg -> Html.Events.preventDefaultOn "click" (Decode.succeed ( msg, True )))
        config.onClick


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
            , clickHandler config
            ]
        )
        []
