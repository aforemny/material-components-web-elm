module Material.Icon exposing
    ( IconConfig, iconConfig
    , icon
    )

{-|

@docs IconConfig, iconConfig
@docs icon

-}

import Html exposing (Html, text)
import Html.Attributes exposing (class)


{-| TODO docs
-}
type alias IconConfig msg =
    { additionalAttributes : List (Html.Attribute msg)
    }


{-| TODO docs
-}
iconConfig : IconConfig msg
iconConfig =
    { additionalAttributes = []
    }


{-| TODO docs
-}
icon : IconConfig msg -> String -> Html msg
icon config iconName =
    Html.i (class "material-icons" :: config.additionalAttributes) [ text iconName ]
