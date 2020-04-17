module Material.Select.Option exposing
    ( Config, config
    , setValue
    , setDisabled
    , setAttributes
    , SelectOption, selectOption
    )

{-| MDC Select provides Material Design single-option select menus. It supports
using the browser's native `<select>` element, or a MDC Menu. It is fully
accessible, and fully RTL-aware.


# Table of Contents

  - [Resources](#resources)
  - [Basic Usage](#basic-usage)
  - [Configuration](#configuration)
      - [Configuration Options](#configuration-options)
  - [Select Option](#select-option)
  - [Disabled Select Option](#disabled-select-option)


# Resources

  - [Demo: Selects](https://aforemny.github.io/material-components-web-elm/#select)
  - [Material Design Guidelines: Text Fields](https://material.io/go/design-text-fields)
  - [MDC Web: Select](https://github.com/material-components/material-components-web/tree/master/packages/mdc-select)
  - [Sass Mixins (MDC Web)](https://github.com/material-components/material-components-web/tree/master/packages/mdc-select#sass-mixins)


# Basic Usage

    import Material.Select as Select
    import Material.Select.Option as SelectOption

    type Msg
        = ValueChanged String

    main =
        Select.filled
            (Select.config
                |> Select.setLabel "Fruit"
                |> Select.setValue ""
                |> Select.setOnChange ValueChanged
            )
            [ SelectOption.selectOption
                (SelectOption.config
                    |> SelectOption.setValue ""
                )
                [ text "" ]
            , SelectOption.selectOption
                (SelectOption.config
                    |> SelectOption.setValue "Apple"
                )
                [ text "Apple" ]
            ]


# Configuration

@docs Config, config


## Configuration Options

@docs setValue
@docs setDisabled
@docs setAttributes


# Select Option

@docs SelectOption, selectOption


# Disabled Select Option

To disable one select's option, set its `disabled` configuration field to `True`.

    SelectOption.selectOption
        (SelectOption.config
            |> SelectOption.setDisabled True
        )
        [ text "" ]

This is particularly useful on the first emply option if you have a select that
must be filled but is not initially filled.

-}

import Html exposing (Html, text)
import Html.Attributes exposing (class)
import Html.Events
import Json.Decode as Decode
import Json.Encode as Encode
import Material.Select.Option.Internal


{-| Configuration of a select option
-}
type alias Config msg =
    Material.Select.Option.Internal.Config msg


{-| Default configuration of a select option
-}
config : Config msg
config =
    Material.Select.Option.Internal.Config
        { disabled = False
        , value = ""
        , additionalAttributes = []
        , nodes = []
        }


{-| Set a select option to be disabled
-}
setDisabled : Bool -> Config msg -> Config msg
setDisabled disabled (Material.Select.Option.Internal.Config config_) =
    Material.Select.Option.Internal.Config { config_ | disabled = disabled }


{-| Set a select option's value
-}
setValue : String -> Config msg -> Config msg
setValue value (Material.Select.Option.Internal.Config config_) =
    Material.Select.Option.Internal.Config { config_ | value = value }


{-| Specify additional attributes
-}
setAttributes : List (Html.Attribute msg) -> Config msg -> Config msg
setAttributes additionalAttributes (Material.Select.Option.Internal.Config config_) =
    Material.Select.Option.Internal.Config { config_ | additionalAttributes = additionalAttributes }


{-| Select option type
-}
type alias SelectOption msg =
    Material.Select.Option.Internal.SelectOption msg


{-| Select option view function
-}
selectOption : Config msg -> List (Html msg) -> SelectOption msg
selectOption (Material.Select.Option.Internal.Config config_) nodes =
    Material.Select.Option.Internal.SelectOption
        (Material.Select.Option.Internal.Config { config_ | nodes = nodes })
