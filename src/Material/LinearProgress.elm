module Material.LinearProgress exposing
    ( Config, config
    , setClosed
    , setAttributes
    , indeterminate
    , determinate
    , buffered
    )

{-| Linear progress indicators visualize the linear progression of either
determinate or indeterminate activities.


# Table of Contents

  - [Resources](#resources)
  - [Basic Usage](#basic-usage)
  - [Configuration](#configuration)
      - [Configuration Options](#configuration-options)
  - [Indeterminate Linear Progress](#indeterminate-linear-progress)
  - [Determinate Linear Progress](#determinate-linear-progress)
  - [Buffered Linear Progress](#buffered-linear-progress)
  - [Closed Linear Progress](#closed-linear-progress)
  - [RTL Localization](#rtl-localization)


# Resources

  - [Demo: Linear Progress](https://aforemny.github.io/material-components-web-elm/#linear-progress)
  - [Material Design Guidelines: Progress indicators](https://material.io/go/design-progress-indicators)
  - [MDC Web: Linear Progress](https://github.com/material-components/material-components-web/tree/master/packages/mdc-linear-progress)
  - [Sass Mixins (MDC Web)](https://github.com/material-components/material-components-web/tree/master/packages/mdc-linear-progress#sass-mixins)


# Basic Usage

    import Material.LinearProgress as LinearProgress

    main =
        LinearProgress.indeterminate LinearProgress.config


# Configuration

@docs Config, config


## Configuration Options

@docs setClosed
@docs setAttributes


# Indeterminate Linear Progress

@docs indeterminate


# Determinate Linear Progress

    LinearProgress.determinate LinearProgress.config
        { progress = 0.5 }

@docs determinate


## Buffered Linear Progress

    LinearProgress.buffered LinearProgress.config
        { progress = 0.5, buffered = 0.75 }

@docs buffered


# Closed Linear Progress

If you want to hide the linear progress indicator, set its `setClosed`
configuration option to `True`.

    LinearProgress.indeterminate
        (LinearProgress.config |> LinearProgress.setClosed True)


# RTL Localization

The linear progress indicator follows the direction that text flows, as
indicated by (the nearest anchestor's) `rtl` attribute.

To override that value, you may specify `Html.Attributes.dir "rtl"` (or `"ltr")
in`setAttributes\`.

-}

import Html exposing (Html)
import Html.Attributes exposing (class, style)
import Json.Encode as Encode


{-| Linear progress configuration
-}
type Config msg
    = Config
        { closed : Bool
        , additionalAttributes : List (Html.Attribute msg)
        }


type Variant
    = Indeterminate
    | Determinate Float
    | Buffered Float Float


{-| Default linear progress configuration
-}
config : Config msg
config =
    Config
        { closed = False
        , additionalAttributes = []
        }


{-| Specify whether a linear progress indicator should be hidden
-}
setClosed : Bool -> Config msg -> Config msg
setClosed closed (Config config_) =
    Config { config_ | closed = closed }


{-| Specify additional attributes
-}
setAttributes : List (Html.Attribute msg) -> Config msg -> Config msg
setAttributes additionalAttributes (Config config_) =
    Config { config_ | additionalAttributes = additionalAttributes }


linearProgress : Variant -> Config msg -> Html msg
linearProgress variant ((Config { additionalAttributes }) as config_) =
    Html.node "mdc-linear-progress"
        (List.filterMap identity
            [ rootCs
            , displayCss
            , roleAttr
            , variantCs variant
            , determinateProp variant
            , progressProp variant
            , bufferProp variant
            , closedProp config_
            ]
            ++ additionalAttributes
        )
        [ bufferElt
        , primaryBarElt
        , secondaryBarElt
        ]


{-| Indeterminate linear progress variant
-}
indeterminate : Config msg -> Html msg
indeterminate config_ =
    linearProgress Indeterminate config_


{-| Determinate linear progress variant
-}
determinate : Config msg -> { progress : Float } -> Html msg
determinate config_ { progress } =
    linearProgress (Determinate progress) config_


{-| Buffered linear progress variant
-}
buffered : Config msg -> { progress : Float, buffered : Float } -> Html msg
buffered config_ data =
    linearProgress (Buffered data.progress data.buffered) config_


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


determinateProp : Variant -> Maybe (Html.Attribute msg)
determinateProp variant =
    Just
        (Html.Attributes.property "determinate"
            (Encode.bool (variant /= Indeterminate))
        )


progressProp : Variant -> Maybe (Html.Attribute msg)
progressProp variant =
    Just
        (Html.Attributes.property "progress"
            (Encode.float
                (case variant of
                    Determinate progress ->
                        progress

                    Buffered progress _ ->
                        progress

                    _ ->
                        0
                )
            )
        )


bufferProp : Variant -> Maybe (Html.Attribute msg)
bufferProp variant =
    Just
        (Html.Attributes.property "buffer"
            (Encode.float
                (case variant of
                    Buffered _ buffer ->
                        buffer

                    _ ->
                        1
                )
            )
        )


closedProp : Config msg -> Maybe (Html.Attribute msg)
closedProp (Config { closed }) =
    Just (Html.Attributes.property "closed" (Encode.bool closed))


bufferElt : Html msg
bufferElt =
    Html.div [ class "mdc-linear-progress__buffer" ]
        [ bufferBarElt
        , bufferDotsElt
        ]


bufferBarElt : Html msg
bufferBarElt =
    Html.div [ class "mdc-linear-progress__buffer-bar" ] []


bufferDotsElt : Html msg
bufferDotsElt =
    Html.div [ class "mdc-linear-progress__buffer-dots" ] []


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
