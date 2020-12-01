module Material.Chip.Choice exposing
    ( Config, config
    , setIcon
    , setAttributes
    , chip, Chip
    , Icon, icon
    , customIcon
    , svgIcon
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
  - [Choice Chip](#choice-chip)
  - [Choice Chip with Custom Icon](#choice-chip-with-custom-icon)


# Resources

  - [Demo: Chips](https://aforemny.github.io/material-components-web-elm/#chips)
  - [Material Design Guidelines: Chips](https://material.io/go/design-chips)
  - [MDC Web: Chips](https://github.com/material-components/material-components-web/tree/master/packages/mdc-chips)
  - [Sass Mixins (MDC Web)](https://github.com/material-components/material-components-web/tree/master/packages/mdc-chips#sass-mixins)


# Basic Usage

    import Material.Chip.Choice as ChoiceChip
    import Material.ChipSet.Choice as ChoiceChipSet

    type Color
        = Red
        | Blue

    type Msg
        = ColorChanged Color

    main =
        ChoiceChipSet.chipSet
            (ChoiceChipSet.config
                { toLabel =
                    \color ->
                        case color of
                            Red ->
                                "Red"

                            Blue ->
                                "Blue"
                }
                |> ChoiceChipSet.setSelected (Just Red)
                |> ChocieChipSet.setOnClick ColorChanged
            )
            [ ChoiceChip.chip ChoiceChip.config Red
            , ChoiceChip.chip ChoiceChip.config Blue
            ]


# Configuration

@docs Config, config


## Configuration Options

@docs setIcon
@docs setAttributes


# Choice Chip

@docs chip, Chip


# Choice Chip with Custom Icon

This library natively supports [Material Icons](https://material.io/icons).
However, you may also include SVG or custom icons such as FontAwesome.

@docs Icon, icon
@docs customIcon
@docs svgIcon

-}

import Html exposing (Html, text)
import Html.Attributes exposing (class)
import Material.Chip.Choice.Internal exposing (Chip(..), Config(..), Icon(..))
import Svg exposing (Svg)


{-| Configuration of a choice chip
-}
type alias Config msg =
    Material.Chip.Choice.Internal.Config msg


{-| Default configuration of a choice chip
-}
config : Config msg
config =
    Config
        { icon = Nothing
        , additionalAttributes = []
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


{-| Choice chip type
-}
type alias Chip a msg =
    Material.Chip.Choice.Internal.Chip a msg


{-| Choice chip view function
-}
chip : Config msg -> a -> Chip a msg
chip =
    Chip


{-| Icon type
-}
type alias Icon =
    Material.Chip.Choice.Internal.Icon


{-| Material Icon

    ChoiceChip.chip
        (ChoiceChip.config
            |> ChoiceChip.setIcon (ChoiceChip.icon "favorite")
        )
        "Add to favorites"

-}
icon : String -> Icon
icon iconName =
    customIcon Html.i [ class "material-icons" ] [ text iconName ]


{-| Custom icon

    ChoiceChip.chip
        (ChoiceChip.config
            |> ChoiceChip.setIcon
                (ChoiceChip.customIcon Html.i
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

    ChoiceChp.chip
        (ActonChip.config
            > ChoiceChip.setIcon
                (ChoiceChip.svgIcon
                    [ Svg.Attributes.viewBox "…" ]
                    [-- …
                    ]
                )
        )
        "Fon awesome"

-}
svgIcon : List (Svg.Attribute Never) -> List (Svg Never) -> Icon
svgIcon attributes nodes =
    SvgIcon { node = Svg.svg, attributes = attributes, nodes = nodes }
