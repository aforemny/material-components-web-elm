module Material.Ripple exposing
    ( boundedRipple, rippleConfig, RippleConfig
    , unboundedRipple
    , RippleColor(..)
    )

{-| Material “ink ripple” interaction effect.

Ripples come in two variants. Use `ripple` for bounded ripple effects which
work best when used for contained surfaces, and `unboundedRipple` for unbounded
ripple effects which work best with icons.


# Table of Contents

  - [Resources](#resources)
  - [Basic Usage](#basic-usage)
  - [Bounded Ripple](#bounded-ripple)
  - [Unbounded Ripple](#unbounded-ripple)
  - [Colored Ripple](#colored-ripple)


# Resources

  - [Demo: Ripples](https://aforemny.github.io/material-components-web-elm/#ripples)
  - [Material Design Guidelines: States](https://material.io/go/design-states)
  - [MDC Web: Ripple](https://github.com/material-components/material-components-web/tree/master/packages/mdc-ripple)
  - [Sass Mixins (MDC Web)](https://github.com/material-components/material-components-web/tree/master/packages/mdc-ripple#sass-apis)


# Basic Usage

    import Material.Ripple exposing (ripple, rippleConfig)

    main =
        Html.div []
            [ text "Click me!"
            , boundedRipple rippleConfig
            ]


# Bounded Ripple

@docs boundedRipple, rippleConfig, RippleConfig


# Unbounded Ripple

    Html.span []
        [ unboundedRipple rippleConfig
        , text "🙌"
        ]

@docs unboundedRipple


# Colored Ripple

If you want to set the ripple effect to either primary or secondary color, set
its color configuration field to a RippleColor.

    ripple { rippleConfig | color = Ripple.PrimaryColor }

@docs RippleColor

-}

import Html exposing (Html, text)
import Html.Attributes exposing (class)
import Json.Encode as Encode


{-| Ripple configuration
-}
type alias RippleConfig msg =
    { color : Maybe RippleColor
    , additionalAttributes : List (Html.Attribute msg)
    }


{-| Default ripple configuration
-}
rippleConfig : RippleConfig msg
rippleConfig =
    { color = Nothing
    , additionalAttributes = []
    }


{-| Ripple color
-}
type RippleColor
    = PrimaryColor
    | AccentColor


{-| Bounded ripple variant
-}
ripple : Bool -> RippleConfig msg -> Html msg
ripple unbounded config =
    Html.node "mdc-ripple"
        (List.filterMap identity
            [ unboundedProp unbounded
            , unboundedData unbounded
            , colorCs config
            , rippleSurface
            , Just (Html.Attributes.style "position" "absolute")
            , Just (Html.Attributes.style "top" "0")
            , Just (Html.Attributes.style "left" "0")
            , Just (Html.Attributes.style "right" "0")
            , Just (Html.Attributes.style "bottom" "0")
            ]
            ++ config.additionalAttributes
        )
        []


{-| Bounded ripple variant
-}
boundedRipple : RippleConfig msg -> Html msg
boundedRipple =
    ripple False


{-| Unbounded ripple variant
-}
unboundedRipple : RippleConfig msg -> Html msg
unboundedRipple =
    ripple True


rippleSurface : Maybe (Html.Attribute msg)
rippleSurface =
    Just (class "mdc-ripple-surface")


colorCs : RippleConfig msg -> Maybe (Html.Attribute msg)
colorCs { color } =
    case color of
        Just PrimaryColor ->
            Just (class "mdc-ripple-surface--primary")

        Just AccentColor ->
            Just (class "mdc-ripple-surface--accent")

        Nothing ->
            Nothing


unboundedProp : Bool -> Maybe (Html.Attribute msg)
unboundedProp unbounded =
    Just (Html.Attributes.property "unbounded" (Encode.bool unbounded))


unboundedData : Bool -> Maybe (Html.Attribute msg)
unboundedData unbounded =
    if unbounded then
        Just (Html.Attributes.attribute "data-mdc-ripple-is-unbounded" "")

    else
        Nothing
