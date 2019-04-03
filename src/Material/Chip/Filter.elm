module Material.Chip.Filter exposing (Config, filterChip, filterChipConfig)

import Html exposing (Html, text)
import Html.Attributes exposing (class)
import Html.Events
import Json.Decode as Decode
import Svg
import Svg.Attributes


type alias Config msg =
    { icon : Maybe String
    , selected : Bool
    , additionalAttributes : List (Html.Attribute msg)
    , onClick : Maybe msg
    }


filterChipConfig : Config msg
filterChipConfig =
    { icon = Nothing
    , selected = False
    , additionalAttributes = []
    , onClick = Nothing
    }


filterChip : Config msg -> String -> Html msg
filterChip config label =
    Html.node "mdc-chip"
        (List.filterMap identity
            [ rootCs

            -- , selectedCs config
            , selectedAttr config
            , clickHandler config
            ]
            ++ config.additionalAttributes
        )
        (List.filterMap identity
            [ leadingIconElt config
            , checkmarkElt
            , textElt label
            ]
        )


rootCs : Maybe (Html.Attribute msg)
rootCs =
    Just (class "mdc-chip")


selectedCs : Config msg -> Maybe (Html.Attribute msg)
selectedCs { selected } =
    if selected then
        Just (class "mdc-chip--selected")

    else
        Nothing


selectedAttr : Config msg -> Maybe (Html.Attribute msg)
selectedAttr { selected } =
    if selected then
        Just (Html.Attributes.attribute "selected" "")

    else
        Nothing


clickHandler : Config msg -> Maybe (Html.Attribute msg)
clickHandler config =
    Maybe.map (Html.Events.on "MDCChip:interaction" << Decode.succeed) config.onClick


textElt : String -> Maybe (Html msg)
textElt label =
    Just (Html.div [ class "mdc-chip__text" ] [ text label ])


leadingIconElt : Config msg -> Maybe (Html msg)
leadingIconElt { icon, selected } =
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
