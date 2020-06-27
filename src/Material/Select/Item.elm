module Material.Select.Item exposing
    ( Config, config
    , setDisabled
    , setAttributes
    , SelectItem, selectItem
    )

{-| Select provides a single-option select menus.

This module concerns the select items. If you are looking for the select container,
refer to [Material.Select](Material-Select).


# Table of Contents

  - [Resources](#resources)
  - [Basic Usage](#basic-usage)
  - [Configuration](#configuration)
      - [Configuration Options](#configuration-options)
  - [Select Item](#select-item)
  - [Disabled Select Item](#disabled-select-item)


# Resources

  - [Demo: Selects](https://aforemny.github.io/material-components-web-elm/#select)
  - [Material Design Guidelines: Text Fields](https://material.io/go/design-text-fields)
  - [MDC Web: Select](https://github.com/material-components/material-components-web/tree/master/packages/mdc-select)
  - [Sass Mixins (MDC Web)](https://github.com/material-components/material-components-web/tree/master/packages/mdc-select#sass-mixins)


# Basic Usage

    import Material.Select as Select
    import Material.Select.Item as SelectItem

    type Msg
        = ValueChanged String

    main =
        Select.filled
            (Select.config
                |> Select.setLabel (Just "Fruit")
                |> Select.setSelected (Just "")
                |> Select.setOnChange ValueChanged
            )
            (SelectItem.selectItem
                (SelectItem.config { value = "" })
                [ text "" ]
            )
            [ SelectItem.selectItem
                (SelectItem.config { value = "Apple" })
                [ text "Apple" ]
            ]


# Configuration

@docs Config, config


## Configuration Options

@docs setDisabled
@docs setAttributes


# Select Item

@docs SelectItem, selectItem


# Disabled Select Item

Select items may be disabled by setting their `setDisabled` configuration option
to `True`.

    SelectItem.selectItem
        (SelectItem.config { value = "Apple" }
            |> SelectItem.setDisabled True
        )
        [ text "Apple" ]

-}

import Html exposing (Html)
import Material.Select.Item.Internal exposing (Config(..), SelectItem(..))


{-| Configuration of a select item
-}
type alias Config a msg =
    Material.Select.Item.Internal.Config a msg


{-| Default configuration of a select item
-}
config : { value : a } -> Config a msg
config { value } =
    Config
        { value = value
        , disabled = False
        , additionalAttributes = []
        }


{-| Specify whether a select item should be disabled

Disabled select items cannot be interacted with and have not visual interaction
effect.

-}
setDisabled : Bool -> Config a msg -> Config a msg
setDisabled disabled (Config config_) =
    Config { config_ | disabled = disabled }


{-| Specify additional attributes
-}
setAttributes : List (Html.Attribute msg) -> Config a msg -> Config a msg
setAttributes additionalAttributes (Config config_) =
    Config { config_ | additionalAttributes = additionalAttributes }


{-| Select item type
-}
type alias SelectItem a msg =
    Material.Select.Item.Internal.SelectItem a msg


{-| Select item constructor
-}
selectItem : Config a msg -> List (Html msg) -> SelectItem a msg
selectItem =
    SelectItem
