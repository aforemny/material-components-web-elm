module Material.LinearProgress exposing
    ( indeterminateLinearProgress, linearProgressConfig, LinearProgressConfig
    , determinateLinearProgress
    , bufferedLinearProgress
    )

{-| Linear progress indicators visualize the linear progression of either
determinate or indeterminate activities.


# Table of Contents

  - [Resources](#resources)
  - [Basic Usage](#basic-usage)
  - [Indeterminate Linear Progress](#indeterminate-linear-progress)
  - [Determinate Linear Progress](#determinate-linear-progress)
  - [Buffered Linear Progress](#buffered-linear-progress)
  - [Closed Linear Progress](#closed-linear-progress)
  - [Reversed Linear Progress](#reversed-linear-progress)


# Resources

  - [Demo: Linear Progress](https://aforemny.github.io/material-components-web-elm/#linear-progress)
  - [Material Design Guidelines: Progress indicators](https://material.io/go/design-progress-indicators)
  - [MDC Web: Linear Progress](https://github.com/material-components/material-components-web/tree/master/packages/mdc-linear-progress)
  - [Sass Mixins (MDC Web)](https://github.com/material-components/material-components-web/tree/master/packages/mdc-linear-progress#sass-mixins)


# Basic Usage

    import Material.LinearProgress
        exposing
            ( indeterminateLinearProgress
            , linearProgressConfig
            )

    main =
        indeterminateLinearProgress linearProgressConfig


# Indeterminate Linear Progress

@docs indeterminateLinearProgress, linearProgressConfig, LinearProgressConfig


# Determinate Linear Progress

    determinateLinearProgress linearProgressConfig
        { progress = 0.5 }

@docs determinateLinearProgress


## Buffered Linear Progress

    bufferedLinearProgress linearProgressConfig
        { progress = 0.5, buffered = 0.75 }

@docs bufferedLinearProgress


# Closed Linear Progress

If you want to hide the linear progress indicator, set its closed configuration
field to True.

    indeterminateLinearProgress
        { linearProgressConfig | closed = True }


# Reverse Linear Progress

If you want to reverse the direction of the linear progress indicator, set its
reverse configuration field to True.

    indeterminateLinearProgress
        { linearProgressConfig | reverse = True }

-}

import Html exposing (Html, text)
import Html.Attributes exposing (class, style)


{-| Linear progress configuration
-}
type alias LinearProgressConfig msg =
    { reverse : Bool
    , closed : Bool
    , additionalAttributes : List (Html.Attribute msg)
    }


type Variant
    = Indeterminate
    | Determinate Float
    | Buffered Float Float


{-| Default linear progress configuration
-}
linearProgressConfig : LinearProgressConfig msg
linearProgressConfig =
    { reverse = False
    , closed = False
    , additionalAttributes = []
    }


linearProgress : Variant -> LinearProgressConfig msg -> Html msg
linearProgress variant config =
    Html.node "mdc-linear-progress"
        (List.filterMap identity
            [ rootCs
            , displayCss
            , roleAttr
            , variantCs variant
            , determinateAttr variant
            , progressAttr variant
            , bufferAttr variant
            , reverseAttr config
            , closedAttr config
            ]
            ++ config.additionalAttributes
        )
        [ bufferingDotsElt
        , bufferElt
        , primaryBarElt
        , secondaryBarElt
        ]


{-| Indeterminate linear progress variant
-}
indeterminateLinearProgress :
    LinearProgressConfig msg
    -> Html msg
indeterminateLinearProgress config =
    linearProgress Indeterminate config


{-| Determinate linear progress variant
-}
determinateLinearProgress :
    LinearProgressConfig msg
    -> { progress : Float }
    -> Html msg
determinateLinearProgress config { progress } =
    linearProgress (Determinate progress) config


{-| Buffered linear progress variant
-}
bufferedLinearProgress :
    LinearProgressConfig msg
    -> { progress : Float, buffered : Float }
    -> Html msg
bufferedLinearProgress config { progress, buffered } =
    linearProgress (Buffered progress buffered) config


rootCs : Maybe (Html.Attribute msg)
rootCs =
    Just (class "mdc-linear-progress")


displayCss : Maybe (Html.Attribute msg)
displayCss =
    Just (style "display" "block")


roleAttr : Maybe (Html.Attribute msg)
roleAttr =
    Just (Html.Attributes.attribute "role" "progressbar")


variantCs : Variant -> Maybe (Html.Attribute msg)
variantCs variant =
    case variant of
        Indeterminate ->
            Just (class "mdc-linear-progress--indeterminate")

        _ ->
            Nothing


determinateAttr : Variant -> Maybe (Html.Attribute msg)
determinateAttr variant =
    if variant /= Indeterminate then
        Just (Html.Attributes.attribute "determinate" "")

    else
        Nothing


progressAttr : Variant -> Maybe (Html.Attribute msg)
progressAttr variant =
    case variant of
        Determinate progress ->
            Just (Html.Attributes.attribute "progress" (String.fromFloat progress))

        Buffered progress _ ->
            Just (Html.Attributes.attribute "progress" (String.fromFloat progress))

        _ ->
            Nothing


bufferAttr : Variant -> Maybe (Html.Attribute msg)
bufferAttr variant =
    case variant of
        Buffered _ buffer ->
            Just (Html.Attributes.attribute "buffer" (String.fromFloat buffer))

        _ ->
            Nothing


reverseAttr : LinearProgressConfig msg -> Maybe (Html.Attribute msg)
reverseAttr { reverse } =
    if reverse then
        Just (Html.Attributes.attribute "reverse" "")

    else
        Nothing


closedAttr : LinearProgressConfig msg -> Maybe (Html.Attribute msg)
closedAttr { closed } =
    if closed then
        Just (Html.Attributes.attribute "closed" "")

    else
        Nothing


bufferingDotsElt : Html msg
bufferingDotsElt =
    Html.div [ class "mdc-linear-progress__buffering-dots" ] []


bufferElt : Html msg
bufferElt =
    Html.div [ class "mdc-linear-progress__buffer" ] []


primaryBarElt : Html msg
primaryBarElt =
    Html.div [ class "mdc-linear-progress__bar mdc-linear-progress__primary-bar" ]
        [ barInnerElt ]


secondaryBarElt : Html msg
secondaryBarElt =
    Html.div [ class "mdc-linear-progress__bar mdc-linear-progress__secondary-bar" ]
        [ barInnerElt ]


barInnerElt : Html msg
barInnerElt =
    Html.div [ class "mdc-linear-progress__bar-inner" ] []
