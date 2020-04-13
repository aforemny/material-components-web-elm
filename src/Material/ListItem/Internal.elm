module Material.ListItem.Internal exposing
    ( Config(..)
    , ListItem(..)
    )

import Html exposing (Html, text)
import Html.Attributes exposing (class)
import Html.Events
import Json.Decode as Decode
import Json.Encode as Encode


type Config msg
    = Config
        { disabled : Bool
        , selected : Bool
        , activated : Bool
        , href : Maybe String
        , target : Maybe String
        , additionalAttributes : List (Html.Attribute msg)
        , onClick : Maybe msg
        , node : Html msg
        }


type ListItem msg
    = ListItem (Config msg)
    | ListItemDivider (Html msg)
    | ListGroupSubheader (Html msg)
