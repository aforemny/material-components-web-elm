module Material.Tab.Internal exposing
    ( Config(..)
    , Content
    , Tab(..)
    )

import Html exposing (Html, text)
import Html.Attributes exposing (class)
import Html.Events
import Json.Decode as Decode
import Json.Encode as Encode


type Config msg
    = Config
        { active : Bool
        , additionalAttributes : List (Html.Attribute msg)
        , onClick : Maybe msg
        , content : Content
        }


type alias Content =
    { label : String
    , icon : Maybe String
    }


type Tab msg
    = Tab (Config msg)
