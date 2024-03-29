module Material.List.Item.Internal exposing
    ( Config(..)
    , ListItem(..)
    , Selection(..)
    )

import Html exposing (Html)


type Config msg
    = Config
        { disabled : Bool
        , selection : Maybe Selection
        , href : Maybe String
        , target : Maybe String
        , additionalAttributes : List (Html.Attribute msg)
        , onClick : Maybe msg
        , ripples : Bool
        , interactive : Bool
        }


type Selection
    = Selected
    | Activated


type ListItem msg
    = ListItem (Config msg -> Html msg) (Config msg)
    | ListItemDivider (Html msg)
    | ListGroupSubheader (Html msg)
