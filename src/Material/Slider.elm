module Material.Slider exposing
    ( Config, config
    , setOnChange
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
                |> Slider.setOnChange ValueChanged
            )


# Configurations

@docs Config, config


## Configuration Options

@docs setOnChange
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
            |> Slider.setMin (Just 0)
            |> Slider.setMax (Just 100)
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

import Html exposing (Html)
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
        , min : Maybe Float
        , max : Maybe Float
        , step : Maybe Float
        , value : Maybe Float
        , disabled : Bool
        , additionalAttributes : List (Html.Attribute msg)
        , onChange : Maybe (Float -> msg)
        }


{-| Default configuration of a slider
-}
config : Config msg
config =
    Config
        { discrete = False
        , displayMarkers = False
        , min = Nothing
        , max = Nothing
        , step = Nothing
        , value = Nothing
        , disabled = False
        , additionalAttributes = []
        , onChange = Nothing
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
setMin : Maybe Float -> Config msg -> Config msg
setMin min (Config config_) =
    Config { config_ | min = min }


{-| Specify a slider's maximum value
-}
setMax : Maybe Float -> Config msg -> Config msg
setMax max (Config config_) =
    Config { config_ | max = max }


{-| Specify a slider's step value
-}
setStep : Maybe Float -> Config msg -> Config msg
setStep step (Config config_) =
    Config { config_ | step = step }


{-| Specify a slider's value
-}
setValue : Maybe Float -> Config msg -> Config msg
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
setOnChange : (Float -> msg) -> Config msg -> Config msg
setOnChange onChange (Config config_) =
    Config { config_ | onChange = Just onChange }


{-| Slider view function
-}
slider : Config msg -> Html msg
slider ((Config { additionalAttributes }) as config_) =
    Html.node "mdc-slider"
        (List.filterMap identity
            [ rootCs
            , displayCss
            , discreteCs config_
            , displayMarkersCs config_
            , tabIndexProp
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
        [ trackContainerElt
        , thumbContainerElt config_
        ]


rootCs : Maybe (Html.Attribute msg)
rootCs =
    Just (class "mdc-slider")


displayCss : Maybe (Html.Attribute msg)
displayCss =
    Just (style "display" "block")


discreteCs : Config msg -> Maybe (Html.Attribute msg)
discreteCs (Config { discrete }) =
    if discrete then
        Just (class "mdc-slider--discrete")

    else
        Nothing


displayMarkersCs : Config msg -> Maybe (Html.Attribute msg)
displayMarkersCs (Config { discrete, displayMarkers }) =
    if discrete && displayMarkers then
        Just (class "mdc-slider--display-markers")

    else
        Nothing


tabIndexProp : Maybe (Html.Attribute msg)
tabIndexProp =
    Just (Html.Attributes.tabindex 0)


sliderRoleAttr : Maybe (Html.Attribute msg)
sliderRoleAttr =
    Just (Html.Attributes.attribute "role" "slider")


valueProp : Config msg -> Maybe (Html.Attribute msg)
valueProp (Config { value }) =
    Maybe.map (Html.Attributes.property "value" << Encode.float) value


minProp : Config msg -> Maybe (Html.Attribute msg)
minProp (Config { min }) =
    Maybe.map (Html.Attributes.property "min" << Encode.float) min


maxProp : Config msg -> Maybe (Html.Attribute msg)
maxProp (Config { max }) =
    Maybe.map (Html.Attributes.property "max" << Encode.float) max


stepProp : Config msg -> Maybe (Html.Attribute msg)
stepProp (Config { step }) =
    Maybe.map (Html.Attributes.property "step" << Encode.float) step


disabledProp : Config msg -> Maybe (Html.Attribute msg)
disabledProp (Config { disabled }) =
    Just (Html.Attributes.property "disabled" (Encode.bool disabled))


ariaValueMinAttr : Config msg -> Maybe (Html.Attribute msg)
ariaValueMinAttr (Config { min }) =
    Maybe.map (Html.Attributes.attribute "aria-valuemin" << String.fromFloat) min


ariaValueMaxAttr : Config msg -> Maybe (Html.Attribute msg)
ariaValueMaxAttr (Config { max }) =
    Maybe.map (Html.Attributes.attribute "aria-valuemax" << String.fromFloat) max


ariaValuenowAttr : Config msg -> Maybe (Html.Attribute msg)
ariaValuenowAttr (Config { value }) =
    Maybe.map (Html.Attributes.attribute "aria-valuenow" << String.fromFloat) value


changeHandler : Config msg -> Maybe (Html.Attribute msg)
changeHandler (Config { onChange }) =
    Maybe.map
        (\handler ->
            Html.Events.on "MDCSlider:change"
                (Decode.map handler (Decode.at [ "target", "value" ] Decode.float))
        )
        onChange


trackContainerElt : Html msg
trackContainerElt =
    Html.div [ class "mdc-slider__track-container" ] [ trackElt, trackMarkerContainerElt ]


trackElt : Html msg
trackElt =
    Html.div [ class "mdc-slider__track" ] []


trackMarkerContainerElt : Html msg
trackMarkerContainerElt =
    Html.div [ class "mdc-slider__track-marker-container" ] []


thumbContainerElt : Config msg -> Html msg
thumbContainerElt (Config { discrete }) =
    Html.div [ class "mdc-slider__thumb-container" ]
        (if discrete then
            [ pinElt, thumbElt, focusRingElt ]

         else
            [ thumbElt, focusRingElt ]
        )


pinElt : Html msg
pinElt =
    Html.div [ class "mdc-slider__pin" ] [ pinValueMarkerElt ]


pinValueMarkerElt : Html msg
pinValueMarkerElt =
    Html.div [ class "mdc-slider__pin-value-marker" ] []


thumbElt : Html msg
thumbElt =
    Svg.svg
        [ Svg.Attributes.class "mdc-slider__thumb"
        , Svg.Attributes.width "21"
        , Svg.Attributes.height "21"
        ]
        [ Svg.circle
            [ Svg.Attributes.cx "10.5"
            , Svg.Attributes.cy "10.5"
            , Svg.Attributes.r "7.875"
            ]
            []
        ]


focusRingElt : Html msg
focusRingElt =
    Html.div [ class "mdc-slider__focus-ring" ] []
