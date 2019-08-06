module Material.ChipSet exposing
    ( choiceChipSet
    , filterChipSet
    , inputChipSet
    )

{-| Chips are compact elements that allow users to enter information, select a
choice, filter content, or trigger an action.


# Table of Contents

  - [Resources](#resources)
  - [Basic Usage](#basic-usage)
  - [Choice Chip Set](#choice-chip-set)
  - [Filter Chip Set](#filter-chip-set)
  - [Input Chip Set](#input-chip-set)


# Resources


# Basic Usage

    import Material.Chip.Choice
        exposing
            ( choiceChip
            , choiceChipConfig
            )
    import Material.ChipSet exposing (choiceChipSet)

    type Msg
        = ChipSelected String

    main =
        [ choiceChipSet []
            [ choiceChip
                { choiceChipConfig
                    | selected = True
                    , onClick = Just (ChipSelected "One")
                }
                "Chip One"
            , choiceChip
                { choiceChipConfig
                    | onClick = Just (ChipSelected "Two")
                }
                "Chip Two"
            ]
        ]


# Choice Chip Set

Choice chips are a variant of chips which allow single selection from a set of
options.

    choiceChipSet []
        [ choiceChip choiceChipConfig "Chip One"
        , choiceChip choiceChipConfig "Chip Two"
        ]

@docs choiceChipSet


# Filter Chip Set

Filter chips are a variant of chips which allow multiple selection from a set
of options. When a filter chip is selected, a checkmark appears as the leading
icon. If the chip already has a leading icon, the checkmark replaces it.

    filterChipSet []
        [ filterChip
            { filterChipConfig
                | selected = True
                , onClick = Just (ChipSelected "Chip One")
            }
            "Tops"
        , filterChip
            { filterChipConfig
                | onClick = Just (ChipSelected "Chip Two")
            }
            "Shoes"
        ]

@docs filterChipSet


# Input Chip Set

Input chips are a variant of chips which enable user input by converting text
into chips.

    inputChipSet []
        [ inputChip inputChipConfig "Chip One"
        , inputChip inputChipConfig "Chip Two"
        ]

@docs inputChipSet

-}

import Html exposing (Html, text)
import Html.Attributes exposing (class)


{-| Choice chip container
-}
choiceChipSet : List (Html.Attribute msg) -> List (Html msg) -> Html msg
choiceChipSet additionalAttributes chips =
    Html.node "mdc-chip-set" (rootCs :: choiceCs :: additionalAttributes) chips


{-| Filter chip container
-}
filterChipSet : List (Html.Attribute msg) -> List (Html msg) -> Html msg
filterChipSet additionalAttributes chips =
    Html.node "mdc-chip-set" (rootCs :: filterCs :: additionalAttributes) chips


{-| Input chip container
-}
inputChipSet : List (Html.Attribute msg) -> List (Html msg) -> Html msg
inputChipSet additionalAttributes chips =
    Html.node "mdc-chip-set" (rootCs :: inputCs :: additionalAttributes) chips


rootCs : Html.Attribute msg
rootCs =
    class "mdc-chip-set"


choiceCs : Html.Attribute msg
choiceCs =
    class "mdc-chip-set--choice"


filterCs : Html.Attribute msg
filterCs =
    class "mdc-chip-set--filter"


inputCs : Html.Attribute msg
inputCs =
    class "mdc-chip-set--input"
