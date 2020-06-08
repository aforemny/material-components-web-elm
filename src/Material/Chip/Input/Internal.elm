module Material.Chip.Input.Internal exposing (Chip(..), Config(..))

import Html


type Config msg
    = Config
        { leadingIcon : Maybe String
        , trailingIcon : Maybe String
        , additionalAttributes : List (Html.Attribute msg)
        , onClick : Maybe msg
        , onDelete : Maybe msg
        }


type Chip msg
    = Chip (Config msg) String
