module Material.IconButton exposing
    ( Config, config
    , setOnClick
    , setDisabled
    , setLabel
    , setAttributes
    , setMenu
    , iconButton
    , Icon, icon
    , customIcon
    , svgIcon
    , Menu, menu
    )

{-| Icon buttons allow users to take actions and make choices with a single
tap.


# Table of Contents

  - [Resources](#resources)
  - [Basic Usage](#basic-usage)
  - [Configuration](#configuration)
      - [Configuration Options](#configuration-options)
  - [Icon Button](#icon-button)
  - [Disabled Icon Button](#disabled-icon-button)
  - [Labeled Icon Button](#labeled-icon-button)
  - [Icon Button with Custom Icon](#icon-button-with-custom-icon)
  - [Focus an Icon Button](#focus-an-icon-button)
  - [Icon Button with Menu](#icon-button-with-menu)


# Resources

  - [Demo: Icon buttons](https://aforemny.github.io/material-components-web-elm/#icon-button)
  - [Material Design Guidelines: Toggle buttons](https://material.io/go/design-buttons#toggle-button)
  - [MDC Web: Icon Button](https://github.com/material-components/material-components-web/tree/master/packages/mdc-icon-button)
  - [Sass Mixins (MDC Web)](https://github.com/material-components/material-components-web/tree/master/packages/mdc-icon-button#sass-mixins)


# Basic Usage

    import Material.IconButton as IconButton

    type Msg
        = Clicked

    main =
        IconButton.iconButton
            (IconButton.config |> IconButton.setOnClick Clicked)
            (IconButton.icon "favorite")


# Configuration

@docs Config, config


## Configuration Options

@docs setOnClick
@docs setDisabled
@docs setLabel
@docs setAttributes
@docs setMenu


# Icon Button

@docs iconButton


# Disabled Icon Button

To disable an icon button, set its `setDisabled` configuration option to
`True`. Disabled icon buttons cannot be interacted with and have no visual
interaction effect.

    IconButton.iconButton
        (IconButton.config |> IconButton.setDisabled True)
        (IconButton.icon "favorite")


# Labeled Icon Button

To set the HTML attribute `arial-label` of a icon button, use its `setLabel`
configuration option.

    IconButton.iconButton
        (IconButton.config
            |> IconButton.setLabel (Just "Add to favorites")
        )
        (IconButton.icon "favorite")


# Icon Button with Custom Icon

This library natively supports [Material Icons](https://material.io/icons).
However, you may also include SVG or custom icons such as FontAwesome.

@docs Icon, icon
@docs customIcon
@docs svgIcon


# Focus an Icon Button

You may programatically focus an icon button by assigning an id attribute to it
and use `Browser.Dom.focus`.

    IconButton.iconButton
        (IconButton.config
            |> IconButton.setAttributes
                [ Html.Attributes.id "my-icon-button" ]
        )
        (IconButton.icon "wifi")


# Icon Button with Menu

Icon buttons support opening a menu.

    IconButton.iconButton
        (IconButton.config
            |> IconButton.setOnClick (OpenChanged True)
            |> IconButton.setMenu
                (Just <|
                    IconButton.menu
                        (Menu.config
                            |> Menu.setOpen True
                            |> Menu.setOnClose (OpenChanged False)
                        )
                        [ List.list
                            (List.config |> List.setWrapFocus True)
                            (ListItem.listItem
                                (ListItem.config
                                    |> ListItem.setOnClick (OpenChanged False)
                                )
                                [ text "Orange" ]
                            )
                            [ ListItem.listItem
                                (ListItem.config
                                    |> ListItem.setOnClick (OpenChanged False)
                                )
                                [ text "Guava" ]
                            ]
                        ]
                )
        )
        (IconButton.icon "menu_vert")

@docs Menu, menu

-}

import Html exposing (Html, text)
import Html.Attributes exposing (class)
import Html.Events
import Material.IconButton.Internal exposing (Config(..), Icon(..), Menu(..))
import Material.Menu as Menu
import Svg
import Svg.Attributes


{-| Icon button configuration
-}
type alias Config msg =
    Material.IconButton.Internal.Config msg


{-| Default icon button configuration
-}
config : Config msg
config =
    Config
        { disabled = False
        , label = Nothing
        , additionalAttributes = []
        , onClick = Nothing
        , menu = Nothing
        }


{-| Specify whether an icon button is disabled

Disabled icon buttons cannot be interacted with and have no visual interaction
effect.

-}
setDisabled : Bool -> Config msg -> Config msg
setDisabled disabled (Config config_) =
    Config { config_ | disabled = disabled }


{-| Specify an icon button's HTML5 arial-label attribute
-}
setLabel : Maybe String -> Config msg -> Config msg
setLabel label (Config config_) =
    Config { config_ | label = label }


{-| Specify additional attributes
-}
setAttributes : List (Html.Attribute msg) -> Config msg -> Config msg
setAttributes additionalAttributes (Config config_) =
    Config { config_ | additionalAttributes = additionalAttributes }


{-| Specify a message when the user clicks on an icon button
-}
setOnClick : msg -> Config msg -> Config msg
setOnClick onClick (Config config_) =
    Config { config_ | onClick = Just onClick }


{-| Specify a menu to attach to the icon button

The icon button is set as the menu's anchor, however opening the menu still
requires the use of `Menu.setOpen`.

-}
setMenu : Maybe (Menu msg) -> Config msg -> Config msg
setMenu menu_ (Config config_) =
    Config { config_ | menu = menu_ }


{-| Menu type
-}
type alias Menu msg =
    Material.IconButton.Internal.Menu msg


{-| Construct a [menu](Material-Menu) to be used with an icon button.
-}
menu : Menu.Config msg -> List (Html msg) -> Menu msg
menu config_ nodes =
    Menu config_ nodes


{-| Icon button view function
-}
iconButton : Config msg -> Icon -> Html msg
iconButton ((Config ({ additionalAttributes } as innerConfig)) as config_) icon_ =
    let
        wrapMenu node =
            case innerConfig.menu of
                Nothing ->
                    node

                Just (Menu menuConfig menuNodes) ->
                    Html.div [ Menu.surfaceAnchor ]
                        [ node, Menu.menu menuConfig menuNodes ]
    in
    Html.node "mdc-icon-button"
        (List.filterMap identity
            [ rootCs
            , tabIndexProp
            , clickHandler config_
            ]
            ++ additionalAttributes
        )
        [ Html.map never <|
            case icon_ of
                Icon { node, attributes, nodes } ->
                    node (class "mdc-icon-button__icon" :: attributes) nodes

                SvgIcon { node, attributes, nodes } ->
                    node (Svg.Attributes.class "mdc-icon-button__icon" :: attributes)
                        nodes
        ]
        |> wrapMenu


rootCs : Maybe (Html.Attribute msg)
rootCs =
    Just (class "mdc-icon-button")


tabIndexProp : Maybe (Html.Attribute msg)
tabIndexProp =
    Just (Html.Attributes.tabindex 0)


clickHandler : Config msg -> Maybe (Html.Attribute msg)
clickHandler (Config { onClick }) =
    Maybe.map Html.Events.onClick onClick


{-| Icon type
-}
type alias Icon =
    Material.IconButton.Internal.Icon


{-| Material Icon

    IconButton.iconButton IconButton.config
        (IconButton.icon "favorite")

-}
icon : String -> Icon
icon iconName =
    customIcon Html.i [ class "material-icons" ] [ text iconName ]


{-| Custom icon

    IconButton.iconButton IconButton.config
        (IconButton.customIcon Html.i
            [ class "fab fa-font-awesome" ]
            []
        )

-}
customIcon :
    (List (Html.Attribute Never) -> List (Html Never) -> Html Never)
    -> List (Html.Attribute Never)
    -> List (Html Never)
    -> Icon
customIcon node attributes nodes =
    Icon { node = node, attributes = attributes, nodes = nodes }


{-| SVG icon

    IconButton.iconButton IconButton.config
        (IconButton.svgIcon
            [ Svg.Attributes.viewBox "…" ]
            [-- …
            ]
        )

-}
svgIcon : List (Html.Attribute Never) -> List (Html Never) -> Icon
svgIcon attributes nodes =
    SvgIcon { node = Svg.svg, attributes = attributes, nodes = nodes }
