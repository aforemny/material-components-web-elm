module Material.IconButton exposing (Config, iconButton, iconButtonConfig)

import Html exposing (Html, text)
import Html.Attributes exposing (class)
import Html.Events


type alias Config msg =
    { on : Bool
    , additionalAttributes : List (Html.Attribute msg)
    , onClick : Maybe msg
    }


iconButtonConfig : Config msg
iconButtonConfig =
    { on = False
    , additionalAttributes = []
    , onClick = Nothing
    }


iconButton : Config msg -> String -> Html msg
iconButton config iconName =
    Html.node "mdc-icon-button"
        (List.filterMap identity
            [ rootCs
            , roleAttr
            , tabIndexAttr
            , clickHandler config
            ]
            ++ config.additionalAttributes
        )
        [ text iconName ]


rootCs : Maybe (Html.Attribute msg)
rootCs =
    Just (class "mdc-icon-button material-icons")


roleAttr : Maybe (Html.Attribute msg)
roleAttr =
    Just (Html.Attributes.attribute "role" "button")


tabIndexAttr : Maybe (Html.Attribute msg)
tabIndexAttr =
    Just (Html.Attributes.tabindex 0)


clickHandler : Config msg -> Maybe (Html.Attribute msg)
clickHandler config =
    Maybe.map Html.Events.onClick config.onClick
