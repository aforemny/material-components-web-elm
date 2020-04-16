module Material.FilterChip exposing
    ( Config, config
    , setOnClick
    , setIcon
    , setSelected
    , setAdditionalAttributes
    , set, chip, Chip
    )

{-| Chips are compact elements that allow users to enter information, select a
choice, filter content, or trigger an action.


# Table of Contents

  - [Resources](#resources)
  - [Basic Usage](#basic-usage)
  - [Configuration](#configuration)
      - [Configuration Options](#configuration-options)
  - [Filter Chips](#filter-chips)


# Resources

  - [Demo: Chips](https://aforemny.github.io/material-components-web-elm/#chips)
  - [Material Design Guidelines: Chips](https://material.io/go/design-chips)
  - [MDC Web: Chips](https://github.com/material-components/material-components-web/tree/master/packages/mdc-chips)
  - [Sass Mixins (MDC Web)](https://github.com/material-components/material-components-web/tree/master/packages/mdc-chips#sass-mixins)


# Basic Usage

    import Material.FilterChip as FilterChip

    type Msg
        = ChipClicked String

    main =
        FilterChip.set []
            [ FilterChip.chip
                (FilterChip.config
                    |> FilterChip.setSelected True
                    |> FilterChip.setOnClick (ChipClicked "Tops")
                )
                "Tops"
            , FilterChip.chip
                (FilterChip.config
                    |> FilterChip.setOnClick (ChipClicked "Shoes")
                )
                "Shoes"
            ]


# Configuration

@docs Config, config


## Configuration Options

@docs setOnClick
@docs setIcon
@docs setSelected
@docs setAdditionalAttributes


# Filter Chips

Filter chips are a variant of chips which allow multiple selection from a set
of options. When a filter chip is selected, a checkmark appears as the leading
icon. If the chip already has a leading icon, the checkmark replaces it.

@docs set, chip, Chip

-}

import Html exposing (Html, text)
import Html.Attributes exposing (class)
import Html.Events
import Json.Decode as Decode
import Json.Encode as Encode
import Svg
import Svg.Attributes


{-| Filter chip container
-}
set : List (Html.Attribute msg) -> List (Chip msg) -> Html msg
set additionalAttributes chips =
    Html.node "mdc-chip-set"
        (chipSetRootCs :: filterCs :: additionalAttributes)
        (List.map (\(Chip html) -> html) chips)


{-| Configuration of a filter chip
-}
type Config msg
    = Config
        { icon : Maybe String
        , selected : Bool
        , additionalAttributes : List (Html.Attribute msg)
        , onClick : Maybe msg
        }


{-| Default configuration of a filter chip
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
setAdditionalAttributes : List (Html.Attribute msg) -> Config msg -> Config msg
setAdditionalAttributes additionalAttributes (Config config_) =
    Config { config_ | additionalAttributes = additionalAttributes }


{-| Specify a message when the user clicks on a chip
-}
setOnClick : msg -> Config msg -> Config msg
setOnClick onClick (Config config_) =
    Config { config_ | onClick = Just onClick }


{-| Filter chip type
-}
type Chip msg
    = Chip (Html msg)


{-| Filter chip view function
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
            (List.filterMap identity
                [ filterLeadingIconElt config_
                , checkmarkElt
                ]
                ++ [ textElt label ]
            )


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


leadingIconElt : Config msg -> Maybe (Html msg)
leadingIconElt (Config { icon }) =
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


filterLeadingIconElt : Config msg -> Maybe (Html msg)
filterLeadingIconElt (Config { icon, selected }) =
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


chipSetRootCs : Html.Attribute msg
chipSetRootCs =
    class "mdc-chip-set"


filterCs : Html.Attribute msg
filterCs =
    class "mdc-chip-set--filter"
