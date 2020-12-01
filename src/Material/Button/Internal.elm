module Material.Button.Internal exposing (Config(..), Icon(..))

import Html exposing (Html)
import Svg exposing (Svg)


type Config msg
    = Config
        { icon : Maybe Icon
        , trailingIcon : Bool
        , disabled : Bool
        , dense : Bool
        , href : Maybe String
        , target : Maybe String
        , additionalAttributes : List (Html.Attribute msg)
        , onClick : Maybe msg
        , touch : Bool
        }


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
