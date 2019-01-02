module Material.Menu exposing (Config, menu, menuConfig)

import Html exposing (Html, text)
import Html.Attributes exposing (class)


type alias Config msg =
    { open : Bool
    , additionalAttributes : List (Html.Attribute msg)
    }


menuConfig : Config msg
menuConfig =
    { open = False
    , additionalAttributes = []
    }


menu : Config msg -> List (Html msg) -> Html msg
menu config nodes =
    Html.node "mdc-menu"
        (List.filterMap identity
            [ rootCs
            , openCs config
            ]
            ++ config.additionalAttributes
        )
        nodes


rootCs : Maybe (Html.Attribute msg)
rootCs =
    Just (class "mdc-menu mdc-menu-surface")


openCs : Config msg -> Maybe (Html.Attribute msg)
openCs { open } =
    if open then
        Just (class "mdc-menu-surface--open")

    else
        Nothing
