module Material.IconButton.Internal exposing (Config(..))

import Html


type Config msg
    = Config
        { disabled : Bool
        , label : Maybe String
        , additionalAttributes : List (Html.Attribute msg)
        , onClick : Maybe msg
        }
