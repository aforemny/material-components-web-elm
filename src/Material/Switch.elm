module Material.Switch exposing
    ( switch
    , Config, config
    , setOnChange
    , setChecked
    , setDisabled
    , setId
    , setName
    , setValue
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
@docs setId
@docs setName
@docs setValue
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
        , id : Maybe String
        , name : Maybe String
        , value : Maybe String
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
        , id = Nothing
        , name = Nothing
        , value = Nothing
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


{-| Specify a switch's id
-}
setId : Maybe String -> Config msg -> Config msg
setId id (Config config_) =
    Config { config_ | id = id }


{-| Specify a switch's name
-}
setName : Maybe String -> Config msg -> Config msg
setName name (Config config_) =
    Config { config_ | name = name }


{-| Specify a switch's value
-}
setValue : Maybe String -> Config msg -> Config msg
setValue value (Config config_) =
    Config { config_ | value = value }


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
            , idAttr config_
            , nameAttr config_
            , valueAttr config_
            , checkedProp config_
            , changeHandler config_
            ]
        )
        []


idAttr : Config msg -> Maybe (Html.Attribute msg)
idAttr (Config { id }) =
    Maybe.map Html.Attributes.id id


nameAttr : Config msg -> Maybe (Html.Attribute msg)
nameAttr (Config { name }) =
    Maybe.map Html.Attributes.name name


valueAttr : Config msg -> Maybe (Html.Attribute msg)
valueAttr (Config { value }) =
    Maybe.map Html.Attributes.value value

