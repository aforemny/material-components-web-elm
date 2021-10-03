module Material.Slider exposing
    ( Config, config
    , setOnInput
    , setDiscrete
    , setDisplayMarkers
    , setMin
    , setMax
    , setStep
    , setValue
    , setDisabled
    , setAttributes
    , slider
    )

{-| Slider provides a component to select a numerical value within a range.


# Table of Contents

  - [Resources](#resources)
  - [Basic Usage](#basic-usage)
  - [Configuration](#configuration)
      - [Configuration Options](#configuration-options)
  - [Continuous Slider](#continuous-slider)
  - [Custom range values](#using-a-step-value)
  - [Using a step value](#using-a-step-value)
  - [Disabled Slider](#disabled-slider)
  - [Discrete Slider](#discrete-slider)
      - [Track Markers](#track-markers)
  - [Focus a Slider](#focus-a-slider)


# Resources

  - [Demo: Sliders](https://aforemny.github.io/material-components-web-elm/#slider)
  - [Material Design Guidelines: Sliders](https://material.io/go/design-sliders)
  - [MDC Web: Slider](https://github.com/material-components/material-components-web/tree/master/packages/mdc-slider)
  - [Sass Mixins (MDC Web)](https://github.com/material-components/material-components-web/tree/master/packages/mdc-slider#sass-mixins)


# Basic Usage

    import Material.Slider as Slider

    type Msg
        = ValueChanged Float

    main =
        Slider.slider
            (Slider.config
                |> Slider.setValue (Just 50)
                |> Slider.setOnInput ValueChanged
            )


# Configurations

@docs Config, config


## Configuration Options

@docs setOnInput
@docs setDiscrete
@docs setDisplayMarkers
@docs setMin
@docs setMax
@docs setStep
@docs setValue
@docs setDisabled
@docs setAttributes


# Continuous Slider

@docs slider


# Custom range values

To set a custom range, use the slider's `setMin` and `setMax` configuration
options.

    Slider.slider
        (Slider.config
            |> Slider.setMin 0
            |> Slider.setMax 100
        )


# Using a step value

To allow for quantization of the user input, use the slider's `setStep`
configuration option.

    Slider.slider (Slider.config |> Slider.setStep (Just 4.5))


# Disabled Slider

To disable a slider, set its `setDisabled` configuration option to `True`.

Disabled sliders cannot be interacted with and have no visual interaction
effect.

    Slider.slider (Slider.config |> Slider.setDisabled True)


# Discrete Slider

To treat a slider as a discrete slider, set its `setDiscrete` configuration
option to `True`.

    Slider.slider (Slider.config |> Slider.setDiscrete True)


## Track Markers

To have a discrete slider show track markers, set its `setDisplayMarkers`
configuration option to `True`.

Note that non-discrete sliders ignore this configuration option.

    Slider.slider
        (Slider.config |> Slider.setDisplayMarkers True)


# Focus a Slider

You may programatically focus a slider by assigning an id attribute to it and
use `Browser.Dom.focus`.

    Slider.slider
        (Slider.config
            |> Slider.setAttributes
                [ Html.Attributes.id "my-slider" ]
        )

-}

import Html exposing (Html, text)
import Html.Attributes exposing (class, style)
import Html.Events
import Json.Decode as Decode
import Json.Encode as Encode
import Svg
import Svg.Attributes



-- TODO: Prevent FOUC


{-| Configuration of a slider
-}
type Config msg
    = Config
        { discrete : Bool
        , displayMarkers : Bool
        , min : Float
        , max : Float
        , step : Float
        , value : Float
        , disabled : Bool
        , additionalAttributes : List (Html.Attribute msg)
        , onInput : Maybe (Float -> msg)
        }


{-| Default configuration of a slider
-}
config : Config msg
config =
    Config
        { discrete = False
        , displayMarkers = False
        , min = 0
        , max = 100
        , step = 1
        , value = 0
        , disabled = False
        , additionalAttributes = []
        , onInput = Nothing
        }


{-| Specify whether a slider is _discrete_

Discrete sliders feature a pin that indicates the current value while
interacting with the slider.

This works best for integer-valued sliders, but this is not a requirement.

-}
setDiscrete : Bool -> Config msg -> Config msg
setDiscrete discrete (Config config_) =
    Config { config_ | discrete = discrete }


{-| Specify whether a slider should display markers

Note that this option is ignored by non-discrete sliders.

-}
setDisplayMarkers : Bool -> Config msg -> Config msg
setDisplayMarkers displayMarkers (Config config_) =
    Config { config_ | displayMarkers = displayMarkers }


{-| Specify a slider's minimum value
-}
setMin : Float -> Config msg -> Config msg
setMin min (Config config_) =
    Config { config_ | min = min }


{-| Specify a slider's maximum value
-}
setMax : Float -> Config msg -> Config msg
setMax max (Config config_) =
    Config { config_ | max = max }


{-| Specify a slider's step value
-}
setStep : Float -> Config msg -> Config msg
setStep step (Config config_) =
    Config { config_ | step = step }


{-| Specify a slider's value
-}
setValue : Float -> Config msg -> Config msg
setValue value (Config config_) =
    Config { config_ | value = value }


{-| Specify whether a slider is disabled

Disabled sliders canot be interacted with and have no visual interaction
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


{-| Specify a message when the user interacts with the slider
-}
setOnInput : (Float -> msg) -> Config msg -> Config msg
setOnInput onInput (Config config_) =
    Config { config_ | onInput = Just onInput }


{-| Slider view function
-}
slider : Config msg -> Html msg
slider ((Config { additionalAttributes, discrete, displayMarkers }) as config_) =
    Html.node "mdc-slider"
        (List.filterMap identity
            [ rootCs
            , discreteCs config_
            , displayMarkersCs config_
            , sliderRoleAttr
            , valueProp config_
            , minProp config_
            , maxProp config_
            , stepProp config_
            , disabledProp config_
            , ariaValueMinAttr config_
            , ariaValueMaxAttr config_
            , ariaValuenowAttr config_
            , changeHandler config_
            ]
            ++ additionalAttributes
        )
        (List.concat
            [ [ inputElt config_
              , trackElt
              ]
            , if discrete && displayMarkers then
                [ tickMarksElt config_ ]

              else
                []
            , [ thumbElt config_ ]
            ]
        )


rootCs : Maybe (Html.Attribute msg)
rootCs =
    Just (class "mdc-slider")


discreteCs : Config msg -> Maybe (Html.Attribute msg)
discreteCs (Config { discrete }) =
    if discrete then
        Just (class "mdc-slider--discrete")

    else
        Nothing


displayMarkersCs : Config msg -> Maybe (Html.Attribute msg)
displayMarkersCs (Config { discrete, displayMarkers }) =
    if discrete && displayMarkers then
        Just (class "mdc-slider--tick-marks")

    else
        Nothing


sliderRoleAttr : Maybe (Html.Attribute msg)
sliderRoleAttr =
    Just (Html.Attributes.attribute "role" "slider")


valueProp : Config msg -> Maybe (Html.Attribute msg)
valueProp (Config { value }) =
    Just (Html.Attributes.property "value" (Encode.float value))


minProp : Config msg -> Maybe (Html.Attribute msg)
minProp (Config { min }) =
    Just (Html.Attributes.property "min" (Encode.float min))


maxProp : Config msg -> Maybe (Html.Attribute msg)
maxProp (Config { max }) =
    Just (Html.Attributes.property "max" (Encode.float max))


stepProp : Config msg -> Maybe (Html.Attribute msg)
stepProp (Config { step }) =
    Just (Html.Attributes.property "step" (Encode.float step))


disabledProp : Config msg -> Maybe (Html.Attribute msg)
disabledProp (Config { disabled }) =
    Just (Html.Attributes.property "disabled" (Encode.bool disabled))


ariaValueMinAttr : Config msg -> Maybe (Html.Attribute msg)
ariaValueMinAttr (Config { min }) =
    Just (Html.Attributes.attribute "aria-valuemin" (String.fromFloat min))


ariaValueMaxAttr : Config msg -> Maybe (Html.Attribute msg)
ariaValueMaxAttr (Config { max }) =
    Just (Html.Attributes.attribute "aria-valuemax" (String.fromFloat max))


ariaValuenowAttr : Config msg -> Maybe (Html.Attribute msg)
ariaValuenowAttr (Config { value }) =
    Just (Html.Attributes.attribute "aria-valuenow" (String.fromFloat value))


changeHandler : Config msg -> Maybe (Html.Attribute msg)
changeHandler (Config { onInput }) =
    Maybe.map
        (\handler ->
            Html.Events.on "MDCSlider:input"
                (Decode.map handler (Decode.at [ "detail", "value" ] Decode.float))
        )
        onInput


inputElt : Config msg -> Html msg
inputElt config_ =
    Html.input
        [ inputCs
        , rangeTypeAttr
        , minAttr config_
        , maxAttr config_
        , valueAttr config_
        , stepAttr config_
        ]
        []


inputCs : Html.Attribute msg
inputCs =
    class "mdc-slider__input"


rangeTypeAttr : Html.Attribute msg
rangeTypeAttr =
    Html.Attributes.type_ "range"


minAttr : Config msg -> Html.Attribute msg
minAttr (Config { min }) =
    Html.Attributes.min (String.fromFloat min)


maxAttr : Config msg -> Html.Attribute msg
maxAttr (Config { max }) =
    Html.Attributes.max (String.fromFloat max)


valueAttr : Config msg -> Html.Attribute msg
valueAttr (Config { min, max, value }) =
    let
        normalizedValue =
            if min < max then
                clamp min max value

            else
                min
    in
    Html.Attributes.attribute "value" (String.fromFloat normalizedValue)


stepAttr : Config msg -> Html.Attribute msg
stepAttr (Config { step }) =
    Html.Attributes.step (String.fromFloat step)


trackElt : Html msg
trackElt =
    Html.div [ class "mdc-slider__track" ]
        [ trackInactiveElt
        , trackActiveElt
        , trackActiveFillElt
        ]


trackInactiveElt : Html msg
trackInactiveElt =
    Html.div [ class "mdc-slider__track--inactive" ] []


trackActiveElt : Html msg
trackActiveElt =
    Html.div [ class "mdc-slider__track--active" ] []


trackActiveFillElt : Html msg
trackActiveFillElt =
    Html.div [ class "mdc-slider__track--active_fill" ] []


trackMarkerContainerElt : Html msg
trackMarkerContainerElt =
    Html.div [ class "mdc-slider__track-marker-container" ] []


thumbElt : Config msg -> Html msg
thumbElt ((Config { discrete }) as config_) =
    Html.div [ class "mdc-slider__thumb" ]
        (List.concat
            [ if discrete then
                [ valueIndicatorContainerElt config_ ]

              else
                []
            , [ thumbKnobElt ]
            ]
        )


thumbKnobElt : Html msg
thumbKnobElt =
    Html.div [ class "mdc-slider__thumb-knob" ] []


valueIndicatorContainerElt : Config msg -> Html msg
valueIndicatorContainerElt config_ =
    Html.div
        [ class "mdc-slider__value-indicator-container"
        , ariaHidden
        ]
        [ valueIndicatorElt config_ ]


ariaHidden : Html.Attribute msg
ariaHidden =
    Html.Attributes.attribute "aria-hidden" "true"


valueIndicatorElt : Config msg -> Html msg
valueIndicatorElt config_ =
    Html.div [ class "mdc-slider__value-indicator" ]
        [ valueIndicatorTextElt config_ ]


valueIndicatorTextElt : Config msg -> Html msg
valueIndicatorTextElt (Config { value }) =
    Html.span [ class "mdc-slider__value-indicator-text" ]
        [ text (String.fromFloat value) ]


tickMarksElt : Config msg -> Html msg
tickMarksElt ((Config { step, min, max, value }) as config_) =
    let
        n =
            ceiling ((max - min) / Basics.max 1 step)
    in
    Html.div [ class "mdc-slider__tick-marks" ]
        (List.map (\k -> tickMarkElt (value <= min + toFloat (k * n)))
            (List.range 0 n)
        )


tickMarkElt : Bool -> Html msg
tickMarkElt isActive =
    Html.div
        [ class
            (if isActive then
                "mdc-slider__tick-mark--active"

             else
                "mdc-slider__tick-mark--inactive"
            )
        ]
        []
