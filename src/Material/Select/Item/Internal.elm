module Material.Select.Item.Internal exposing (Config(..), SelectItem(..))

import Html exposing (Html)


type Config a msg
    = Config
        { value : a
        , disabled : Bool
        , additionalAttributes : List (Html.Attribute msg)
        }


type SelectItem a msg
    = SelectItem (Config a msg) String
