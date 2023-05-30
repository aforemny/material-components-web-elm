module Material.Chip.Filter exposing
    ( Config, config
    , setOnChange
    , setIcon
    , setSelected
    , setAttributes
    , chip, Chip
    , Icon, icon
    , customIcon
    , svgIcon
    )

{-| Chips are compact elements that allow users to enter information, select a
choice, filter content, or trigger an action.

Filter chips are a variant of chips which allow multiple selection from a set
of options. When a filter chip is selected, a checkmark appears as the leading
icon. If the chip already has a leading icon, the checkmark replaces it.


# Table of Contents

  - [Resources](#resources)
  - [Basic Usage](#basic-usage)
  - [Configuration](#configuration)
      - [Configuration Options](#configuration-options)
  - [Filter Chip](#filter-chip)
  - [Filter Chip with Custom Icon](#filter-chip-with-custom-icon)


# Resources

  - [Demo: Chips](https://aforemny.github.io/material-components-web-elm/#chips)
  - [Material Design Guidelines: Chips](https://material.io/go/design-chips)
  - [MDC Web: Chips](https://github.com/material-components/material-components-web/tree/master/packages/mdc-chips)
  - [Sass Mixins (MDC Web)](https://github.com/material-components/material-components-web/tree/master/packages/mdc-chips#sass-mixins)


# Basic Usage

    import Material.Chip.Filter as FilterChip
    import Material.ChipSet.Filter as FilterChipSet

    type Msg
        = ChipClicked String

    main =
        FilterChipSet.chipSet []
            (FilterChip.chip
                (FilterChip.config
                    |> FilterChip.setSelected True
                    |> FilterChip.setOnChange
                        (ChipClicked "Shoes")
                )
                "Tops"
            )
            [ FilterChip.chip
                (FilterChip.config
                    |> FilterChip.setOnChange
                        (ChipClicked "Shoes")
                )
                "Shoes"
            ]


# Configuration

@docs Config, config


## Configuration Options

@docs setOnChange
@docs setIcon
@docs setSelected
@docs setAttributes


# Filter Chip

@docs chip, Chip


# Filter Chip with Custom Icon

This library natively supports [Material Icons](https://material.io/icons).
However, you may also include SVG or custom icons such as FontAwesome.

@docs Icon, icon
@docs customIcon
@docs svgIcon

-}

import Html exposing (Html, text)
import Html.Attributes exposing (class)
import Material.Chip.Filter.Internal exposing (Chip(..), Config(..), Icon(..))
import Svg exposing (Svg)


{-| Configuration of a filter chip
-}
type alias Config msg =
    Material.Chip.Filter.Internal.Config msg


{-| Default configuration of a filter chip
-}
config : Config msg
config =
    Config
        { selected = False
        , icon = Nothing
        , onChange = Nothing
        , additionalAttributes = []
        }


{-| Specify whether a filter chip is selected
-}
setSelected : Bool -> Config msg -> Config msg
setSelected selected (Config config_) =
    Config { config_ | selected = selected }


{-| Specify whether a chip displays an icon
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
setOnChange : msg -> Config msg -> Config msg
setOnChange onChange (Config config_) =
    Config { config_ | onChange = Just onChange }


{-| Filter chip type
-}
type alias Chip msg =
    Material.Chip.Filter.Internal.Chip msg


{-| Filter chip view function
-}
chip : Config msg -> String -> Chip msg
chip =
    Chip


{-| Icon type
-}
type alias Icon =
    Material.Chip.Filter.Internal.Icon


{-| Material Icon

    FilterChip.chip
        (FilterChip.config
            |> FilterChip.setIcon
                (Just (FilterChip.icon "favorite"))
        )
        "Add to favorites"

-}
icon : String -> Icon
icon iconName =
    customIcon Html.i [ class "material-icons" ] [ text iconName ]


{-| Custom icon

    FilterChip.chip
        (FilterChip.config
            |> FilterChip.setIcon
                (Just
                    (FilterChip.customIcon Html.i
                        [ class "fab fa-font-awesome" ]
                        []
                    )
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

    FilterChip.chip
        (FilterChip.config
            |> FilterChip.setIcon
                (Just
                    (FilterChip.svgIcon
                        [ Svg.Attributes.viewBox "…" ]
                        [-- …
                        ]
                    )
                )
        )
        "Font awesome"

-}
svgIcon : List (Svg.Attribute Never) -> List (Svg Never) -> Icon
svgIcon attributes nodes =
    SvgIcon { node = Svg.svg, attributes = attributes, nodes = nodes }
