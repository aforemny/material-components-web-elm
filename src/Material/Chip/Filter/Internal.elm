module Material.Chip.Filter.Internal exposing (Chip(..), Config(..))

import Html


type Config msg
    = Config
        { icon : Maybe String
        , selected : Bool
        , additionalAttributes : List (Html.Attribute msg)
        , onChange : Maybe msg
        }


type Chip msg
    = Chip (Config msg) String
