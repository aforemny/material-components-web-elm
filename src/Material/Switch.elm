module Material.Switch exposing
    ( switch
    , Config, config
    , setOnChange
    , setChecked
    , setDisabled
    , setAttributes
    )

{-| Switches toggle the state of a single setting on or off. They are the
preferred way to adjust settings on mobile.


# Table of Contents

  - [Resources](#resources)
  - [Basic Usage](#basic-usage)
  - [Configuration](#configuration)
      - [Configuration Options](#configuration-options)
  - [Switch](#switch)
  - [On Switch](#on-switch)
  - [Disabled Switch](#disabled-switch)
  - [Focus a Switch](#focus-a-switch)


# Resources

  - [Demo: Switches](https://aforemny.github.io/material-components-web-elm/#switch)
  - [Material Design Guidelines: Selection Controls – Switches](https://material.io/go/design-switches)
  - [MDC Web: Switch](https://github.com/material-components/material-components-web/tree/master/packages/mdc-switch)
  - [Sass Mixins (MDC Web)](https://github.com/material-components/material-components-web/tree/master/packages/mdc-switch#sass-mixins)


# Basic Usage

Note that switches are usually used in conjunction with [form
fields](Material-FormField).

    import Material.Switch as Switch

    type Msg
        = Changed

    main =
        Switch.switch
            (Switch.config
                |> Switch.setChecked True
                |> Switch.setOnChange Changed
            )


# Switch

@docs switch


# Configuration

@docs Config, config


## Configuration Options

@docs setOnChange
@docs setChecked
@docs setDisabled
@docs setAttributes


# On Switch

To set the state of a switch to on, set its `setChecked` configuration option
to `True`.

    Switch.switch (Switch.config |> Switch.setChecked True)


# Disabled Switch

To disable a switch, set its `setDisabled` configuration option to `True`.

Disabled switches cannot be interacted with and have no visual interaction
effect.

    Switch.switch (Switch.config |> Switch.setDisabled True)


# Focus a Switch

You may programatically focus a switch by assigning an id attribute to it and
use `Browser.Dom.focus`.

    Switch.switch
        (Switch.config
            |> Switch.setAttributes
                [ Html.Attributes.id "my-switch" ]
        )

-}

import Html exposing (Html)
import Html.Attributes exposing (class)
import Html.Events
import Json.Decode as Decode
import Json.Encode as Encode


{-| Configuration of a switch
-}
type Config msg
    = Config
        { checked : Bool
        , disabled : Bool
        , additionalAttributes : List (Html.Attribute msg)
        , onChange : Maybe msg
        }


{-| Default configuration of a switch
-}
config : Config msg
config =
    Config
        { checked = False
        , disabled = False
        , additionalAttributes = []
        , onChange = Nothing
        }


{-| Specify whether a switch is checked
-}
setChecked : Bool -> Config msg -> Config msg
setChecked checked (Config config_) =
    Config { config_ | checked = checked }


{-| Specify whether a switch is disabled

Disabled switches cannot be interacted with and have no visual interaction
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


{-| Specify a message when the user changes a switch
-}
setOnChange : msg -> Config msg -> Config msg
setOnChange onChange (Config config_) =
    Config { config_ | onChange = Just onChange }


{-| Switch view function
-}
switch : Config msg -> Html msg
switch ((Config { additionalAttributes }) as config_) =
    Html.node "mdc-switch"
        (List.filterMap identity
            [ rootCs
            , checkedProp config_
            , disabledProp config_
            ]
            ++ additionalAttributes
        )
        [ trackElt
        , thumbUnderlayElt config_
        ]


rootCs : Maybe (Html.Attribute msg)
rootCs =
    Just (class "mdc-switch")


checkedProp : Config msg -> Maybe (Html.Attribute msg)
checkedProp (Config { checked }) =
    Just (Html.Attributes.property "checked" (Encode.bool checked))


disabledProp : Config msg -> Maybe (Html.Attribute msg)
disabledProp (Config { disabled }) =
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


changeHandler : Config msg -> Maybe (Html.Attribute msg)
changeHandler (Config { onChange }) =
    Maybe.map (Html.Events.on "change" << Decode.succeed) onChange


trackElt : Html msg
trackElt =
    Html.div [ class "mdc-switch__track" ] []


thumbUnderlayElt : Config msg -> Html msg
thumbUnderlayElt config_ =
    Html.div [ class "mdc-switch__thumb-underlay" ] [ thumbElt config_ ]


thumbElt : Config msg -> Html msg
thumbElt config_ =
    Html.div [ class "mdc-switch__thumb" ] [ nativeControlElt config_ ]


nativeControlElt : Config msg -> Html msg
nativeControlElt config_ =
    Html.input
        (List.filterMap identity
            [ nativeControlCs
            , checkboxTypeAttr
            , switchRoleAttr
            , checkedProp config_
            , changeHandler config_
            ]
        )
        []
