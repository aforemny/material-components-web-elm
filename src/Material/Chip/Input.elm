module Material.Chip.Input exposing
    ( Config, config
    , setOnClick
    , setOnTrailingIconClick
    , setIcon
    , setTouch
    , setAttributes
    , set, chip, Chip
    )

{-| Chips are compact elements that allow users to enter information, select a
choice, filter content, or trigger an action.

Input chips are a variant of chips which enable user input by converting text
into chips.


# Table of Contents

  - [Resources](#resources)
  - [Basic Usage](#basic-usage)
  - [Configuration](#configuration)
      - [Configuration Options](#configuration-options)
  - [Input Chips](#input-chips)
  - [Touch Support](#touch-support)


# Resources

  - [Demo: Chips](https://aforemny.github.io/material-components-web-elm/#chips)
  - [Material Design Guidelines: Chips](https://material.io/go/design-chips)
  - [MDC Web: Chips](https://github.com/material-components/material-components-web/tree/master/packages/mdc-chips)
  - [Sass Mixins (MDC Web)](https://github.com/material-components/material-components-web/tree/master/packages/mdc-chips#sass-mixins)


# Basic Usage

    import Material.Chip.Input as InputChip

    type Msg
        = ChipSelected String

    main =
        InputChip.set []
            [ InputChip.chip InputChip.config "Chip One"
            , InputChip.chip InputChip.config "Chip Two"
            ]


# Configuration

@docs Config, config


## Configuration Options

@docs setOnClick
@docs setOnTrailingIconClick
@docs setIcon
@docs setTouch
@docs setAttributes


# Input Chips

@docs set, chip, Chip


# Touch Support

Touch support is enabled by default. To disable touch support set a chip's `setTouch` configuration option to `False`.

    Chip.chip
        (Chip.config |> Chip.setTouch False)
        "Chip"

-}

import Html exposing (Html, text)
import Html.Attributes exposing (class)
import Html.Events
import Json.Decode as Decode


{-| Input chip container
-}
set : List (Html.Attribute msg) -> List (Chip msg) -> Html msg
set additionalAttributes chips =
    Html.node "mdc-chip-set"
        (chipSetCs :: chipSetInputCs :: gridRole :: additionalAttributes)
        (List.map (\(Chip html) -> html) chips)


{-| Configuration of an input chip
-}
type Config msg
    = Config
        { icon : Maybe String
        , additionalAttributes : List (Html.Attribute msg)
        , onClick : Maybe msg
        , onTrailingIconClick : Maybe msg
        , touch : Bool
        }


{-| Default configuration of an input chip
-}
config : Config msg
config =
    Config
        { icon = Nothing
        , additionalAttributes = []
        , onClick = Nothing
        , onTrailingIconClick = Nothing
        , touch = True
        }


{-| Specify whether a chip displays an icon
-}
setIcon : Maybe String -> Config msg -> Config msg
setIcon icon (Config config_) =
    Config { config_ | icon = icon }


{-| Specify additional attributes
-}
setAttributes : List (Html.Attribute msg) -> Config msg -> Config msg
setAttributes additionalAttributes (Config config_) =
    Config { config_ | additionalAttributes = additionalAttributes }


{-| Specify a message when the user clicks on a chip's trailing icon
-}
setOnTrailingIconClick : msg -> Config msg -> Config msg
setOnTrailingIconClick onTrailingIconClick (Config config_) =
    Config { config_ | onTrailingIconClick = Just onTrailingIconClick }


{-| Specify a message when the user clicks on a chip
-}
setOnClick : msg -> Config msg -> Config msg
setOnClick onClick (Config config_) =
    Config { config_ | onClick = Just onClick }


{-| Specify whether touch support is enabled (enabled by default)

Touch support is an accessibility guideline that states that touch targets
should be at least 48 x 48 pixels in size. Use this configuration option to
disable increased touch target size.

**Note:** Chips with touch support will be wrapped in a HTML div element to
prevent potentially overlapping touch targets on adjacent elements.

-}
setTouch : Bool -> Config msg -> Config msg
setTouch touch (Config config_) =
    Config { config_ | touch = touch }


{-| Input chip type
-}
type Chip msg
    = Chip (Html msg)


{-| Input chip view function
-}
chip : Config msg -> String -> Chip msg
chip ((Config { touch, additionalAttributes }) as config_) label =
    let
        wrapTouch node =
            if touch then
                Html.div [ class "mdc-touch-target-wrapper" ] [ node ]

            else
                node
    in
    Chip
        << wrapTouch
    <|
        Html.node "mdc-chip"
            (List.filterMap identity
                [ chipCs
                , chipTouchCs config_
                , rowRole
                , clickHandler config_
                , trailingIconClickHandler config_
                ]
                ++ additionalAttributes
            )
            (List.filterMap identity
                [ rippleElt
                , leadingIconElt config_
                , gridcellElt config_ label
                , trailingIconElt config_
                ]
            )


rippleElt : Maybe (Html msg)
rippleElt =
    Just (Html.div [ class "mdc-chip__ripple" ] [])


leadingIconElt : Config msg -> Maybe (Html msg)
leadingIconElt (Config { icon }) =
    Maybe.map
        (\iconName ->
            Html.i [ class "material-icons mdc-chip__icon mdc-chip__icon--leading" ]
                [ text iconName ]
        )
        icon


gridcellElt : Config msg -> String -> Maybe (Html msg)
gridcellElt config_ label =
    Just <|
        Html.span [ gridcellRole ]
            (List.filterMap identity
                [ textElt label
                , touchElt config_
                ]
            )


textElt : String -> Maybe (Html msg)
textElt label =
    Just (Html.span [ class "mdc-chip__text", buttonRole ] [ text label ])


touchElt : Config msg -> Maybe (Html msg)
touchElt (Config { touch }) =
    if touch then
        Just (Html.div [ class "mdc-chip__touch" ] [])

    else
        Nothing


trailingIconElt : Config msg -> Maybe (Html msg)
trailingIconElt (Config { icon }) =
    Just
        (Html.i
            [ class "material-icons mdc-chip__icon mdc-chip__icon--trailing" ]
            [ text (Maybe.withDefault "close" icon) ]
        )


chipCs : Maybe (Html.Attribute msg)
chipCs =
    Just (class "mdc-chip")


chipTouchCs : Config msg -> Maybe (Html.Attribute msg)
chipTouchCs (Config { touch }) =
    if touch then
        Just (class "mdc-chip--touch")

    else
        Nothing


chipSetCs : Html.Attribute msg
chipSetCs =
    class "mdc-chip-set"


chipSetInputCs : Html.Attribute msg
chipSetInputCs =
    class "mdc-chip-set--input"


rowRole : Maybe (Html.Attribute msg)
rowRole =
    Just (Html.Attributes.attribute "role" "row")


gridcellRole : Html.Attribute msg
gridcellRole =
    Html.Attributes.attribute "role" "gridcell"


gridRole : Html.Attribute msg
gridRole =
    Html.Attributes.attribute "role" "grid"


buttonRole : Html.Attribute msg
buttonRole =
    Html.Attributes.attribute "role" "button"


clickHandler : Config msg -> Maybe (Html.Attribute msg)
clickHandler (Config { onClick }) =
    Maybe.map (Html.Events.on "MDCChip:interaction" << Decode.succeed) onClick


trailingIconClickHandler : Config msg -> Maybe (Html.Attribute msg)
trailingIconClickHandler (Config { onTrailingIconClick }) =
    Maybe.map (Html.Events.on "MDCChip:trailingIconInteraction" << Decode.succeed)
        onTrailingIconClick
