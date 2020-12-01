module Material.Radio exposing
    ( Config, config
    , setOnChange
    , setChecked
    , setDisabled
    , setTouch
    , setAttributes
    , radio
    )

{-| Radio buttons allow the user to select one option from a set while seeing
all available options.


# Table of Contents

  - [Resources](#resources)
  - [Basic Usage](#basic-usage)
  - [Configuration](#configuration)
      - [Configuration Options](#configuration-options)
  - [Radio](#radio)
  - [Checked Radio](#checked-radio)
  - [Disabled Radio](#disabled-radio)
  - [Focus a Radio](#focus-a-radio)
  - [Touch Support](#touch-support)


# Resources

  - [Demo: Radio Buttons](https://aforemny.github.io/material-components-web-elm/#radio-buttons)
  - [Material Design Guidelines: Selection Controls – Radio buttons](https://material.io/go/design-radio-buttons)
  - [MDC Web: Radio](https://github.com/material-components/material-components-web/tree/master/packages/mdc-radio)
  - [Sass Mixins (MDC Web)](https://github.com/material-components/material-components-web/tree/master/packages/mdc-radio#sass-mixins)


# Basic Usage

Note that radio buttons are usually used in conjunction with [form
fields](Material-FormField).

    import Material.Radio as Radio

    type Msg
        = Changed

    main =
        Radio.radio
            (Radio.config
                |> Radio.setChecked True
                |> Radio.setOnChange Changed
            )


# Configuration

@docs Config, config


## Configuration Options

@docs setOnChange
@docs setChecked
@docs setDisabled
@docs setTouch
@docs setAttributes


# Radio

@docs radio


# Checked Radio

To make a radio button display its checked state, set its `setChecked`
configuration option to `True`.

    Radio.radio (Radio.config |> Radio.setChecked True)


# Disabled Radio

To disable a radio button, set its `setDisabled` configuration option to `True`.

Disabled radio buttons cannot be interacted with and have no visual interaction
effect.

    Radio.radio (Radio.config |> Radio.setDisabled True)


# Focus a Radio

You may programatically focus a radio button by assigning an id attribute to it
and use `Browser.Dom.focus`.

    Radio.radio
        (Radio.config
            |> Radio.setAttributes
                [ Html.Attributes.id "my-radio" ]
        )


# Touch Support

Touch support is enabled by default. To disable touch support set a radio's
`setTouch` configuration option to `False`.

    Radio.radio (Radio.config |> Radio.setTouch False)

-}

import Html exposing (Html)
import Html.Attributes exposing (class)
import Html.Events
import Json.Decode as Decode
import Json.Encode as Encode


{-| Radio button configuration
-}
type Config msg
    = Config
        { checked : Bool
        , disabled : Bool
        , additionalAttributes : List (Html.Attribute msg)
        , onChange : Maybe msg
        , touch : Bool
        }


{-| Default radio button configuration
-}
config : Config msg
config =
    Config
        { checked = False
        , disabled = False
        , additionalAttributes = []
        , onChange = Nothing
        , touch = True
        }


{-| Specify whether a radio button is checked
-}
setChecked : Bool -> Config msg -> Config msg
setChecked checked (Config config_) =
    Config { config_ | checked = checked }


{-| Specify whether a radio button is disabled

Disabled radio buttons cannot be interacted with and have no visual interaction
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


{-| Specify a message when the user changes a radio
-}
setOnChange : msg -> Config msg -> Config msg
setOnChange onChange (Config config_) =
    Config { config_ | onChange = Just onChange }


{-| Specify whether touch support is enabled (enabled by default)

Touch support is an accessibility guideline that states that touch targets
should be at least 48 x 48 pixels in size. Use this configuration option to
disable increased touch target size.

**Note:** Radios with touch support will be wrapped in a HTML div element to
prevent potentially overlapping touch targets on adjacent elements.

-}
setTouch : Bool -> Config msg -> Config msg
setTouch touch (Config config_) =
    Config { config_ | touch = touch }


{-| Radio button view function
-}
radio : Config msg -> Html msg
radio ((Config { touch, additionalAttributes }) as config_) =
    let
        wrapTouch node =
            if touch then
                Html.div [ class "mdc-touch-target-wrapper" ] [ node ]

            else
                node
    in
    wrapTouch <|
        Html.node "mdc-radio"
            (List.filterMap identity
                [ rootCs
                , touchCs config_
                , checkedProp config_
                , disabledProp config_
                ]
                ++ additionalAttributes
            )
            [ nativeControlElt config_
            , backgroundElt
            , rippleElt
            ]


rootCs : Maybe (Html.Attribute msg)
rootCs =
    Just (class "mdc-radio")


touchCs : Config msg -> Maybe (Html.Attribute msg)
touchCs (Config { touch }) =
    if touch then
        Just (class "mdc-radio--touch")

    else
        Nothing


checkedProp : Config msg -> Maybe (Html.Attribute msg)
checkedProp (Config { checked }) =
    Just (Html.Attributes.property "checked" (Encode.bool checked))


disabledProp : Config msg -> Maybe (Html.Attribute msg)
disabledProp (Config { disabled }) =
    Just (Html.Attributes.property "disabled" (Encode.bool disabled))


changeHandler : Config msg -> Maybe (Html.Attribute msg)
changeHandler (Config { checked, onChange }) =
    Maybe.map (\msg -> Html.Events.on "change" (Decode.succeed msg)) onChange


nativeControlElt : Config msg -> Html msg
nativeControlElt config_ =
    Html.input
        (List.filterMap identity
            [ nativeControlCs
            , radioTypeAttr
            , checkedProp config_
            , changeHandler config_
            ]
        )
        []


nativeControlCs : Maybe (Html.Attribute msg)
nativeControlCs =
    Just (class "mdc-radio__native-control")


radioTypeAttr : Maybe (Html.Attribute msg)
radioTypeAttr =
    Just (Html.Attributes.type_ "radio")


backgroundElt : Html msg
backgroundElt =
    Html.div [ class "mdc-radio__background" ] [ outerCircleElt, innerCircleElt ]


outerCircleElt : Html msg
outerCircleElt =
    Html.div [ class "mdc-radio__outer-circle" ] []


innerCircleElt : Html msg
innerCircleElt =
    Html.div [ class "mdc-radio__inner-circle" ] []


rippleElt : Html msg
rippleElt =
    Html.div [ class "mdc-radio__ripple" ] []
