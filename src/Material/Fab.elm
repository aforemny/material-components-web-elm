module Material.Fab exposing (Config, fab, fabConfig)

import Html exposing (Html, text)
import Html.Attributes exposing (class)


type alias Config msg =
    { mini : Bool
    , exited : Bool
    , additionalAttributes : List (Html.Attribute msg)
    }


fabConfig : Config msg
fabConfig =
    { mini = False
    , exited = False
    , additionalAttributes = []
    }


fab : Config msg -> String -> Html msg
fab config iconName =
    Html.node "mdc-fab"
        (List.filterMap identity
            [ rootCs
            , miniCs config
            , exitedCs config
            ]
            ++ config.additionalAttributes
        )
        [ iconElt iconName
        ]


rootCs : Maybe (Html.Attribute msg)
rootCs =
    Just (class "mdc-fab")


miniCs : Config msg -> Maybe (Html.Attribute msg)
miniCs { mini } =
    if mini then
        Just (class "mdc-fab--mini")

    else
        Nothing


exitedCs : Config msg -> Maybe (Html.Attribute msg)
exitedCs { exited } =
    if exited then
        Just (class "mdc-fab--exited")

    else
        Nothing


iconElt : String -> Html msg
iconElt iconName =
    Html.span [ class "material-icons", class "mdc-fab__icon" ] [ text iconName ]
