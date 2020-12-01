module Material.Chip.Action exposing
    ( Config, config
    , setOnClick
    , setIcon
    , setAttributes
    , chip, Chip
    , Icon, icon
    , customIcon
    , svgIcon
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
  - [Action Chip](#action-chip)
  - [Action Chip with Custom Icon](#action-chip-with-custom-icon)


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


# Action Chip

@docs chip, Chip


# Action Chip with Custom Icon

This library natively supports [Material Icons](https://material.io/icons).
However, you may also include SVG or custom icons such as FontAwesome.

@docs Icon, icon
@docs customIcon
@docs svgIcon

-}

import Html exposing (Html, text)
import Html.Attributes exposing (class)
import Material.Chip.Action.Internal exposing (Chip(..), Config(..), Icon(..))
import Svg exposing (Svg)


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
setIcon : Maybe Icon -> Config msg -> Config msg
setIcon icon_ (Config config_) =
    Config { config_ | icon = icon_ }


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


{-| Icon type
-}
type alias Icon =
    Material.Chip.Action.Internal.Icon


{-| Material Icon

    ActionChip.chip
        (ActionChip.config
            |> ActionChip.setIcon (ActionChip.icon "favorite")
        )
        "Add to favorites"

-}
icon : String -> Icon
icon iconName =
    customIcon Html.i [ class "material-icons" ] [ text iconName ]


{-| Custom icon

    ActionChip.chip
        (ActionChip.config
            |> ActionChip.setIcon
                (ActionChip.customIcon Html.i
                    [ class "fab fa-font-awesome" ]
                    []
                )
        )
        "Font awesome"

-}
customIcon :
    (List (Html.Attribute Never) -> List (Html Never) -> Html Never)
    -> List (Html.Attribute Never)
    -> List (Html Never)
    -> Icon
customIcon node attributes nodes =
    Icon { node = node, attributes = attributes, nodes = nodes }


{-| SVG icon

    ActionChip.chip
        (ActionChip.config
            |> ActionChip.setIcon
                (ActionChip.svgIcon
                    [ Svg.Attributes.viewBox "…" ]
                    [-- …
                    ]
                )
        )
        "Font awesome"

-}
svgIcon : List (Svg.Attribute Never) -> List (Svg Never) -> Icon
svgIcon attributes nodes =
    SvgIcon { node = Svg.svg, attributes = attributes, nodes = nodes }
