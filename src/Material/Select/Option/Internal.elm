module Material.Select.Option.Internal exposing
    ( Config(..)
    , SelectOption(..)
    )

import Html exposing (Html, text)
import Html.Attributes exposing (class)
import Html.Events
import Json.Decode as Decode
import Json.Encode as Encode


type Config msg
    = Config
        { disabled : Bool
        , value : Maybe String
        , additionalAttributes : List (Html.Attribute msg)
        , nodes : List (Html msg)
        }


type SelectOption msg
    = SelectOption (Config msg)
