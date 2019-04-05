module Material.Chip.Input exposing (InputConfig, inputChip, inputChipConfig)

import Html exposing (Html, text)
import Html.Attributes exposing (class)
import Html.Events
import Json.Decode as Decode


type alias InputConfig msg =
    { icon : String
    , additionalAttributes : List (Html.Attribute msg)
    , onClick : Maybe msg
    , onTrailingIconClick : Maybe msg
    }


inputChipConfig : InputConfig msg
inputChipConfig =
    { icon = "close"
    , additionalAttributes = []
    , onClick = Nothing
    , onTrailingIconClick = Nothing
    }


inputChip : InputConfig msg -> String -> Html msg
inputChip config label =
    Html.node "mdc-chip"
        (List.filterMap identity
            [ rootCs
            , clickHandler config
            , trailingIconClickHandler config
            ]
            ++ config.additionalAttributes
        )
        [ textElt label
        , trailingIconElt config
        ]


rootCs : Maybe (Html.Attribute msg)
rootCs =
    Just (class "mdc-chip")


clickHandler : InputConfig msg -> Maybe (Html.Attribute msg)
clickHandler config =
    Maybe.map (Html.Events.on "MDCChip:interaction" << Decode.succeed) config.onClick


trailingIconClickHandler : InputConfig msg -> Maybe (Html.Attribute msg)
trailingIconClickHandler config =
    Maybe.map (Html.Events.on "MDCChip:trailingIconInteraction" << Decode.succeed)
        config.onClick


textElt : String -> Html msg
textElt label =
    Html.div [ class "mdc-chip__text" ] [ text label ]


trailingIconElt : InputConfig msg -> Html msg
trailingIconElt { icon } =
    Html.i
        [ class "material-icons mdc-chip__icon mdc-chip__icon--trailing" ]
        [ text icon ]
