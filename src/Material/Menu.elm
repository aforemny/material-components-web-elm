module Material.Menu exposing
    ( menu, menuConfig, MenuConfig
    , menuSurfaceAnchor
    )

{-| A menu displays a list of choices on a temporary surface. They appear when
users interact with a button, action, or other control.


# Table of Contents

  - [Resources](#resources)
  - [Basic usage](#basic-usage)
  - [Quick-opening menu](#quick-opening-menu)


# Resources

  - [Demo: Menus](https://aforemny.github.io/material-components-web-elm/#menus)
  - [Material Design Guidelines: Menus](https://material.io/go/design-menus)
  - [MDC Web: Menu](https://github.com/material-components/material-components-web/tree/master/packages/mdc-menu)
  - [Sass Mixins (MDC Web)](https://github.com/material-components/material-components-web/tree/master/packages/mdc-menu#sass-mixins)


# Basic usage

A menu is usually tied to an element that opens it, such as a button. For
positioning, wrap the button and the menu within an element that sets the
`menuSurfaceAnchor` attribute. The menu's items are simply a
[list](Material-List).

    import Material.Button exposing (textButton, buttonConfig)
    import Material.List
        exposing
            ( list
            , listConfig
            , listItem
            , listItemConfig
            )
    import Material.Menu
        exposing
            ( menu
            , menuConfig
            , menuSurfaceAnchor
            )

    type Msg
        = MenuOpened
        | MenuClosed

    Html.div [ menuSurfaceAnchor ]
        [ textButton
            { buttonConfig | onClick = Just MenuOpened }
            "Open menu"
        , menu
            { menuConfig
                | open = True
                , onClose = Just MenuClosed
            }
            [ list { listConfig | wrapFocus = True }
                [ listItem menuItemConfig [ text "Menu item" ]
                , listItem menuItemConfig [ text "Menu item" ]
                ]
            ]
        ]

@docs menu, menuConfig, MenuConfig
@docs menuSurfaceAnchor


# Quick-opening menu

A menu may not show a transition when opening by setting its `quickOpen`
configuration field to `True`.

    menu { menuConfig | quickOpen = True } []

-}

import Html exposing (Html, text)
import Html.Attributes exposing (class)
import Html.Events
import Json.Decode as Decode
import Json.Encode as Encode


{-| Configuration of a menu
-}
type alias MenuConfig msg =
    { open : Bool
    , quickOpen : Bool
    , additionalAttributes : List (Html.Attribute msg)
    , onClose : Maybe msg
    }


{-| Default configuration of a menu
-}
menuConfig : MenuConfig msg
menuConfig =
    { open = False
    , quickOpen = False
    , additionalAttributes = []
    , onClose = Nothing
    }


{-| Menu view function
-}
menu : MenuConfig msg -> List (Html msg) -> Html msg
menu config nodes =
    Html.node "mdc-menu"
        (List.filterMap identity
            [ rootCs
            , openProp config
            , quickOpenProp config
            , closeHandler config
            ]
            ++ config.additionalAttributes
        )
        nodes


{-| Menu surface anchor attribute
-}
menuSurfaceAnchor : Html.Attribute msg
menuSurfaceAnchor =
    class "mdc-menu-surface--anchor"


rootCs : Maybe (Html.Attribute msg)
rootCs =
    Just (class "mdc-menu mdc-menu-surface")


openProp : MenuConfig msg -> Maybe (Html.Attribute msg)
openProp { open } =
    Just (Html.Attributes.property "open" (Encode.bool open))


quickOpenProp : MenuConfig msg -> Maybe (Html.Attribute msg)
quickOpenProp { quickOpen } =
    Just (Html.Attributes.property "quickOpen" (Encode.bool quickOpen))


closeHandler : MenuConfig msg -> Maybe (Html.Attribute msg)
closeHandler { onClose } =
    Maybe.map (Html.Events.on "MDCMenu:close" << Decode.succeed) onClose
