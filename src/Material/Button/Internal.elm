module Material.Button.Internal exposing (Config(..), Icon(..), Menu(..))

import Html exposing (Html)
import Material.Menu as Menu
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
        , menu : Maybe (Menu msg)
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


type Menu msg
    = Menu (Menu.Config msg) (List (Html msg))
