module Material.Icon exposing (icon, iconConfig, IconConfig)

{-| Icons render a Material Icon.


# Table of Contents

  - [Resources](#resources)
  - [Basic Usage](#basic-usage)
  - [Icon](#icon)


# Resources

  - [Material Icons](https://material.io/tools/icons/)


# Basic Usage

    import Material.Icon exposing (icon, iconConfig)

    main =
        icon iconConfig "favorite"


# Icon

@docs icon, iconConfig, IconConfig

-}

import Html exposing (Html, text)
import Html.Attributes exposing (class)


{-| Icon configuration
-}
type alias IconConfig msg =
    { additionalAttributes : List (Html.Attribute msg) }


{-| Default icon configuration
-}
iconConfig : IconConfig msg
iconConfig =
    { additionalAttributes = [] }


{-| Icon view helper
-}
icon : IconConfig msg -> String -> Html msg
icon config iconName =
    Html.i (class "material-icons" :: config.additionalAttributes) [ text iconName ]
