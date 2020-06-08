module Material.Chip.Choice.Internal exposing (Chip(..), Config(..))

import Html


type Config msg
    = Config
        { icon : Maybe String
        , additionalAttributes : List (Html.Attribute msg)
        }


type Chip a msg
    = Chip (Config msg) a
