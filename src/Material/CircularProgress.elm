module Material.CircularProgress exposing
    ( Config, config
    , setSize
    , Size, large, medium, small
    , setFourColored
    , setClosed
    , setLabel
    , setAttributes
    , indeterminate
    , determinate
    )

{-| Circular progress indicators visualize the linear progress of either determinate or indeterminate activities.


# Table of Contents

  - [Resources](#resources)
  - [Basic Usage](#basic-usage)
  - [Configuration](#configuration)
      - [Configuration Options](#configuration-options)
  - [Indeterminate Circular Progress](#indeterminate-circular-progress)
  - [Determinate Circular Progress](#determinate-circular-progress)


# Resources

  - [Demo: Circular Progress](https://aforemny.github.io/material-components-web-elm/#circular-progress)
  - [Material Design Guidelines: Progress indicators](https://material.io/go/design-progress-indicators)
  - [MDC Web: Circular Progress](https://github.com/material-components/material-components-web/tree/master/packages/mdc-circular-progress)
  - [Sass Mixins (MDC Web)](https://github.com/material-components/material-components-web/tree/master/packages/mdc-circular-progress#sass-mixins)


# Basic Usage

    import Material.CircularProgress as CircularProgress

    main =
        CircularProgress.indeterminate CircularProgress.config


# Configuration

@docs Config, config


## Configuration Options

@docs setSize
@docs Size, large, medium, small
@docs setFourColored
@docs setClosed
@docs setLabel
@docs setAttributes


# Indeterminate Circular Progress

    CircularProgress.indeterminate CircularProgress.config

@docs indeterminate


# Determinate Circular Progress

    CircularProgress.determinate CircularProgress.config
        { progress = 0.5 }

@docs determinate

-}

import Html exposing (Html)
import Html.Attributes exposing (class, style)
import Json.Encode as Encode
import Svg exposing (Svg)
import Svg.Attributes


{-| Circular progress configuration
-}
type Config msg
    = Config
        { size : Size
        , fourColored : Bool
        , closed : Bool
        , label : Maybe String
        , additionalAttributes : List (Html.Attribute msg)
        }


{-| Default circular progress configuration
-}
config : Config msg
config =
    Config
        { size = Large
        , fourColored = False
        , closed = False
        , label = Nothing
        , additionalAttributes = []
        }


{-| Circular progress indicators sizes
-}
type Size
    = Large
    | Medium
    | Small


{-| Circular progress indicator large size (default)
-}
large : Size
large =
    Large


{-| Circular progress indicator medium size
-}
medium : Size
medium =
    Medium


{-| Circular progress indicator small size
-}
small : Size
small =
    Small


{-| Specify the size of a circular progress indicator

Large is the default size.

-}
setSize : Size -> Config msg -> Config msg
setSize size (Config config_) =
    Config { config_ | size = size }


{-| Specify whether a circular progress indicator should alternative between
four colors.

This only applies to indeterminate circular progress indicators. Note that you
have to specify the colors yourself via SASS or CSS.

-}
setFourColored : Bool -> Config msg -> Config msg
setFourColored fourColored (Config config_) =
    Config { config_ | fourColored = fourColored }


{-| Specify whether a circular progress indicator should be hidden
-}
setClosed : Bool -> Config msg -> Config msg
setClosed closed (Config config_) =
    Config { config_ | closed = closed }


{-| Specify the HTML5 aria-label attribute
-}
setLabel : Maybe String -> Config msg -> Config msg
setLabel label (Config config_) =
    Config { config_ | label = label }


{-| Specify additional attributes
-}
setAttributes : List (Html.Attribute msg) -> Config msg -> Config msg
setAttributes additionalAttributes (Config config_) =
    Config { config_ | additionalAttributes = additionalAttributes }


circularProgress : Maybe { progress : Float } -> Config msg -> Html msg
circularProgress progress ((Config { additionalAttributes }) as config_) =
    Html.node "mdc-circular-progress"
        (List.filterMap identity
            [ rootCs
            , indeterminateCs progress
            , progressbarRole
            , ariaLabelAttr config_
            , ariaValueMinAttr
            , ariaValueMaxAttr
            , ariaValueNowAttr progress
            , determinateProp progress
            , progressProp progress
            , closedProp config_
            ]
            ++ sizeCs config_
            ++ additionalAttributes
        )
        [ determinateContainerElt
            (Maybe.withDefault (Just { progress = 0 })
                (Maybe.map Just progress)
            )
            config_
        , indeterminateContainerElt config_
        ]


{-| Indeterminate variant
-}
indeterminate : Config msg -> Html msg
indeterminate config_ =
    circularProgress Nothing config_


{-| Determinate variant

The progress is specified as a `Float` between `0.0` and `1.0`.

-}
determinate : Config msg -> { progress : Float } -> Html msg
determinate config_ progress =
    circularProgress (Just progress) config_


sizeCs : Config msg -> List (Html.Attribute msg)
sizeCs (Config { size }) =
    let
        px =
            String.fromInt
                (case size of
                    Large ->
                        48

                    Medium ->
                        36

                    Small ->
                        24
                )
                ++ "px"
    in
    [ style "width" px
    , style "height" px
    ]


rootCs : Maybe (Html.Attribute msg)
rootCs =
    Just (class "mdc-circular-progress")


indeterminateCs : Maybe { progress : Float } -> Maybe (Html.Attribute msg)
indeterminateCs progress =
    if progress /= Nothing then
        Nothing

    else
        Just (class "mdc-circular-progress--indeterminate")


circleCs : Maybe { progress : Float } -> Svg.Attribute msg
circleCs progress =
    Svg.Attributes.class
        (if progress /= Nothing then
            "mdc-circular-progress__determinate-circle"

         else
            "mdc-circular-progress__indeterminate-circle"
        )


trackCs : Svg.Attribute msg
trackCs =
    Svg.Attributes.class "mdc-circular-progress__determinate-track"


progressbarRole : Maybe (Html.Attribute msg)
progressbarRole =
    Just (Html.Attributes.attribute "role" "progressbar")


ariaLabelAttr : Config msg -> Maybe (Html.Attribute msg)
ariaLabelAttr (Config { label }) =
    Maybe.map (Html.Attributes.attribute "aria-label") label


ariaValueMinAttr : Maybe (Html.Attribute msg)
ariaValueMinAttr =
    Just (Html.Attributes.attribute "aria-value-min" "0")


ariaValueMaxAttr : Maybe (Html.Attribute msg)
ariaValueMaxAttr =
    Just (Html.Attributes.attribute "aria-value-max" "1")


ariaValueNowAttr : Maybe { progress : Float } -> Maybe (Html.Attribute msg)
ariaValueNowAttr progress =
    Maybe.map
        (Html.Attributes.attribute "aria-value-now" << String.fromFloat << .progress)
        progress


determinateProp : Maybe { progress : Float } -> Maybe (Html.Attribute msg)
determinateProp progress =
    Just (Html.Attributes.property "determinate" (Encode.bool (progress /= Nothing)))


progressProp : Maybe { progress : Float } -> Maybe (Html.Attribute msg)
progressProp progress =
    Maybe.map (Html.Attributes.property "progress" << Encode.float << .progress) progress


closedProp : Config msg -> Maybe (Html.Attribute msg)
closedProp (Config { closed }) =
    Just (Html.Attributes.property "closed" (Encode.bool closed))


strokeDasharrayAttr : Config msg -> Svg.Attribute msg
strokeDasharrayAttr (Config { size }) =
    Svg.Attributes.strokeDasharray
        << String.fromFloat
    <|
        case size of
            Large ->
                113.097

            Medium ->
                78.54

            Small ->
                54.978


strokeDashoffsetAttr : Maybe { progress : Float } -> Config msg -> Svg.Attribute msg
strokeDashoffsetAttr progress (Config { size }) =
    Svg.Attributes.strokeDashoffset
        << String.fromFloat
    <|
        case ( progress, size ) of
            ( Just _, Large ) ->
                113.097

            ( Nothing, Large ) ->
                56.549

            ( Just _, Medium ) ->
                78.54

            ( Nothing, Medium ) ->
                39.27

            ( Just _, Small ) ->
                54.978

            ( Nothing, Small ) ->
                27.489


strokeWidth : Config msg -> Svg.Attribute msg
strokeWidth (Config { size }) =
    Svg.Attributes.strokeWidth
        << String.fromFloat
    <|
        case size of
            Large ->
                4

            Medium ->
                3

            Small ->
                2.5


strokeWidthGap : Config msg -> Svg.Attribute msg
strokeWidthGap (Config { size }) =
    Svg.Attributes.strokeWidth
        << String.fromFloat
    <|
        case size of
            Large ->
                3.2

            Medium ->
                2.4

            Small ->
                2


determinateContainerElt : Maybe { progress : Float } -> Config msg -> Html msg
determinateContainerElt progress config_ =
    Html.div [ class "mdc-circular-progress__determinate-container" ]
        [ determinateCircleGraphicElt progress config_ ]


determinateCircleGraphicElt : Maybe { progress : Float } -> Config msg -> Html msg
determinateCircleGraphicElt progress config_ =
    Svg.svg
        [ Svg.Attributes.class "mdc-circular-progress__determinate-circle-graphic"
        , viewBoxAttr config
        ]
        [ trackElt config_
        , circleElt strokeWidth (Just circleCs) progress config_
        ]


viewBoxAttr : Config msg -> Svg.Attribute msg
viewBoxAttr (Config { size }) =
    Svg.Attributes.viewBox
        (case size of
            Large ->
                "0 0 48 48"

            Medium ->
                "0 0 32 32"

            Small ->
                "0 0 24 24"
        )


trackElt : Config msg -> Svg msg
trackElt config_ =
    Svg.circle
        [ trackCs
        , cxAttr config_
        , cyAttr config_
        , rAttr config_
        , strokeWidth config_
        ]
        []


cxAttr : Config msg -> Svg.Attribute msg
cxAttr (Config { size }) =
    Svg.Attributes.cx
        (case size of
            Large ->
                "24"

            Medium ->
                "16"

            Small ->
                "12"
        )


cyAttr : Config msg -> Svg.Attribute msg
cyAttr (Config { size }) =
    Svg.Attributes.cy
        (case size of
            Large ->
                "24"

            Medium ->
                "16"

            Small ->
                "12"
        )


rAttr : Config msg -> Svg.Attribute msg
rAttr (Config { size }) =
    Svg.Attributes.r
        (case size of
            Large ->
                "18"

            Medium ->
                "12.5"

            Small ->
                "8.75"
        )


circleElt :
    (Config msg -> Svg.Attribute msg)
    -> Maybe (Maybe { progress : Float } -> Svg.Attribute msg)
    -> Maybe { progress : Float }
    -> Config msg
    -> Svg msg
circleElt strokeWidth_ circleCs_ progress config_ =
    Svg.circle
        ([ cxAttr config_
         , cyAttr config_
         , rAttr config_
         , strokeDasharrayAttr config_
         , strokeDashoffsetAttr progress config_
         , strokeWidth_ config_
         ]
            ++ List.filterMap identity [ Maybe.map ((|>) progress) circleCs_ ]
        )
        []


indeterminateContainerElt : Config msg -> Html msg
indeterminateContainerElt ((Config { fourColored }) as config_) =
    Html.div
        [ class "mdc-circular-progress__indeterminate-container" ]
        (if fourColored then
            [ spinnerLayerElt config_ [ class "mdc-circular-progress__color-1" ]
            , spinnerLayerElt config_ [ class "mdc-circular-progress__color-2" ]
            , spinnerLayerElt config_ [ class "mdc-circular-progress__color-3" ]
            , spinnerLayerElt config_ [ class "mdc-circular-progress__color-4" ]
            ]

         else
            [ spinnerLayerElt config_ [] ]
        )


spinnerLayerElt : Config msg -> List (Html.Attribute msg) -> Html msg
spinnerLayerElt config_ additionalAttributes =
    Html.div
        (class "mdc-circular-progress__spinner-layer" :: additionalAttributes)
        [ Html.div
            [ class "mdc-circular-progress__circle-clipper"
            , class "mdc-circular-progress__circle-left"
            ]
            [ indeterminateCircleGraphicElt strokeWidth config_ ]
        , Html.div
            [ class "mdc-circular-progress__gap-patch" ]
            [ indeterminateCircleGraphicElt strokeWidthGap config_ ]
        , Html.div
            [ class "mdc-circular-progress__circle-clipper"
            , class "mdc-circular-progress__circle-right"
            ]
            [ indeterminateCircleGraphicElt strokeWidth config_ ]
        ]


indeterminateCircleGraphicElt :
    (Config msg -> Svg.Attribute msg)
    -> Config msg
    -> Html msg
indeterminateCircleGraphicElt strokeWidth_ config_ =
    Svg.svg
        [ Svg.Attributes.class "mdc-circular-progress__indeterminate-circle-graphic"
        , viewBoxAttr config_
        ]
        [ circleElt strokeWidth_ Nothing Nothing config_ ]
