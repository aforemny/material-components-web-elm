module Material.Slider exposing (slider, sliderConfig, SliderConfig)

{-| MDC Slider provides an implementation of the Material Design slider
component.


# Table of Contents

  - [Resources](#resources)
  - [Basic Usage](#basic-usage)
  - [Continuous Slider](#continuous-slider)
  - [Custom range values](#using-a-step-value)
  - [Using a step value](#using-a-step-value)
  - [Disabled Slider](#disabled-slider)
  - [Discrete Slider](#discrete-slider)
      - [Track Markers](#track-markers)


# Resources

  - [Demo: Sliders](https://aforemny.github.io/material-components-web-elm/#sliders)
  - [Material Design Guidelines: Sliders](https://material.io/go/design-sliders)
  - [MDC Web: Slider](https://github.com/material-components/material-components-web/tree/master/packages/mdc-slider)
  - [Sass Mixins (MDC Web)](https://github.com/material-components/material-components-web/tree/master/packages/mdc-slider#sass-mixins)


# Basic Usage

    import Material.Slider exposing (slider, sliderConfig)

    type Msg
        = ValueChanged Float

    main =
        slider
            { sliderConfig
                | value = 50
                , onChange = Just ValueChanged
            }


# Continuous Slider

@docs slider, sliderConfig, SliderConfig


# Custom range values

To set a custom range, set the slider's `min` and `max` configuration fields to
a `Float`.

    slider { sliderConfig | min = 0, max = 100 }


# Using a step value

To allow for quantization of the user input, set the slider's `step`
configuration field to a `Float`.

    slider { sliderConfig | step = 4.5 }


# Disabled Slider

To disable a slider, set its `disabled` configuration field to `True`. Disabled
sliders cannot be interacted with and have no visual interaction effect.

    slider { sliderConfig | disabled = True }


# Discrete Slider

To treat a slider as a discrete slider, set its `discrete` configuration field
to `True`.

    slider { sliderConfig | disabled = True }


## Track Markers

To have a discrete slider show track markers, set its `displayMarkers`
configuration field to `True`.

    slider { sliderConfig | displayMarkers = True }

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
type alias SliderConfig msg =
    { discrete : Bool
    , displayMarkers : Bool
    , min : Float
    , max : Float
    , step : Float
    , value : Float
    , disabled : Bool
    , additionalAttributes : List (Html.Attribute msg)
    , onChange : Maybe (Float -> msg)
    }


{-| Default configuration of a slider
-}
sliderConfig : SliderConfig msg
sliderConfig =
    { discrete = False
    , displayMarkers = False
    , min = 0
    , max = 100
    , step = 0
    , value = 0
    , disabled = False
    , additionalAttributes = []
    , onChange = Nothing
    }


{-| Slider view function
-}
slider : SliderConfig msg -> Html msg
slider config =
    Html.node "mdc-slider"
        (List.filterMap identity
            [ rootCs
            , displayCss
            , discreteCs config
            , displayMarkersCs config
            , tabIndexProp
            , sliderRoleAttr
            , valueProp config
            , minProp config
            , maxProp config
            , stepProp config
            , disabledProp config
            , ariaValueMinAttr config
            , ariaValueMaxAttr config
            , ariaValuenowAttr config
            , changeHandler config
            ]
            ++ config.additionalAttributes
        )
        [ trackContainerElt
        , thumbContainerElt config
        ]


rootCs : Maybe (Html.Attribute msg)
rootCs =
    Just (class "mdc-slider")


displayCss : Maybe (Html.Attribute msg)
displayCss =
    Just (style "display" "block")


discreteCs : SliderConfig msg -> Maybe (Html.Attribute msg)
discreteCs { discrete } =
    if discrete then
        Just (class "mdc-slider--discrete")

    else
        Nothing


displayMarkersCs : SliderConfig msg -> Maybe (Html.Attribute msg)
displayMarkersCs { discrete, displayMarkers } =
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


valueProp : SliderConfig msg -> Maybe (Html.Attribute msg)
valueProp { value } =
    Just (Html.Attributes.property "value" (Encode.float value))


minProp : SliderConfig msg -> Maybe (Html.Attribute msg)
minProp { min } =
    Just (Html.Attributes.property "min" (Encode.float min))


maxProp : SliderConfig msg -> Maybe (Html.Attribute msg)
maxProp { max } =
    Just (Html.Attributes.property "max" (Encode.float max))


stepProp : SliderConfig msg -> Maybe (Html.Attribute msg)
stepProp { step } =
    Just (Html.Attributes.property "step" (Encode.float step))


disabledProp : SliderConfig msg -> Maybe (Html.Attribute msg)
disabledProp { disabled } =
    Just (Html.Attributes.property "disabled" (Encode.bool disabled))


ariaValueMinAttr : SliderConfig msg -> Maybe (Html.Attribute msg)
ariaValueMinAttr { min } =
    Just (Html.Attributes.attribute "aria-valuemin" (String.fromFloat min))


ariaValueMaxAttr : SliderConfig msg -> Maybe (Html.Attribute msg)
ariaValueMaxAttr { max } =
    Just (Html.Attributes.attribute "aria-valuemax" (String.fromFloat max))


ariaValuenowAttr : SliderConfig msg -> Maybe (Html.Attribute msg)
ariaValuenowAttr { value } =
    Just (Html.Attributes.attribute "aria-valuenow" (String.fromFloat value))


changeHandler : SliderConfig msg -> Maybe (Html.Attribute msg)
changeHandler config =
    Maybe.map
        (\handler ->
            Html.Events.on "MDCSlider:change"
                (Decode.map handler (Decode.at [ "target", "value" ] Decode.float))
        )
        config.onChange


trackContainerElt : Html msg
trackContainerElt =
    Html.div [ class "mdc-slider__track-container" ] [ trackElt, trackMarkerContainerElt ]


trackElt : Html msg
trackElt =
    Html.div [ class "mdc-slider__track" ] []


trackMarkerContainerElt : Html msg
trackMarkerContainerElt =
    Html.div [ class "mdc-slider__track-marker-container" ] []


thumbContainerElt : SliderConfig msg -> Html msg
thumbContainerElt { discrete } =
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
