module Material.IconToggle exposing (Config, iconToggle, iconToggleConfig)

import Html exposing (Html, text)
import Html.Attributes exposing (class)


type alias Config msg =
    { on : Bool
    , additionalAttributes : List (Html.Attribute msg)
    }


iconToggleConfig : Config msg
iconToggleConfig =
    { on = False
    , additionalAttributes = []
    }


iconToggle : Config msg -> String -> Html msg
iconToggle config iconName =
    Html.node "mdc-icon-toggle"
        [ rootCs
        , roleAttr
        , tabIndexAttr
        ]
        [ text iconName ]


rootCs : Html.Attribute msg
rootCs =
    class "mdc-icon-toggle material-icons"


roleAttr : Html.Attribute msg
roleAttr =
    Html.Attributes.attribute "role" "button"


tabIndexAttr : Html.Attribute msg
tabIndexAttr =
    Html.Attributes.tabindex 0
