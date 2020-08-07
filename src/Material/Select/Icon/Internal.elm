module Material.Select.Icon.Internal exposing (Icon(..))

import Html exposing (Html)
import Svg exposing (Svg)


type Icon msg
    = Icon
        { node : List (Html.Attribute msg) -> List (Html msg) -> Html msg
        , attributes : List (Html.Attribute msg)
        , nodes : List (Html msg)
        , onInteraction : Maybe msg
        , disabled : Bool
        }
    | SvgIcon
        { node : List (Svg.Attribute msg) -> List (Svg msg) -> Html msg
        , attributes : List (Svg.Attribute msg)
        , nodes : List (Svg msg)
        , onInteraction : Maybe msg
        , disabled : Bool
        }
