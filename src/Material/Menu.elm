module Material.Menu exposing (Config, menu, menuConfig, menuSurfaceAnchor)

import Html exposing (Html, text)
import Html.Attributes exposing (class)
import Html.Events
import Json.Decode as Decode


type alias Config msg =
    { open : Bool
    , quickOpen : Bool
    , additionalAttributes : List (Html.Attribute msg)
    , onClose : Maybe msg
    }


menuConfig : Config msg
menuConfig =
    { open = False
    , quickOpen = False
    , additionalAttributes = []
    , onClose = Nothing
    }


menu : Config msg -> List (Html msg) -> Html msg
menu config nodes =
    Html.node "mdc-menu"
        (List.filterMap identity
            [ rootCs
            , openAttr config
            , quickOpenAttr config
            , closeHandler config
            ]
            ++ config.additionalAttributes
        )
        nodes


menuSurfaceAnchor : Html.Attribute msg
menuSurfaceAnchor =
    class "mdc-menu-surface--anchor"


rootCs : Maybe (Html.Attribute msg)
rootCs =
    Just (class "mdc-menu mdc-menu-surface")


openAttr : Config msg -> Maybe (Html.Attribute msg)
openAttr { open } =
    if open then
        Just (Html.Attributes.attribute "open" "")

    else
        Nothing


quickOpenAttr : Config msg -> Maybe (Html.Attribute msg)
quickOpenAttr { quickOpen } =
    if quickOpen then
        Just (Html.Attributes.attribute "quickopen" "")

    else
        Nothing


closeHandler : Config msg -> Maybe (Html.Attribute msg)
closeHandler { onClose } =
    Maybe.map (Html.Events.on "MDCMenu:close" << Decode.succeed) onClose
