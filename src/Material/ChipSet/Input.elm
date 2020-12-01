module Material.ChipSet.Input exposing (chipSet)

{-| Chips are compact elements that allow users to enter information, select a
choice, filter content, or trigger an action.

Input chips are a variant of chips which enable user input by converting text
into chips.


# Table of Contents

  - [Resources](#resources)
  - [Basic Usage](#basic-usage)
  - [Input Chip Set](#input-chip-set)


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


# Input Chip Set

@docs chipSet

-}

import Html exposing (Html, text)
import Html.Attributes exposing (class)
import Html.Events
import Html.Keyed
import Json.Decode as Decode
import Json.Encode as Encode
import Material.Chip.Input.Internal as Chip exposing (Chip(..), Icon(..))
import Svg.Attributes


{-| Input chip set view function
-}
chipSet : List (Html.Attribute msg) -> ( String, Chip msg ) -> List ( String, Chip msg ) -> Html msg
chipSet additionalAttributes firstChip otherChips =
    Html.Keyed.node "mdc-chip-set"
        (chipSetCs :: chipSetInputCs :: gridRole :: additionalAttributes)
        (List.map (Tuple.mapSecond chip) (firstChip :: otherChips))


chip : Chip msg -> Html msg
chip (Chip ((Chip.Config { additionalAttributes }) as config_) label) =
    Html.div [ class "mdc-touch-target-wrapper" ]
        [ Html.node "mdc-chip"
            (List.filterMap identity
                [ chipCs
                , chipTouchCs
                , rowRole
                , removalHandler config_
                ]
                ++ additionalAttributes
            )
            (List.filterMap identity
                [ rippleElt
                , leadingIconElt config_
                , primaryActionElt label
                , trailingIconElt config_
                ]
            )
        ]


chipSetCs : Html.Attribute msg
chipSetCs =
    class "mdc-chip-set"


chipSetInputCs : Html.Attribute msg
chipSetInputCs =
    class "mdc-chip-set--input"


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


tabIndexProp : Int -> Html.Attribute msg
tabIndexProp tabIndex =
    Html.Attributes.property "tabIndex" (Encode.int tabIndex)


buttonRole : Html.Attribute msg
buttonRole =
    Html.Attributes.attribute "role" "button"


rowRole : Maybe (Html.Attribute msg)
rowRole =
    Just (Html.Attributes.attribute "role" "row")


gridcellRole : Html.Attribute msg
gridcellRole =
    Html.Attributes.attribute "role" "gridcell"


removalHandler : Chip.Config msg -> Maybe (Html.Attribute msg)
removalHandler (Chip.Config { onDelete }) =
    Maybe.map (Html.Events.on "MDCChip:removal" << Decode.succeed) onDelete


rippleElt : Maybe (Html msg)
rippleElt =
    Just (Html.div [ class "mdc-chip__ripple" ] [])


leadingIconElt : Chip.Config msg -> Maybe (Html msg)
leadingIconElt (Chip.Config { leadingIcon }) =
    Maybe.map (Html.map never) <|
        case leadingIcon of
            Just (Icon { node, attributes, nodes }) ->
                Just <|
                    node
                        (class "mdc-chip__icon"
                            :: class "mdc-chip__icon--leading"
                            :: tabIndexProp -1
                            :: buttonRole
                            :: attributes
                        )
                        nodes

            Just (SvgIcon { node, attributes, nodes }) ->
                Just <|
                    node
                        (Svg.Attributes.class "mdc-chip__icon"
                            :: Svg.Attributes.class "mdc-chip__icon--leading"
                            :: tabIndexProp -1
                            :: buttonRole
                            :: attributes
                        )
                        nodes

            Nothing ->
                Nothing


primaryActionElt : String -> Maybe (Html msg)
primaryActionElt label =
    Just <|
        Html.span [ chipPrimaryActionCs, gridcellRole, tabIndexProp -1 ]
            (List.filterMap identity [ textElt label, touchElt ])


textElt : String -> Maybe (Html msg)
textElt label =
    Just (Html.span [ chipTextCs, buttonRole ] [ text label ])


touchElt : Maybe (Html msg)
touchElt =
    Just (Html.div [ class "mdc-chip__touch" ] [])


trailingIconElt : Chip.Config msg -> Maybe (Html msg)
trailingIconElt (Chip.Config { trailingIcon, onDelete }) =
    Maybe.map
        (\_ ->
            Html.map never <|
                case trailingIcon of
                    Just (Icon { node, attributes, nodes }) ->
                        node
                            (class "mdc-chip__icon"
                                :: class "mdc-chip__icon--trailing"
                                :: tabIndexProp -1
                                :: buttonRole
                                :: attributes
                            )
                            nodes

                    Just (SvgIcon { node, attributes, nodes }) ->
                        node
                            (Svg.Attributes.class "mdc-chip__icon"
                                :: Svg.Attributes.class "mdc-chip__icon--trailing"
                                :: tabIndexProp -1
                                :: buttonRole
                                :: attributes
                            )
                            nodes

                    Nothing ->
                        Html.i
                            [ class "material-icons"
                            , class "mdc-chip__icon"
                            , class "mdc-chip__icon--trailing"
                            , tabIndexProp -1
                            , buttonRole
                            ]
                            [ text "cancel" ]
        )
        onDelete
