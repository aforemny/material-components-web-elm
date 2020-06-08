module Material.Chip.Action.Internal exposing (Chip(..), Config(..))

import Html


type Config msg
    = Config
        { icon : Maybe String
        , additionalAttributes : List (Html.Attribute msg)
        , onClick : Maybe msg
        }


type Chip msg
    = Chip (Config msg) String
