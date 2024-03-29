module Material.Ripple exposing
    ( Config, config
    , setColor
    , setAttributes
    , bounded
    , unbounded
    , Color, primary, accent
    )

{-| Material “ink ripple” interaction effect.


# Table of Contents

  - [Resources](#resources)
  - [Basic Usage](#basic-usage)
  - [Configuration](#configuration)
      - [Configuration Options](#configuration-options)
  - [Bounded Ripple](#bounded-ripple)
  - [Unbounded Ripple](#unbounded-ripple)
  - [Colored Ripple](#colored-ripple)


# Resources

  - [Demo: Ripples](https://aforemny.github.io/material-components-web-elm/#ripple)
  - [Material Design Guidelines: States](https://material.io/go/design-states)
  - [MDC Web: Ripple](https://github.com/material-components/material-components-web/tree/master/packages/mdc-ripple)
  - [Sass Mixins (MDC Web)](https://github.com/material-components/material-components-web/tree/master/packages/mdc-ripple#sass-apis)


# Basic Usage

Ripples come in two variants. Use `bounded` for bounded ripple effects which
work best when used for contained surfaces, and `unbounded` for unbounded
ripple effects which work best with icons.

    import Material.Ripple as Ripple

    main =
        Html.div []
            [ text "Click me!"
            , Ripple.bounded Ripple.config
            ]


# Configuration

@docs Config, config


## Configuration Options

@docs setColor
@docs setAttributes


# Bounded Ripple

@docs bounded


# Unbounded Ripple

    Html.span []
        [ text "🙌"
        , Ripple.unbounded Ripple.config
        ]

@docs unbounded


# Colored Ripple

If you want to set the ripple effect to either primary or accent color, use its
`setColor` configuration option and specify a `Color`.

    Ripple.bounded
        (Ripple.config |> Ripple.setColor (Just Ripple.primary))

@docs Color, primary, accent

-}

import Html exposing (Html)
import Html.Attributes exposing (class, style)
import Json.Encode as Encode


{-| Ripple configuration
-}
type Config msg
    = Config
        { color : Maybe Color
        , additionalAttributes : List (Html.Attribute msg)
        }


{-| Default ripple configuration
-}
config : Config msg
config =
    Config
        { color = Nothing
        , additionalAttributes = []
        }


{-| Specify a ripple effect's color
-}
setColor : Maybe Color -> Config msg -> Config msg
setColor color (Config config_) =
    Config { config_ | color = color }


{-| Specify additional attributes
-}
setAttributes : List (Html.Attribute msg) -> Config msg -> Config msg
setAttributes additionalAttributes (Config config_) =
    Config { config_ | additionalAttributes = additionalAttributes }


{-| Ripple effect's color
-}
type Color
    = Primary
    | Accent


{-| Primary variant of a ripple effect's color
-}
primary : Color
primary =
    Primary


{-| Accent variant of a ripple effect's color
-}
accent : Color
accent =
    Accent


ripple : Bool -> Config msg -> Html msg
ripple isUnbounded ((Config { additionalAttributes }) as config_) =
    Html.node "mdc-ripple"
        ((List.filterMap identity
            [ unboundedProp isUnbounded
            , unboundedData isUnbounded
            , colorCs config_
            , rippleSurfaceCs
            , pointerCss isUnbounded
            ]
            ++ positionCss
         )
            ++ additionalAttributes
        )
        []


{-| Bounded ripple view function
-}
bounded : Config msg -> Html msg
bounded =
    ripple False


{-| Unbounded ripple view function
-}
unbounded : Config msg -> Html msg
unbounded =
    ripple True


rippleSurfaceCs : Maybe (Html.Attribute msg)
rippleSurfaceCs =
    Just (class "mdc-ripple-surface")


positionCss : List (Html.Attribute msg)
positionCss =
    [ style "position" "absolute"
    , style "top" "0"
    , style "left" "0"
    , style "right" "0"
    , style "bottom" "0"
    ]


pointerCss : Bool -> Maybe (Html.Attribute msg)
pointerCss isUnbounded =
    if isUnbounded then
        Just (style "cursor" "pointer")

    else
        Nothing


colorCs : Config msg -> Maybe (Html.Attribute msg)
colorCs (Config { color }) =
    case color of
        Just Primary ->
            Just (class "mdc-ripple-surface--primary")

        Just Accent ->
            Just (class "mdc-ripple-surface--accent")

        Nothing ->
            Nothing


unboundedProp : Bool -> Maybe (Html.Attribute msg)
unboundedProp isUnbounded =
    Just (Html.Attributes.property "unbounded" (Encode.bool isUnbounded))


unboundedData : Bool -> Maybe (Html.Attribute msg)
unboundedData isUnbounded =
    if isUnbounded then
        Just (Html.Attributes.attribute "data-mdc-ripple-is-unbounded" "")

    else
        Nothing
