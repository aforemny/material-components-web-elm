module Material.Icon exposing (IconConfig, icon, iconConfig)

import Html exposing (Html, text)
import Html.Attributes exposing (class)


type alias IconConfig msg =
    { additionalAttributes : List (Html.Attribute msg)
    }


iconConfig : IconConfig msg
iconConfig =
    { additionalAttributes = []
    }


icon : IconConfig msg -> String -> Html msg
icon config iconName =
    Html.i (class "material-icons" :: config.additionalAttributes) [ text iconName ]
