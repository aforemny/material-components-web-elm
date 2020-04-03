module Material.Checkbox.Internal exposing (Config(..), State(..))

import Html


type Config msg
    = Config
        { state : State
        , disabled : Bool
        , additionalAttributes : List (Html.Attribute msg)
        , onChange : Maybe msg
        }


type State
    = Unchecked
    | Checked
    | Indeterminate
