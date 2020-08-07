module Material.IconButton.Internal exposing (Config(..), Icon(..))

import Html exposing (Html)
import Svg exposing (Svg)


type Config msg
    = Config
        { disabled : Bool
        , label : Maybe String
        , additionalAttributes : List (Html.Attribute msg)
        , onClick : Maybe msg
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
