module Material.Menu exposing
    ( Config, config
    , setOnClose
    , setOpen
    , setQuickOpen
    , setAdditionalAttributes
    , menu, surfaceAnchor
    )

{-| A menu displays a list of choices on a temporary surface. They appear when
users interact with a button, action, or other control.


# Table of Contents

  - [Resources](#resources)
  - [Basic usage](#basic-usage)
  - [Configuration](#configuration)
      - [Configuration Options](#configuration-options)
  - [Menu](#menu)
  - [Quick-opening menu](#quick-opening-menu)


# Resources

  - [Demo: Menus](https://aforemny.github.io/material-components-web-elm/#menu)
  - [Material Design Guidelines: Menus](https://material.io/go/design-menus)
  - [MDC Web: Menu](https://github.com/material-components/material-components-web/tree/master/packages/mdc-menu)
  - [Sass Mixins (MDC Web)](https://github.com/material-components/material-components-web/tree/master/packages/mdc-menu#sass-mixins)


# Basic usage

A menu is usually tied to an element that opens it, such as a button. For
positioning, wrap the button and the menu within an element that sets the
`surfaceAnchor` attribute. The menu's items are simply a
[list](Material-List).

    import Material.Button as Button
    import Material.List as List
    import Material.ListItem as ListItem
    import Material.Menu as Menu

    type Msg
        = MenuOpened
        | MenuClosed

    main =
        Html.div [ Menu.surfaceAnchor ]
            [ Button.text
                (Button.config
                    |> Button.setOnClick MenuOpened
                )
                "Open menu"
            , Menu.menu
                (Menu.config
                    |> Menu.setOpen
                    |> Menu.setOnClose MenuClosed
                )
                [ List.list
                    (List.config
                        |> List.setWrapFocus
                    )
                    [ ListItem.listItem ListItem.config
                        [ text "Menu item" ]
                    , ListItem.listItem ListItem.config
                        [ text "Menu item" ]
                    ]
                ]
            ]


# Configuration

@docs Config, config


## Configuration Options

@docs setOnClose
@docs setOpen
@docs setQuickOpen
@docs setAdditionalAttributes


# Menu

@docs menu, surfaceAnchor


# Quick-opening menu

A menu may not show a transition when opening by using its `setQuickOpen`
configuration option.

    Menu.menu (Menu.config |> Menu.setQuickOpen) []

-}

import Html exposing (Html, text)
import Html.Attributes exposing (class)
import Html.Events
import Json.Decode as Decode
import Json.Encode as Encode


{-| Configuration of a menu
-}
type Config msg
    = Config
        { open : Bool
        , quickOpen : Bool
        , additionalAttributes : List (Html.Attribute msg)
        , onClose : Maybe msg
        }


{-| Default configuration of a menu
-}
config : Config msg
config =
    Config
        { open = False
        , quickOpen = False
        , additionalAttributes = []
        , onClose = Nothing
        }


{-| Set a menu to be open
-}
setOpen : Config msg -> Config msg
setOpen (Config config_) =
    Config { config_ | open = True }


{-| Set a menu to open quickly, without showing a transition
-}
setQuickOpen : Config msg -> Config msg
setQuickOpen (Config config_) =
    Config { config_ | quickOpen = True }


{-| Specify a message when the user closes the menu
-}
setOnClose : msg -> Config msg -> Config msg
setOnClose onClose (Config config_) =
    Config { config_ | onClose = Just onClose }


{-| Specify additional attributes
-}
setAdditionalAttributes : List (Html.Attribute msg) -> Config msg -> Config msg
setAdditionalAttributes additionalAttributes (Config config_) =
    Config { config_ | additionalAttributes = additionalAttributes }


{-| Menu view function
-}
menu : Config msg -> List (Html msg) -> Html msg
menu ((Config { additionalAttributes }) as config_) nodes =
    Html.node "mdc-menu"
        (List.filterMap identity
            [ rootCs
            , openProp config_
            , quickOpenProp config_
            , closeHandler config_
            ]
            ++ additionalAttributes
        )
        nodes


{-| Menu surface anchor attribute
-}
surfaceAnchor : Html.Attribute msg
surfaceAnchor =
    class "mdc-menu-surface--anchor"


rootCs : Maybe (Html.Attribute msg)
rootCs =
    Just (class "mdc-menu mdc-menu-surface")


openProp : Config msg -> Maybe (Html.Attribute msg)
openProp (Config { open }) =
    Just (Html.Attributes.property "open" (Encode.bool open))


quickOpenProp : Config msg -> Maybe (Html.Attribute msg)
quickOpenProp (Config { quickOpen }) =
    Just (Html.Attributes.property "quickOpen" (Encode.bool quickOpen))


closeHandler : Config msg -> Maybe (Html.Attribute msg)
closeHandler (Config { onClose }) =
    Maybe.map (Html.Events.on "MDCMenu:close" << Decode.succeed) onClose
