module Material.Chip exposing (Config, Icon(..), chip, chipConfig)

import Html exposing (Html, text)
import Html.Attributes exposing (class)


type alias Config msg =
    { icon : Maybe Icon
    , active : Bool
    , additionalAttributes : List (Html.Attribute msg)
    }


type Icon
    = LeadingIcon String
    | TrailingIcon String


chipConfig : Config msg
chipConfig =
    { icon = Nothing
    , active = False
    , additionalAttributes = []
    }


chip : Config msg -> String -> Html msg
chip config label =
    Html.node "mdc-chip"
        (List.filterMap identity
            [ rootCs
            , activeCs config
            ]
        )
        (List.filterMap identity
            [ leadingIconElt config
            , labelElt label
            , trailingIconElt config
            ]
        )


rootCs : Maybe (Html.Attribute msg)
rootCs =
    Just (class "mdc-chip")


activeCs : Config msg -> Maybe (Html.Attribute msg)
activeCs { active } =
    if active then
        Just (class "mdc-chip--active")

    else
        Nothing


labelElt : String -> Maybe (Html msg)
labelElt label =
    Just (text label)


leadingIconElt : Config msg -> Maybe (Html msg)
leadingIconElt { icon } =
    case icon of
        Just (LeadingIcon iconName) ->
            Just
                (Html.i
                    [ class "material-icons mdc-chip__icon mdc-chip__icon--leading" ]
                    []
                )

        _ ->
            Nothing


trailingIconElt : Config msg -> Maybe (Html msg)
trailingIconElt { icon } =
    case icon of
        Just (TrailingIcon iconName) ->
            Just
                (Html.i
                    [ class "material-icons mdc-chip__icon mdc-chip__icon--trailing" ]
                    []
                )

        _ ->
            Nothing
