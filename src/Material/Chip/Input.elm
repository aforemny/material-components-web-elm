module Material.Chip.Input exposing
    ( Config, config
    , setOnClick
    , setOnTrailingIconClick
    , setIcon
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
@docs setAttributes


# Input Chips

@docs set, chip, Chip

-}

import Html exposing (Html, text)
import Html.Attributes exposing (class)
import Html.Events
import Json.Decode as Decode
import Json.Encode as Encode
import Svg
import Svg.Attributes


{-| Input chip container
-}
set : List (Html.Attribute msg) -> List (Chip msg) -> Html msg
set additionalAttributes chips =
    Html.node "mdc-chip-set"
        (chipSetRootCs :: inputCs :: additionalAttributes)
        (List.map (\(Chip html) -> html) chips)


{-| Configuration of an input chip
-}
type Config msg
    = Config
        { icon : String
        , additionalAttributes : List (Html.Attribute msg)
        , onClick : Maybe msg
        , onTrailingIconClick : Maybe msg
        }


{-| Default configuration of an input chip
-}
config : Config msg
config =
    Config
        { icon = "close"
        , additionalAttributes = []
        , onClick = Nothing
        , onTrailingIconClick = Nothing
        }


{-| Specify whether a chip displays an icon
-}
setIcon : String -> Config msg -> Config msg
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


{-| Input chip type
-}
type Chip msg
    = Chip (Html msg)


{-| Input chip view function
-}
chip : Config msg -> String -> Chip msg
chip ((Config { additionalAttributes }) as config_) label =
    Chip <|
        Html.node "mdc-chip"
            (List.filterMap identity
                [ chipRootCs
                , clickHandler config_
                , trailingIconClickHandler config_
                ]
                ++ additionalAttributes
            )
            [ textElt label
            , trailingIconElt config_
            ]


chipRootCs : Maybe (Html.Attribute msg)
chipRootCs =
    Just (class "mdc-chip")


clickHandler : Config msg -> Maybe (Html.Attribute msg)
clickHandler (Config { onClick }) =
    Maybe.map (Html.Events.on "MDCChip:interaction" << Decode.succeed) onClick


textElt : String -> Html msg
textElt label =
    Html.div [ class "mdc-chip__text" ] [ text label ]


trailingIconClickHandler : Config msg -> Maybe (Html.Attribute msg)
trailingIconClickHandler (Config { onTrailingIconClick }) =
    Maybe.map (Html.Events.on "MDCChip:trailingIconInteraction" << Decode.succeed)
        onTrailingIconClick


trailingIconElt : Config msg -> Html msg
trailingIconElt (Config { icon }) =
    Html.i
        [ class "material-icons mdc-chip__icon mdc-chip__icon--trailing" ]
        [ text icon ]


chipSetRootCs : Html.Attribute msg
chipSetRootCs =
    class "mdc-chip-set"


inputCs : Html.Attribute msg
inputCs =
    class "mdc-chip-set--input"
