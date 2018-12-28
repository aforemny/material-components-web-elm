module Material.Icon exposing (Config, icon, iconConfig)

import Html exposing (Html, text)
import Html.Attributes exposing (class)


type alias Config msg =
    { additionalAttributes : List (Html.Attribute msg)
    }


iconConfig : Config msg
iconConfig =
    { additionalAttributes = []
    }


icon : Config msg -> String -> Html msg
icon config iconName =
    Html.i (class "material-icons" :: config.additionalAttributes) [ text iconName ]
