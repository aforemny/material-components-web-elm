module Material.ChipSet exposing (Config, Variant(..), chipSet, chipSetConfig)

import Html exposing (Html, text)
import Html.Attributes exposing (class)


type alias Config msg =
    { variant : Variant
    , additionalAttributes : List (Html.Attribute msg)
    }


chipSetConfig : Config msg
chipSetConfig =
    { variant = Default
    , additionalAttributes = []
    }


type Variant
    = Default
    | Choice
    | Filter
    | Input


chipSet : Config msg -> List (Html msg) -> Html msg
chipSet config chips =
    Html.node "mdc-chip-set"
        (List.filterMap identity
            [ rootCs
            , variantCs config
            ]
        )
        chips


rootCs : Maybe (Html.Attribute msg)
rootCs =
    Just (class "mdc-chip-set")


variantCs : Config msg -> Maybe (Html.Attribute msg)
variantCs config =
    case config.variant of
        Default ->
            Nothing

        Choice ->
            Just (class "mdc-chip-set--choice")

        Filter ->
            Just (class "mdc-chip-set--filter")

        Input ->
            Just (class "mdc-chip-set--input")
