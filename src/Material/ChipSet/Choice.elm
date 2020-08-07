module Material.ChipSet.Choice exposing
    ( Config, config
    , setSelected
    , setOnChange
    , setAttributes
    , chipSet
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
  - [Choice Chip Set](#choice-chip-set)


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
                |> ChocieChipSet.setOnChange ColorChanged
            )
            [ ChoiceChip.chip ChoiceChip.config Red
            , ChoiceChip.chip ChoiceChip.config Blue
            ]


# Configuration

@docs Config, config


## Configuration Options

@docs setSelected
@docs setOnChange
@docs setAttributes


# Choice Chip Set

@docs chipSet

-}

import Html exposing (Html, text)
import Html.Attributes exposing (class)
import Html.Events
import Json.Decode as Decode
import Json.Encode as Encode
import Material.Chip.Choice.Internal as Chip exposing (Chip(..), Icon(..))
import Svg.Attributes


{-| Configuration of a choice chip set
-}
type Config a msg
    = Config
        { selected : Maybe a
        , onChange : Maybe (a -> msg)
        , toLabel : a -> String
        , additionalAttributes : List (Html.Attribute msg)
        }


{-| Default configuration of a choice chip set
-}
config : { toLabel : a -> String } -> Config a msg
config { toLabel } =
    Config
        { selected = Nothing
        , onChange = Nothing
        , toLabel = toLabel
        , additionalAttributes = []
        }


{-| Specify which chip is selected
-}
setSelected : Maybe a -> Config a msg -> Config a msg
setSelected selected (Config config_) =
    Config { config_ | selected = selected }


{-| Specify a message when the user clicks on a chip
-}
setOnChange : (a -> msg) -> Config a msg -> Config a msg
setOnChange onChange (Config config_) =
    Config { config_ | onChange = Just onChange }


{-| Specify additional attributes
-}
setAttributes : List (Html.Attribute msg) -> Config a msg -> Config a msg
setAttributes additionalAttributes (Config config_) =
    Config { config_ | additionalAttributes = additionalAttributes }


{-| Choice chip set view function
-}
chipSet : Config a msg -> List (Chip a msg) -> Html msg
chipSet ((Config { selected, onChange, toLabel, additionalAttributes }) as config_) chips =
    Html.node "mdc-chip-set"
        (chipSetCs :: chipSetChoiceCs :: gridRole :: additionalAttributes)
        (List.map (chip selected onChange toLabel) chips)


chip : Maybe a -> Maybe (a -> msg) -> (a -> String) -> Chip a msg -> Html msg
chip selected onChange toLabel (Chip ((Chip.Config { additionalAttributes }) as config_) value) =
    Html.div [ class "mdc-touch-target-wrapper" ]
        [ Html.node "mdc-chip"
            (List.filterMap identity
                [ chipCs
                , chipTouchCs
                , rowRole
                , selectedProp (Just value == selected)
                , interactionHandler (Maybe.map ((|>) value) onChange)
                ]
                ++ additionalAttributes
            )
            (List.filterMap identity
                [ rippleElt
                , leadingIconElt config_
                , primaryActionElt (toLabel value)
                ]
            )
        ]


chipSetCs : Html.Attribute msg
chipSetCs =
    class "mdc-chip-set"


chipSetChoiceCs : Html.Attribute msg
chipSetChoiceCs =
    class "mdc-chip-set--choice"


gridRole : Html.Attribute msg
gridRole =
    Html.Attributes.attribute "role" "grid"


chipCs : Maybe (Html.Attribute msg)
chipCs =
    Just (class "mdc-chip")


chipTextCs : Html.Attribute msg
chipTextCs =
    class "mdc-chip__text"


chipTouchCs : Maybe (Html.Attribute msg)
chipTouchCs =
    Just (class "mdc-chip--touch")


chipPrimaryActionCs : Html.Attribute msg
chipPrimaryActionCs =
    class "mdc-chip__primary-action"


selectedProp : Bool -> Maybe (Html.Attribute msg)
selectedProp selected =
    Just (Html.Attributes.property "selected" (Encode.bool selected))


buttonRole : Html.Attribute msg
buttonRole =
    Html.Attributes.attribute "role" "button"


rowRole : Maybe (Html.Attribute msg)
rowRole =
    Just (Html.Attributes.attribute "role" "row")


gridcellRole : Html.Attribute msg
gridcellRole =
    Html.Attributes.attribute "role" "gridcell"


interactionHandler : Maybe msg -> Maybe (Html.Attribute msg)
interactionHandler msg =
    Maybe.map (Html.Events.on "MDCChip:interaction" << Decode.succeed) msg


rippleElt : Maybe (Html msg)
rippleElt =
    Just (Html.div [ class "mdc-chip__ripple" ] [])


leadingIconElt : Chip.Config msg -> Maybe (Html msg)
leadingIconElt (Chip.Config { icon }) =
    Maybe.map (Html.map never) <|
        case icon of
            Just (Icon { node, attributes, nodes }) ->
                Just <|
                    node
                        (class "mdc-chip__icon mdc-chip__icon--leading"
                            :: attributes
                        )
                        nodes

            Just (SvgIcon { node, attributes, nodes }) ->
                Just <|
                    node
                        (Svg.Attributes.class "mdc-chip__icon mdc-chip__icon--leading"
                            :: attributes
                        )
                        nodes

            Nothing ->
                Nothing


primaryActionElt : String -> Maybe (Html msg)
primaryActionElt label =
    Just <|
        Html.span [ chipPrimaryActionCs, gridcellRole ]
            (List.filterMap identity [ textElt label, touchElt ])


textElt : String -> Maybe (Html msg)
textElt label =
    Just (Html.span [ chipTextCs, buttonRole ] [ text label ])


touchElt : Maybe (Html msg)
touchElt =
    Just (Html.div [ class "mdc-chip__touch" ] [])
