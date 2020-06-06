module Material.Button.Internal exposing (Config(..))

import Html


type Config msg
    = Config
        { icon : Maybe String
        , trailingIcon : Bool
        , disabled : Bool
        , dense : Bool
        , href : Maybe String
        , target : Maybe String
        , additionalAttributes : List (Html.Attribute msg)
        , onClick : Maybe msg
        , touch : Bool
        }
