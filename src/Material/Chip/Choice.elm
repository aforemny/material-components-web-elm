module Material.Chip.Choice exposing
    ( Config, config
    , setOnClick
    , setIcon
    , setSelected
    , setTouch
    , setAttributes
    , set, chip, Chip
    )

{-| Chips are compact elements that allow users to enter information, select a
choice, filter content, or trigger an action.

Choice chips are a variant of chips which allow single selection from a set of
options.


# Table of Contents

  - [Resources](#resources)
  - [Basic Usage](#basic-usage)
  - [Configuration](#configuration)
      - [Configuration Options](#configuration-options)
  - [Choice Chips](#choice-chips)
  - [Touch Support](#touch-support)


# Resources

  - [Demo: Chips](https://aforemny.github.io/material-components-web-elm/#chips)
  - [Material Design Guidelines: Chips](https://material.io/go/design-chips)
  - [MDC Web: Chips](https://github.com/material-components/material-components-web/tree/master/packages/mdc-chips)
  - [Sass Mixins (MDC Web)](https://github.com/material-components/material-components-web/tree/master/packages/mdc-chips#sass-mixins)


# Basic Usage

    import Material.Chip.Choice as ChoiceChip

    type Msg
        = ChipClicked String

    main =
        ChoiceChip.set []
            [ ChoiceChip.chip
                (ChoiceChip.config
                    |> ChoiceChip.setSelected True
                    |> ChoiceChip.setOnClick (ChipClicked "One")
                )
                "Chip One"
            , ChoiceChip.chip
                (ChoiceChip.config
                    |> ChoiceChip.setOnClick (ChipClicked "Two")
                )
                "Chip Two"
            ]


# Configuration

@docs Config, config


## Configuration Options

@docs setOnClick
@docs setIcon
@docs setSelected
@docs setTouch
@docs setAttributes


# Choice Chips

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
import Json.Encode as Encode


{-| Choice chip container
-}
set : List (Html.Attribute msg) -> List (Chip msg) -> Html msg
set additionalAttributes chips =
    Html.node "mdc-chip-set"
        (chipSetRootCs :: choiceCs :: additionalAttributes)
        (List.map (\(Chip html) -> html) chips)


{-| Configuration of a choice chip
-}
type Config msg
    = Config
        { icon : Maybe String
        , selected : Bool
        , additionalAttributes : List (Html.Attribute msg)
        , onClick : Maybe msg
        , touch : Bool
        }


{-| Default configuration of a choice chip
-}
config : Config msg
config =
    Config
        { icon = Nothing
        , selected = False
        , additionalAttributes = []
        , onClick = Nothing
        , touch = True
        }


{-| Specify whether the chip displays an icon
-}
setIcon : Maybe String -> Config msg -> Config msg
setIcon icon (Config config_) =
    Config { config_ | icon = icon }


{-| Specify whether a chip is selected
-}
setSelected : Bool -> Config msg -> Config msg
setSelected selected (Config config_) =
    Config { config_ | selected = selected }


{-| Specify additional attributes
-}
setAttributes : List (Html.Attribute msg) -> Config msg -> Config msg
setAttributes additionalAttributes (Config config_) =
    Config { config_ | additionalAttributes = additionalAttributes }


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


{-| Choice chip type
-}
type Chip msg
    = Chip (Html msg)


{-| Choice chip view function
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
    Chip <|
        Html.node "mdc-chip"
            (List.filterMap identity
                [ chipRootCs
                , chipTouchCs config_
                , selectedProp config_
                , clickHandler config_
                ]
                ++ additionalAttributes
            )
            (List.filterMap identity [ textElt label, touchElt config_ ])


chipRootCs : Maybe (Html.Attribute msg)
chipRootCs =
    Just (class "mdc-chip")


chipTouchCs : Config msg -> Maybe (Html.Attribute msg)
chipTouchCs (Config { touch }) =
    if touch then
        Just (class "mdc-chip--touch")

    else
        Nothing


selectedProp : Config msg -> Maybe (Html.Attribute msg)
selectedProp (Config { selected }) =
    Just (Html.Attributes.property "selected" (Encode.bool selected))


clickHandler : Config msg -> Maybe (Html.Attribute msg)
clickHandler (Config { onClick }) =
    Maybe.map (Html.Events.on "MDCChip:interaction" << Decode.succeed) onClick


textElt : String -> Maybe (Html msg)
textElt label =
    Just (Html.div [ class "mdc-chip__text" ] [ text label ])


touchElt : Config msg -> Maybe (Html msg)
touchElt (Config { touch }) =
    if touch then
        Just (Html.div [ class "mdc-chip__touch" ] [])

    else
        Nothing


chipSetRootCs : Html.Attribute msg
chipSetRootCs =
    class "mdc-chip-set"


choiceCs : Html.Attribute msg
choiceCs =
    class "mdc-chip-set--choice"
