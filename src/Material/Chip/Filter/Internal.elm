module Material.Chip.Filter.Internal exposing (Chip(..), Config(..), Icon(..))

import Html exposing (Html)
import Svg exposing (Svg)


type Config msg
    = Config
        { icon : Maybe Icon
        , selected : Bool
        , additionalAttributes : List (Html.Attribute msg)
        , onChange : Maybe msg
        }


type Chip msg
    = Chip (Config msg) String


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
