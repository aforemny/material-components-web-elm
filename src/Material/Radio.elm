module Material.Radio exposing
    ( Config, config
    , setOnChange
    , setChecked
    , setDisabled
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


# Resources

  - [Demo: Radio Buttons](https://aforemny.github.io/material-components-web-elm/#radio-buttons)
  - [Material Design Guidelines: Selection Controls – Radio buttons](https://material.io/go/design-radio-buttons)
  - [MDC Web: Radio](https://github.com/material-components/material-components-web/tree/master/packages/mdc-radio)
  - [Sass Mixins (MDC Web)](https://github.com/material-components/material-components-web/tree/master/packages/mdc-radio#sass-mixins)


# Basic Usage

Note that radio buttons are usually used in conjunction with form fields. Refer
to [FormField](Material-FormField) for more information.

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
@docs setAttributes


# Radio

@docs radio


# Checked Radio

To make a radio button display its checked state, use its `setChecked`
configuration option.

    Radio.radio
        (Radio.config
            |> Radio.setChecked True
        )


# Disabled Radio

To disable a radio button, use its `setDisabled` configuration option. Disabled
radio buttons cannot be interacted with and have no visual interaction effect.

    Radio.radio
        (Radio.config
            |> Radio.setDisabled True
        )

-}

import Html exposing (Html, text)
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
        }


{-| Make a radio button checked
-}
setChecked : Bool -> Config msg -> Config msg
setChecked checked (Config config_) =
    Config { config_ | checked = checked }


{-| Make a radio button disabled
-}
setDisabled : Bool -> Config msg -> Config msg
setDisabled disabled (Config config_) =
    Config { config_ | disabled = disabled }


{-| Specify additional attributes
-}
setAttributes : List (Html.Attribute msg) -> Config msg -> Config msg
setAttributes additionalAttributes (Config config_) =
    Config { config_ | additionalAttributes = additionalAttributes }


{-| Specify a message when the user changes a radio |
-}
setOnChange : msg -> Config msg -> Config msg
setOnChange onChange (Config config_) =
    Config { config_ | onChange = Just onChange }


{-| Radio button view function
-}
radio : Config msg -> Html msg
radio ((Config { additionalAttributes }) as config_) =
    Html.node "mdc-radio"
        (List.filterMap identity
            [ rootCs
            , checkedProp config_
            , disabledProp config_
            ]
            ++ additionalAttributes
        )
        [ nativeControlElt config_
        , backgroundElt
        ]


rootCs : Maybe (Html.Attribute msg)
rootCs =
    Just (class "mdc-radio")


checkedProp : Config msg -> Maybe (Html.Attribute msg)
checkedProp (Config { checked }) =
    Just (Html.Attributes.property "checked" (Encode.bool checked))


disabledProp : Config msg -> Maybe (Html.Attribute msg)
disabledProp (Config { disabled }) =
    Just (Html.Attributes.property "disabled" (Encode.bool disabled))


changeHandler : Config msg -> Maybe (Html.Attribute msg)
changeHandler (Config { checked, onChange }) =
    -- Note: MDCList choses to send a change event to all checkboxes, thus we
    -- have to check here if the state actually changed.
    Maybe.map
        (\msg ->
            Html.Events.on "change"
                (Decode.at [ "target", "checked" ] Decode.bool
                    |> Decode.andThen
                        (\checked_ ->
                            if (checked_ && not checked) || (not checked_ && checked) then
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
