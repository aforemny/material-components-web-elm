module Material.Fab.Extended exposing (ExtendedFabConfig, extendedFab, extendedFabConfig)

import Html exposing (Html, text)
import Html.Attributes exposing (class)


type alias ExtendedFabConfig msg =
    { icon : Maybe String
    , trailingIcon : Bool
    , exited : Bool
    , additionalAttributes : List (Html.Attribute msg)
    }


extendedFabConfig : ExtendedFabConfig msg
extendedFabConfig =
    { icon = Nothing
    , trailingIcon = False
    , exited = False
    , additionalAttributes = []
    }


extendedFab : ExtendedFabConfig msg -> String -> Html msg
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


exitedCs : ExtendedFabConfig msg -> Maybe (Html.Attribute msg)
exitedCs { exited } =
    if exited then
        Just (class "mdc-fab--exited")

    else
        Nothing


leadingIconElt : ExtendedFabConfig msg -> Maybe (Html msg)
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


trailingIconElt : ExtendedFabConfig msg -> Maybe (Html msg)
trailingIconElt { icon, trailingIcon } =
    case ( icon, trailingIcon ) of
        ( Just iconName, True ) ->
            Just
                (Html.span [ class "material-icons", class "mdc-fab__icon" ]
                    [ text iconName ]
                )

        _ ->
            Nothing
