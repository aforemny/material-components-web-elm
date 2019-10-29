module Material.Chips exposing
    ( choiceChipSet, choiceChip, ChoiceChip, choiceChipConfig, ChoiceChipConfig
    , filterChipSet, filterChip, FilterChip, filterChipConfig, FilterChipConfig
    , inputChipSet, inputChip, InputChip, inputChipConfig, InputChipConfig
    )

{-| Chips are compact elements that allow users to enter information, select a
choice, filter content, or trigger an action.


# Table of Contents

  - [Resources](#resources)
  - [Basic Usage](#basic-usage)
  - [Choice Chips](#choice-chips)
  - [Filter Chips](#filter-chips)
  - [Input Chips](#input-chips)


# Resources

  - [Demo: Chips](https://aforemny.github.io/material-components-web-elm/#chips)
  - [Material Design Guidelines: Chips](https://material.io/go/design-chips)
  - [MDC Web: Chips](https://github.com/material-components/material-components-web/tree/master/packages/mdc-chips)
  - [Sass Mixins (MDC Web)](https://github.com/material-components/material-components-web/tree/master/packages/mdc-chips#sass-mixins)


# Basic Usage

    import Material.Chips
        exposing
            ( choiceChip
            , choiceChipConfig
            , choiceChipSet
            )

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


# Choice Chips

Choice chips are a variant of chips which allow single selection from a set of
options.

    choiceChipSet []
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

@docs choiceChipSet, choiceChip, ChoiceChip, choiceChipConfig, ChoiceChipConfig


# Filter Chips

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

@docs filterChipSet, filterChip, FilterChip, filterChipConfig, FilterChipConfig


# Input Chips

Input chips are a variant of chips which enable user input by converting text
into chips.

    inputChipSet []
        [ inputChip inputChipConfig "Chip One"
        , inputChip inputChipConfig "Chip Two"
        ]

@docs inputChipSet, inputChip, InputChip, inputChipConfig, InputChipConfig

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
choiceChipSet : List (Html.Attribute msg) -> List (ChoiceChip msg) -> Html msg
choiceChipSet additionalAttributes chips =
    Html.node "mdc-chip-set"
        (chipSetRootCs :: choiceCs :: additionalAttributes)
        (List.map (\(ChoiceChip html) -> html) chips)


{-| Configuration of a choice chip
-}
type alias ChoiceChipConfig msg =
    { icon : Maybe String
    , selected : Bool
    , additionalAttributes : List (Html.Attribute msg)
    , onClick : Maybe msg
    }


{-| Default configuration of a choice chip
-}
choiceChipConfig : ChoiceChipConfig msg
choiceChipConfig =
    { icon = Nothing
    , selected = False
    , additionalAttributes = []
    , onClick = Nothing
    }


{-| Choice Chip type
-}
type ChoiceChip msg
    = ChoiceChip (Html msg)


{-| Choice chip view function
-}
choiceChip : ChoiceChipConfig msg -> String -> ChoiceChip msg
choiceChip config label =
    ChoiceChip <|
        Html.node "mdc-chip"
            (List.filterMap identity
                [ chipRootCs

                -- , selectedCs config
                , selectedProp config
                , clickHandler config
                ]
                ++ config.additionalAttributes
            )
            [ textElt label ]


chipRootCs : Maybe (Html.Attribute msg)
chipRootCs =
    Just (class "mdc-chip")


selectedCs : { chipConfig | selected : Bool } -> Maybe (Html.Attribute msg)
selectedCs { selected } =
    if selected then
        Just (class "mdc-chip--selected")

    else
        Nothing


selectedProp : { chipConfig | selected : Bool } -> Maybe (Html.Attribute msg)
selectedProp { selected } =
    Just (Html.Attributes.property "selected" (Encode.bool selected))


clickHandler : { chipConfig | onClick : Maybe msg } -> Maybe (Html.Attribute msg)
clickHandler config =
    Maybe.map (Html.Events.on "MDCChip:interaction" << Decode.succeed) config.onClick


textElt : String -> Html msg
textElt label =
    Html.div [ class "mdc-chip__text" ] [ text label ]


{-| Filter chip container
-}
filterChipSet : List (Html.Attribute msg) -> List (FilterChip msg) -> Html msg
filterChipSet additionalAttributes chips =
    Html.node "mdc-chip-set"
        (chipSetRootCs :: filterCs :: additionalAttributes)
        (List.map (\(FilterChip html) -> html) chips)


{-| Configuration of a filter chip
-}
type alias FilterChipConfig msg =
    { icon : Maybe String
    , selected : Bool
    , additionalAttributes : List (Html.Attribute msg)
    , onClick : Maybe msg
    }


{-| Default configuration of a filter chip
-}
filterChipConfig : FilterChipConfig msg
filterChipConfig =
    { icon = Nothing
    , selected = False
    , additionalAttributes = []
    , onClick = Nothing
    }


{-| Filter chip type
-}
type FilterChip msg
    = FilterChip (Html msg)


{-| Filter chip view function
-}
filterChip : FilterChipConfig msg -> String -> FilterChip msg
filterChip config label =
    FilterChip <|
        Html.node "mdc-chip"
            (List.filterMap identity
                [ chipRootCs

                -- , selectedCs config
                , selectedProp config
                , clickHandler config
                ]
                ++ config.additionalAttributes
            )
            (List.filterMap identity
                [ filterLeadingIconElt config
                , checkmarkElt
                ]
                ++ [ textElt label ]
            )


leadingIconElt : ChoiceChipConfig msg -> Maybe (Html msg)
leadingIconElt { icon } =
    case icon of
        Just iconName ->
            Just
                (Html.i
                    [ class "material-icons mdc-chip__icon"
                    , class "mdc-chip__icon--leading"
                    ]
                    [ text iconName ]
                )

        _ ->
            Nothing


filterLeadingIconElt : FilterChipConfig msg -> Maybe (Html msg)
filterLeadingIconElt { icon, selected } =
    case icon of
        Just iconName ->
            Just
                (Html.i
                    [ class "material-icons mdc-chip__icon"
                    , if selected then
                        class "mdc-chip__icon--leading mdc-chip__icon--leading-hidden"

                      else
                        class "mdc-chip__icon--leading"
                    ]
                    [ text iconName ]
                )

        _ ->
            Nothing


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


{-| Input chip container
-}
inputChipSet : List (Html.Attribute msg) -> List (InputChip msg) -> Html msg
inputChipSet additionalAttributes chips =
    Html.node "mdc-chip-set"
        (chipSetRootCs :: inputCs :: additionalAttributes)
        (List.map (\(InputChip html) -> html) chips)


{-| Configuration of a input chip
-}
type alias InputChipConfig msg =
    { icon : String
    , additionalAttributes : List (Html.Attribute msg)
    , onClick : Maybe msg
    , onTrailingIconClick : Maybe msg
    }


{-| Default configuration of a input chip
-}
inputChipConfig : InputChipConfig msg
inputChipConfig =
    { icon = "close"
    , additionalAttributes = []
    , onClick = Nothing
    , onTrailingIconClick = Nothing
    }


{-| Input chip type
-}
type InputChip msg
    = InputChip (Html msg)


{-| Input chip view function
-}
inputChip : InputChipConfig msg -> String -> InputChip msg
inputChip config label =
    InputChip <|
        Html.node "mdc-chip"
            (List.filterMap identity
                [ chipRootCs
                , clickHandler config
                , trailingIconClickHandler config
                ]
                ++ config.additionalAttributes
            )
            [ textElt label
            , trailingIconElt config
            ]


trailingIconClickHandler : InputChipConfig msg -> Maybe (Html.Attribute msg)
trailingIconClickHandler config =
    Maybe.map (Html.Events.on "MDCChip:trailingIconInteraction" << Decode.succeed)
        config.onTrailingIconClick


trailingIconElt : InputChipConfig msg -> Html msg
trailingIconElt { icon } =
    Html.i
        [ class "material-icons mdc-chip__icon mdc-chip__icon--trailing" ]
        [ text icon ]


chipSetRootCs : Html.Attribute msg
chipSetRootCs =
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
