module Material.Icon exposing
    ( IconConfig, iconConfig
    , icon
    )

{-| Icons render an icon.

  - [Material Icons](https://material.io/tools/icons/)


# Example

    import Material.Icon exposing (icon, iconConfig)

    main =
        icon iconConfig "favorite"


# Configuration

@docs IconConfig, iconConfig
@docs icon

-}

import Html exposing (Html, text)
import Html.Attributes exposing (class)


{-| Icon configuration
-}
type alias IconConfig msg =
    { additionalAttributes : List (Html.Attribute msg)
    }


{-| Default icon configuration
-}
iconConfig : IconConfig msg
iconConfig =
    { additionalAttributes = []
    }


{-| Icon view helper
-}
icon : IconConfig msg -> String -> Html msg
icon config iconName =
    Html.i (class "material-icons" :: config.additionalAttributes) [ text iconName ]
