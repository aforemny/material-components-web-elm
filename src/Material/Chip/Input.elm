module Material.Chip.Input exposing
    ( Config, config
    , setOnClick
    , setOnDelete
    , setLeadingIcon
    , setTrailingIcon
    , setAttributes
    , chip, Chip
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
    import Material.ChipSet.Input as InputChipSet

    type Msg
        = ChipSelected String

    main =
        InputChipSet.chipSet []
            [ InputChip.chip InputChip.config "Chip One"
            , InputChip.chip InputChip.config "Chip Two"
            ]


# Configuration

@docs Config, config


## Configuration Options

@docs setOnClick
@docs setOnDelete
@docs setLeadingIcon
@docs setTrailingIcon
@docs setAttributes


# Input Chips

@docs chip, Chip

-}

import Html
import Material.Chip.Input.Internal exposing (Chip(..), Config(..))


{-| Configuration of an input chip
-}
type alias Config msg =
    Material.Chip.Input.Internal.Config msg


{-| Default configuration of an input chip
-}
config : Config msg
config =
    Config
        { leadingIcon = Nothing
        , trailingIcon = Nothing
        , additionalAttributes = []
        , onDelete = Nothing
        , onClick = Nothing
        }


{-| Specify whether an input chip displays a leading icon
-}
setLeadingIcon : Maybe String -> Config msg -> Config msg
setLeadingIcon leadingIcon (Config config_) =
    Config { config_ | leadingIcon = leadingIcon }


{-| Specify whether an input chip displays a trailing icon
-}
setTrailingIcon : Maybe String -> Config msg -> Config msg
setTrailingIcon trailingIcon (Config config_) =
    Config { config_ | trailingIcon = trailingIcon }


{-| Specify additonal attributes
-}
setAttributes : List (Html.Attribute msg) -> Config msg -> Config msg
setAttributes additionalAttributes (Config config_) =
    Config { config_ | additionalAttributes = additionalAttributes }


{-| Specify a message when the user clicks on a chip's trailing icon
-}
setOnDelete : msg -> Config msg -> Config msg
setOnDelete onDelete (Config config_) =
    Config { config_ | onDelete = Just onDelete }


{-| Specify a message when the user clicks on a chip
-}
setOnClick : msg -> Config msg -> Config msg
setOnClick onClick (Config config_) =
    Config { config_ | onClick = Just onClick }


{-| Input chip type
-}
type alias Chip msg =
    Material.Chip.Input.Internal.Chip msg


{-| Input chip view function
-}
chip : Config msg -> String -> Chip msg
chip =
    Chip
