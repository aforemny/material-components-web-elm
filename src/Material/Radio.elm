module Material.Radio exposing (radio, radioConfig, RadioConfig)

{-| Radio buttons allow the user to select one option from a set while seeing
all available options.


# Table of Contents

  - [Resources](#resources)
  - [Basic Usage](#basic-usage)
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

    import Material.Radio exposing (radio, radioConfig)

    type Msg
        = RadioClicked

    main =
        radio
            { radioConfig
                | checked = True
                , onChange = Just RadioClicked
            }


# Radio

@docs radio, radioConfig, RadioConfig


# Checked Radio

To set the state of a radio button, set its checked configuration field to a Bool value.

    radio { radioConfig | checked = False }


# Disabled Radio

To disable a radio button, set its disabled configuration field to True. Disabled
radio buttons cannot be interacted with and have no visual interaction effect.

    radio { radioConfig | disabed = True }

-}

import Html exposing (Html, text)
import Html.Attributes exposing (class)
import Html.Events
import Json.Decode as Decode
import Json.Encode as Encode


{-| Radio button configuration
-}
type alias RadioConfig msg =
    { checked : Bool
    , disabled : Bool
    , additionalAttributes : List (Html.Attribute msg)
    , onChange : Maybe msg
    }


{-| Default radio button configuration
-}
radioConfig : RadioConfig msg
radioConfig =
    { checked = False
    , disabled = False
    , additionalAttributes = []
    , onChange = Nothing
    }


{-| Radio button view function
-}
radio : RadioConfig msg -> Html msg
radio config =
    Html.node "mdc-radio"
        (List.filterMap identity
            [ rootCs
            , checkedProp config
            , disabledProp config
            ]
            ++ config.additionalAttributes
        )
        [ nativeControlElt config
        , backgroundElt
        ]


rootCs : Maybe (Html.Attribute msg)
rootCs =
    Just (class "mdc-radio")


checkedProp : RadioConfig msg -> Maybe (Html.Attribute msg)
checkedProp { checked } =
    Just (Html.Attributes.property "checked" (Encode.bool checked))


disabledProp : RadioConfig msg -> Maybe (Html.Attribute msg)
disabledProp { disabled } =
    Just (Html.Attributes.property "disabled" (Encode.bool disabled))


changeHandler : RadioConfig msg -> Maybe (Html.Attribute msg)
changeHandler { checked, onChange } =
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


nativeControlElt : RadioConfig msg -> Html msg
nativeControlElt config =
    Html.input
        (List.filterMap identity
            [ nativeControlCs
            , radioTypeAttr
            , checkedProp config
            , changeHandler config
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
