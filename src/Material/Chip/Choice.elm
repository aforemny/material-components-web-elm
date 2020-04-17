module Material.Chip.Choice exposing
    ( Config, config
    , setOnClick
    , setIcon
    , setSelected
    , setAttributes
    , set, chip, Chip
    )

{-| Chips are compact elements that allow users to enter information, select a
choice, filter content, or trigger an action.


# Table of Contents

  - [Resources](#resources)
  - [Basic Usage](#basic-usage)
  - [Configuration](#configuration)
      - [Configuration Options](#configuration-options)
  - [Choice Chips](#choice-chips)


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
@docs setAttributes


# Choice Chips

Choice chips are a variant of chips which allow single selection from a set of
options.

@docs set, chip, Chip

-}

import Html exposing (Html, text)
import Html.Attributes exposing (class)
import Html.Events
import Json.Decode as Decode
import Json.Encode as Encode
import Svg
import Svg.Attributes


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
        }


{-| Set a chip's icon
-}
setIcon : Maybe String -> Config msg -> Config msg
setIcon icon (Config config_) =
    Config { config_ | icon = icon }


{-| Set a chip to be selected
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


{-| Choice Chip type
-}
type Chip msg
    = Chip (Html msg)


{-| Choice chip view function
-}
chip : Config msg -> String -> Chip msg
chip ((Config { additionalAttributes }) as config_) label =
    Chip <|
        Html.node "mdc-chip"
            (List.filterMap identity
                [ chipRootCs
                , selectedProp config_
                , clickHandler config_
                ]
                ++ additionalAttributes
            )
            [ textElt label ]


chipRootCs : Maybe (Html.Attribute msg)
chipRootCs =
    Just (class "mdc-chip")


selectedProp : Config msg -> Maybe (Html.Attribute msg)
selectedProp (Config { selected }) =
    Just (Html.Attributes.property "selected" (Encode.bool selected))


clickHandler : Config msg -> Maybe (Html.Attribute msg)
clickHandler (Config { onClick }) =
    Maybe.map (Html.Events.on "MDCChip:interaction" << Decode.succeed) onClick


textElt : String -> Html msg
textElt label =
    Html.div [ class "mdc-chip__text" ] [ text label ]


chipSetRootCs : Html.Attribute msg
chipSetRootCs =
    class "mdc-chip-set"


choiceCs : Html.Attribute msg
choiceCs =
    class "mdc-chip-set--choice"
