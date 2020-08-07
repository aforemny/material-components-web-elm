module Material.Chip.Choice.Internal exposing (Chip(..), Config(..), Icon(..))

import Html exposing (Html)
import Svg exposing (Svg)


type Config msg
    = Config
        { icon : Maybe Icon
        , additionalAttributes : List (Html.Attribute msg)
        }


type Chip a msg
    = Chip (Config msg) a


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
