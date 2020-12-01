module Material.TextField.Icon exposing
    ( Icon, icon
    , customIcon
    , svgIcon
    , setOnInteraction
    , setDisabled
    )

{-| Text field icons can either be leading or trailing icons, and can be purely
cosmetic or can be interacted with.


# Table of Contents

  - [Resources](#resources)
  - [Basic Usage](#basic-usage)
  - [Icon](#icon)
  - [Custom Icon](#custom-icon)
  - [SVG Icon](#svg-icon)
  - [Interactive Icon](#interactive-icon)
  - [Disabled Icon](#disabled-icon)


# Resources

  - [Demo: Text Fields](https://aforemny.github.io/material-components-web-elm/#text-field)
  - [Material Design Guidelines: Text Fields](https://material.io/components/text-fields/)
  - [MDC Web: Textfield](https://github.com/material-components/material-components-web/tree/master/packages/mdc-textfield)
  - [Sass Mixins (MDC Web)](https://github.com/material-components/material-components-web/tree/master/packages/mdc-textfield#sass-mixins)


# Basic Usage

    import Material.TextField as TextField
    import Material.TextField.Icon as TextFieldIcon

    type Msg
        = Interacted

    main =
        TextField.filled
            (TextField.config
                |> TextField.setLeadingIcon
                    (Just (TextFieldIcon.icon "favorite"))
                |> TextField.setTrailingIcon
                    (Just (TextFieldIcon.icon "favorite")
                        |> TextFieldIcon.setOnInteraction
                            Interacted
                    )
            )


# Icon

This library natively supports [Material Icons](https://material.io/icons).
However, you may also include SVG or custom icons such as FontAwesome.

@docs Icon, icon


# Custom Icon

@docs customIcon


# SVG Icon

@docs svgIcon


# Interactive Icon

To be able to interact with an icon, set its `setOnInteraction` configuration
option to the message that should be dispatched.

@docs setOnInteraction


# Disabled Icon

To disable an icon, set its `setDisabled` configuration option to `True`.

@docs setDisabled

-}

import Html exposing (Html, text)
import Html.Attributes exposing (class)
import Material.TextField.Icon.Internal exposing (Icon(..))
import Svg exposing (Svg)


{-| Icon type
-}
type alias Icon msg =
    Material.TextField.Icon.Internal.Icon msg


{-| Material Icon

    TextField.filled
        (TextField.config
            |> TextField.setLeadingIcon
                (Just (TextField.icon "favorite"))
        )

-}
icon : String -> Icon msg
icon iconName =
    customIcon Html.i [ class "material-icons" ] [ text iconName ]


{-| Custom icon

    TextField.raised
        (TextField.config
            |> TextField.setLeadingIcon
                (Just
                    (TextField.customIcon Html.i
                        [ class "fab fa-font-awesome" ]
                        []
                    )
                )
        )

-}
customIcon :
    (List (Html.Attribute msg) -> List (Html msg) -> Html msg)
    -> List (Html.Attribute msg)
    -> List (Html msg)
    -> Icon msg
customIcon node attributes nodes =
    Icon
        { node = node
        , attributes = attributes
        , nodes = nodes
        , onInteraction = Nothing
        , disabled = False
        }


{-| SVG icon

    TextField.raised
        (TextField.config
            |> TextField.setLeadingIcon
                (Just
                    (TextField.svgIcon
                        [ Svg.Attributes.viewBox "…" ]
                        [-- …
                        ]
                    )
                )
        )

-}
svgIcon : List (Svg.Attribute msg) -> List (Svg msg) -> Icon msg
svgIcon attributes nodes =
    SvgIcon
        { node = Svg.svg
        , attributes = attributes
        , nodes = nodes
        , onInteraction = Nothing
        , disabled = False
        }


{-| Specify a message when the user interacts with the icon

    TextFieldIcon.icon "favorite"
        |> TextFieldIcon.setOnInteraction Interacted

-}
setOnInteraction : msg -> Icon msg -> Icon msg
setOnInteraction onInteraction icon_ =
    case icon_ of
        Icon data ->
            Icon { data | onInteraction = Just onInteraction }

        SvgIcon data ->
            SvgIcon { data | onInteraction = Just onInteraction }


{-| Specify an icon to be disabled

Disabled icons cannot be interacted with and have no visual interaction
effect.

    TextFieldIcon.icon "favorite"
        |> TextFieldIcon.setDisabled True

-}
setDisabled : Bool -> Icon msg -> Icon msg
setDisabled disabled icon_ =
    case icon_ of
        Icon data ->
            Icon { data | disabled = disabled }

        SvgIcon data ->
            SvgIcon { data | disabled = disabled }
