module Material.Icon exposing (icon)

{-| Icon renders a Material Icon.


# Table of Contents

  - [Resources](#resources)
  - [Basic Usage](#basic-usage)
  - [Icon](#icon)


# Resources

  - [Material Icons](https://material.io/tools/icons/)


# Basic Usage

    import Material.Icon as Icon

    main =
        Icon.icon [] "favorite"


# Icon

@docs icon

-}

import Html exposing (Html, text)
import Html.Attributes exposing (class)


{-| Icon view function
-}
icon : List (Html.Attribute msg) -> String -> Html msg
icon additionalAttributes iconName =
    Html.i (class "material-icons" :: additionalAttributes) [ text iconName ]
