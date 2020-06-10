module Material.Checkbox.Internal exposing (Config(..), State(..))

import Html


type Config msg
    = Config
        { state : Maybe State
        , disabled : Bool
        , id : Maybe String
        , name : Maybe String
        , value : Maybe String
        , additionalAttributes : List (Html.Attribute msg)
        , onChange : Maybe msg
        }


type State
    = Unchecked
    | Checked
    | Indeterminate
