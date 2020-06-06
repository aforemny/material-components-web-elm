module Material.Checkbox.Internal exposing (Config(..), State(..))

import Html


type Config msg
    = Config
        { state : Maybe State
        , disabled : Bool
        , additionalAttributes : List (Html.Attribute msg)
        , onChange : Maybe msg
        , touch : Bool
        }


type State
    = Unchecked
    | Checked
    | Indeterminate
