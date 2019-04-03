module Material.Fab.Extended exposing (Config, extendedFab, extendedFabConfig)

import Html exposing (Html, text)
import Html.Attributes exposing (class)


type alias Config msg =
    { icon : Maybe String
    , trailingIcon : Bool
    , exited : Bool
    , additionalAttributes : List (Html.Attribute msg)
    }


extendedFabConfig : Config msg
extendedFabConfig =
    { icon = Nothing
    , trailingIcon = False
    , exited = False
    , additionalAttributes = []
    }


extendedFab : Config msg -> String -> Html msg
extendedFab config label =
    Html.node "mdc-fab"
        (List.filterMap identity
            [ rootCs
            , exitedCs config
            ]
            ++ config.additionalAttributes
        )
        (List.filterMap identity
            [ leadingIconElt config
            , labelElt label
            , trailingIconElt config
            ]
        )


rootCs : Maybe (Html.Attribute msg)
rootCs =
    Just (class "mdc-fab mdc-fab--extended")


exitedCs : Config msg -> Maybe (Html.Attribute msg)
exitedCs { exited } =
    if exited then
        Just (class "mdc-fab--exited")

    else
        Nothing


leadingIconElt : Config msg -> Maybe (Html msg)
leadingIconElt { icon, trailingIcon } =
    case ( icon, trailingIcon ) of
        ( Just iconName, False ) ->
            Just
                (Html.span [ class "material-icons", class "mdc-fab__icon" ]
                    [ text iconName ]
                )

        _ ->
            Nothing


labelElt : String -> Maybe (Html msg)
labelElt label =
    Just (Html.span [ class "mdc-fab__label" ] [ text label ])


trailingIconElt : Config msg -> Maybe (Html msg)
trailingIconElt { icon, trailingIcon } =
    case ( icon, trailingIcon ) of
        ( Just iconName, True ) ->
            Just
                (Html.span [ class "material-icons", class "mdc-fab__icon" ]
                    [ text iconName ]
                )

        _ ->
            Nothing
