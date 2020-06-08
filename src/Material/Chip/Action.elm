module Material.Chip.Action exposing
    ( Config, config
    , setOnClick
    , setIcon
    , setAttributes
    , chip, Chip
    )

{-| Action chips offer actions related to primary content. They should appear
dynamically and contextually in a UI.

An alternative to action chips are [buttons](Material-Button), which should
appear persistently and consistently.


# Table of Contents

  - [Resources](#resources)
  - [Basic Usage](#basic-usage)
  - [Configuration](#configuration)
      - [Configuration Options](#configuration-options)
  - [Action Chips](#action-chips)


# Resources

  - [Demo: Chips](https://aforemny.github.io/material-components-web-elm/#chips)
  - [Material Design Guidelines: Chips](https://material.io/go/design-chips)
  - [MDC Web: Chips](https://github.com/material-components/material-components-web/tree/master/packages/mdc-chips)
  - [Sass Mixins (MDC Web)](https://github.com/material-components/material-components-web/tree/master/packages/mdc-chips#sass-mixins)


# Basic Usage

    import Material.Chip.Action as ActionChip
    import Material.ChipSet.Action as ActionChipSet

    type Msg
        = Clicked String

    main =
        ActionChipSet.chipSet []
            [ ActionChip.chip
                (ActionChip.config
                    |> ActionChip.setOnClick Clicked "Chip One"
                )
                "Chip One"
            , ActionChip.chip ActionChip.config "Chip Two"
            ]


# Configuration

@docs Config, config


## Configuration Options

@docs setOnClick
@docs setIcon
@docs setAttributes


# Action Chips

@docs chip, Chip

-}

import Html
import Material.Chip.Action.Internal exposing (Chip(..), Config(..))


{-| Configuration of an action chip
-}
type alias Config msg =
    Material.Chip.Action.Internal.Config msg


{-| Default configuration of an action chip
-}
config : Config msg
config =
    Config
        { icon = Nothing
        , additionalAttributes = []
        , onClick = Nothing
        }


{-| Specify whether the chip displays an icon
-}
setIcon : Maybe String -> Config msg -> Config msg
setIcon icon (Config config_) =
    Config { config_ | icon = icon }


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


{-| Action chip type
-}
type alias Chip msg =
    Material.Chip.Action.Internal.Chip msg


{-| Action chip view function
-}
chip : Config msg -> String -> Chip msg
chip =
    Chip
