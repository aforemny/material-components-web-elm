module Material.ChipSet.Filter exposing (chipSet)

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
  - [Filter Chip Set](#filter-chip-set)


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
            [ FilterChip.chip
                (FilterChip.config
                    |> FilterChip.setSelected True
                    |> FilterChip.setOnClick
                        (ChipClicked "Tops")
                )
                "Tops"
            , FilterChip.chip
                (FilterChip.config
                    |> FilterChip.setOnClick
                        (ChipClicked "Shoes")
                )
                "Shoes"
            ]


# Filter Chip Set

@docs chipSet

-}

import Html exposing (Html, text)
import Html.Attributes exposing (class)
import Html.Events
import Json.Decode as Decode
import Json.Encode as Encode
import Material.Chip.Filter.Internal as Chip exposing (Chip(..))
import Svg
import Svg.Attributes


{-| Filter chip set view function
-}
chipSet : List (Html.Attribute msg) -> List (Chip msg) -> Html msg
chipSet additionalAttributes chips =
    Html.node "mdc-chip-set"
        (chipSetCs :: chipSetFilterCs :: gridRole :: additionalAttributes)
        (List.map chip chips)


chip : Chip msg -> Html msg
chip (Chip ((Chip.Config { additionalAttributes }) as config_) label) =
    Html.div [ class "mdc-touch-target-wrapper" ]
        [ Html.node "mdc-chip"
            (List.filterMap identity
                [ chipCs
                , chipTouchCs
                , rowRole
                , selectedProp config_
                , interactionHandler config_
                ]
                ++ additionalAttributes
            )
            (List.filterMap identity
                [ rippleElt
                , leadingIconElt config_
                , checkmarkElt
                , primaryActionElt label
                ]
            )
        ]


chipSetCs : Html.Attribute msg
chipSetCs =
    class "mdc-chip-set"


chipSetFilterCs : Html.Attribute msg
chipSetFilterCs =
    class "mdc-chip-set--filter"


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


selectedProp : Chip.Config msg -> Maybe (Html.Attribute msg)
selectedProp (Chip.Config { selected }) =
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


interactionHandler : Chip.Config msg -> Maybe (Html.Attribute msg)
interactionHandler (Chip.Config { onChange }) =
    Maybe.map (Html.Events.on "MDCChip:interaction" << Decode.succeed) onChange


rippleElt : Maybe (Html msg)
rippleElt =
    Just (Html.div [ class "mdc-chip__ripple" ] [])


leadingIconElt : Chip.Config msg -> Maybe (Html msg)
leadingIconElt (Chip.Config { icon, selected }) =
    Maybe.map
        (\iconName ->
            Html.i
                [ class "material-icons"
                , class "mdc-chip__icon mdc-chip__icon--leading"
                ]
                [ text iconName ]
        )
        icon


checkmarkElt : Maybe (Html msg)
checkmarkElt =
    Just
        (Html.div [ class "mdc-chip__checkmark" ]
            [ Svg.svg
                [ Svg.Attributes.class "mdc-chip__checkmark-svg"
                , Svg.Attributes.viewBox "-2 -3 30 30"
                ]
                [ Svg.path
                    [ Svg.Attributes.class "mdc-chip__checkmark-path"
                    , Svg.Attributes.fill "none"
                    , Svg.Attributes.stroke "black"
                    , Svg.Attributes.d "M1.73,12.91 8.1,19.28 22.79,4.59"
                    ]
                    []
                ]
            ]
        )


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
