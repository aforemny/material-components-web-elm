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

{-| MDC Slider provides an implementation of the Material Design slider
component.


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
                |> Slider.setValue 50
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
            |> Slider.setMin 0
            |> Slider.setMax 100
        )


# Using a step value

To allow for quantization of the user input, use the slider's `setStep`
configuration option.

    Slider.slider
        (Slider.config
            |> Slider.setStep 4.5
        )


# Disabled Slider

To disable a slider, use its `setDisabled` configuration option. Disabled
sliders cannot be interacted with and have no visual interaction effect.

    Slider.slider
        (Slider.config
            |> Slider.setDisabled True
        )


# Discrete Slider

To treat a slider as a discrete slider, use its `setDiscrete` configuration
option.

    Slider.slider
        (Slider.config
            |> Slider.setDiscrete True
        )


## Track Markers

To have a discrete slider show track markers, use its `setDisplayMarkers`
configuration option.

    Slider.slider
        (Slider.config
            |> Slider.setDisplayMarkers True
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
        , onChange : Maybe (Float -> msg)
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
        , step = 0
        , value = 0
        , disabled = False
        , additionalAttributes = []
        , onChange = Nothing
        }


{-| Set a slider to be a discrete slider
-}
setDiscrete : Bool -> Config msg -> Config msg
setDiscrete discrete (Config config_) =
    Config { config_ | discrete = discrete }


{-| Set a discrete slider to display track markers
-}
setDisplayMarkers : Bool -> Config msg -> Config msg
setDisplayMarkers displayMarkers (Config config_) =
    Config { config_ | displayMarkers = displayMarkers }


{-| Set a slider's minimum value (default: 0)
-}
setMin : Float -> Config msg -> Config msg
setMin min (Config config_) =
    Config { config_ | min = min }


{-| Set a slider's maximum value (default: 100)
-}
setMax : Float -> Config msg -> Config msg
setMax max (Config config_) =
    Config { config_ | max = max }


{-| Set a slider's step value (default: 0)
-}
setStep : Float -> Config msg -> Config msg
setStep step (Config config_) =
    Config { config_ | step = step }


{-| Set a slider's value (default: 0)
-}
setValue : Float -> Config msg -> Config msg
setValue value (Config config_) =
    Config { config_ | value = value }


{-| Make a slider disabled
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
