module Material.Tab.Internal exposing
    ( Config(..)
    , Content
    , Icon(..)
    , Tab(..)
    )

import Html exposing (Html)
import Svg exposing (Svg)


type Config msg
    = Config
        { active : Bool
        , additionalAttributes : List (Html.Attribute msg)
        , onClick : Maybe msg
        , content : Content
        }


type alias Content =
    { label : String
    , icon : Maybe Icon
    }


type Tab msg
    = Tab (Config msg)


type Icon
    = Icon
        { node : List (Html.Attribute Never) -> List (Html Never) -> Html Never
        , attributes : List (Html.Attribute Never)
        , nodes : List (Html Never)
        }
    | SvgIcon
        { node : List (Svg.Attribute Never) -> List (Svg Never) -> Svg Never
        , attributes : List (Svg.Attribute Never)
        , nodes : List (Svg Never)
        }
