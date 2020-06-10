module Material.Select.Option.Internal exposing
    ( Config(..)
    , SelectOption(..)
    )

import Html exposing (Html)


type Config msg
    = Config
        { disabled : Bool
        , value : Maybe String
        , additionalAttributes : List (Html.Attribute msg)
        , nodes : List (Html msg)
        }


type SelectOption msg
    = SelectOption (Config msg)
