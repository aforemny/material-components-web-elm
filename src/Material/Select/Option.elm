module Material.Select.Option exposing
    ( Config, config
    , setValue
    , setDisabled
    , setAttributes
    , SelectOption, selectOption
    )

{-| Select provides a single-option select menus.

This module concerns the select option. If you are looking for information
about the container select, refer to [Material.Select](Material-Select).


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
                |> Select.setValue (Just "")
                |> Select.setOnChange ValueChanged
            )
            [ SelectOption.selectOption
                (SelectOption.config
                    |> SelectOption.setValue (Just "")
                )
                [ text "" ]
            , SelectOption.selectOption
                (SelectOption.config
                    |> SelectOption.setValue (Just "Apple")
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

To disable one select's option, set its `setDisabled` configuration option to
`True`.

    SelectOption.selectOption
        (SelectOption.config |> SelectOption.setDisabled True)
        [ text "" ]

This is particularly useful on the first emply option if you have a select that
must be filled but is not initially filled.

-}

import Html exposing (Html, text)
import Html.Attributes exposing (class)
import Html.Events
import Json.Decode as Decode
import Json.Encode as Encode
import Material.Select.Option.Internal as SelectOption


{-| Configuration of a select option
-}
type alias Config msg =
    SelectOption.Config msg


{-| Default configuration of a select option
-}
config : Config msg
config =
    SelectOption.Config
        { disabled = False
        , value = Nothing
        , additionalAttributes = []
        , nodes = []
        }


{-| Specify whether a select option is disabled

Disabled select options cannot be selected.

-}
setDisabled : Bool -> Config msg -> Config msg
setDisabled disabled (SelectOption.Config config_) =
    SelectOption.Config { config_ | disabled = disabled }


{-| Specify a select option's label
-}
setValue : Maybe String -> Config msg -> Config msg
setValue value (SelectOption.Config config_) =
    SelectOption.Config { config_ | value = value }


{-| Specify additional attributes
-}
setAttributes : List (Html.Attribute msg) -> Config msg -> Config msg
setAttributes additionalAttributes (SelectOption.Config config_) =
    SelectOption.Config { config_ | additionalAttributes = additionalAttributes }


{-| Select option type
-}
type alias SelectOption msg =
    SelectOption.SelectOption msg


{-| Select option constructor
-}
selectOption : Config msg -> List (Html msg) -> SelectOption msg
selectOption (SelectOption.Config config_) nodes =
    SelectOption.SelectOption
        (SelectOption.Config { config_ | nodes = nodes })
