module Material.Tab exposing
    ( Config, config
    , setOnClick
    , setActive
    , setAttributes
    , Tab, tab, Content
    , icon, Icon
    , customIcon
    , svgIcon
    )

{-| Tabs organize and allow navigation between groups of content that are
related and at the same level of hierarchy. The tab bar contains the tab
components.

This module concerns the tab items. If you are looking for information about
the tab bar container, refer to [Material.TabBar](Material-TabBar).


# Table of Contents

  - [Resources](#resources)
  - [Basic Usage](#basic-usage)
  - [Configuration](#configuration)
      - [Configuration Options](#configuration-options)
  - [Tab](#tab)
  - [Active Tab](#active-tab)
  - [Tab with Custom Icon](#tab-with-custom-icon)


# Resources

  - [Demo: Tab Bar](https://aforemny.github.io/material-components-web-elm/#tabbar)
  - [Material Design Guidelines: Tabs](https://material.io/go/design-tabs)
  - MDC Web:
    [Tab Bar](https://github.com/material-components/material-components-web/tree/master/packages/mdc-tab-bar),
    [Tab](https://github.com/material-components/material-components-web/tree/master/packages/mdc-tab),
    [Tab Scroller](https://github.com/material-components/material-components-web/tree/master/packages/mdc-tab-scroller)
  - Sass Mixins:
    [Tab Bar](https://github.com/material-components/material-components-web/tree/master/packages/mdc-tab-bar#sass-mixins),
    [Tab](https://github.com/material-components/material-components-web/tree/master/packages/mdc-tab#sass-mixins),
    [Tab Scroller](https://github.com/material-components/material-components-web/tree/master/packages/mdc-tab-scroller#sass-mixins)


# Basic Usage

    import Material.Tab as Tab
    import Material.TabBar as TabBar

    type Msg
        = TabClicked Int

    main =
        TabBar.tabBar TabBar.config
            [ Tab.tab
                (Tab.config
                    |> Tab.setActive True
                    |> Tab.setOnClick (TabClicked 0)
                )
                { label = "Tab 1", icon = Nothing }
            , Tab.tab
                (Tab.config |> Tab.setOnClick (TabClicked 1))
                { label = "Tab 2", icon = Nothing }
            ]


# Configuration

@docs Config, config


## Configuration Options

@docs setOnClick
@docs setActive
@docs setAttributes


# Tab

@docs Tab, tab, Content
@docs icon, Icon


# Active Tab

To mark a tab as active, set its `setActive` configuration option to `True`.

    Tab.tab (Tab.config |> Tab.setActive True)


# Tab with Custom Icon

This library natively supports [Material Icon](https://material.io/icons),
however you may also include SVG or custom icons such as FontAwesome.

@docs customIcon
@docs svgIcon

-}

import Html exposing (Html, text)
import Html.Attributes exposing (class)
import Material.Tab.Internal exposing (Config(..), Icon(..), Tab(..))
import Svg exposing (Svg)


{-| Configuration of a tab
-}
type alias Config msg =
    Material.Tab.Internal.Config msg


{-| Default configuration of a tab
-}
config : Config msg
config =
    Config
        { active = False
        , additionalAttributes = []
        , onClick = Nothing
        , content = { label = "", icon = Nothing }
        }


{-| Specify a message when the user clicks a tab
-}
setOnClick : msg -> Config msg -> Config msg
setOnClick onClick (Config config_) =
    Config { config_ | onClick = Just onClick }


{-| Specify whether the tab is active

If no tab within a tab bar is specified as active, the first tab will be
active. If more than one tab within a tab bar is specified as active, only the
first one will be considered active.

-}
setActive : Bool -> Config msg -> Config msg
setActive active (Config config_) =
    Config { config_ | active = active }


{-| Specify additional attributes
-}
setAttributes : List (Html.Attribute msg) -> Config msg -> Config msg
setAttributes additionalAttributes (Config config_) =
    Config { config_ | additionalAttributes = additionalAttributes }


{-| Content of a tab
-}
type alias Content =
    { label : String
    , icon : Maybe Icon
    }


{-| Tab type

Tabs can only be rendered within a [tab bar](Material-TabBar).

-}
type alias Tab msg =
    Material.Tab.Internal.Tab msg


{-| Tab constructor
-}
tab : Config msg -> Content -> Tab msg
tab (Config config_) content =
    Tab (Config { config_ | content = content })


{-| Icon type
-}
type alias Icon =
    Material.Tab.Internal.Icon


{-| Material Icon

    Tab.tab Tab.config
        { label = "Add to favorites"
        , icon = Just (Tab.icon "favorite")
        }

-}
icon : String -> Icon
icon iconName =
    customIcon Html.i [ class "material-icons" ] [ text iconName ]


{-| Custom icon

    Tab.tab Tab.config
        { label = "Font Awesome"
        , icon =
            Just
                (Tab.customIcon Html.i
                    [ class "fab fa-font-awesome" ]
                    []
                )
        }

-}
customIcon :
    (List (Html.Attribute Never) -> List (Html Never) -> Html Never)
    -> List (Html.Attribute Never)
    -> List (Html Never)
    -> Icon
customIcon node attributes nodes =
    Icon { node = node, attributes = attributes, nodes = nodes }


{-| SVG icon

    Tab.tab Tab.config
        { label = "Tab"
        , icon =
            Just
                (Tab.svgIcon
                    [ Svg.Attributes.viewBox "…" ]
                    [-- …
                    ]
                )
        }

-}
svgIcon : List (Svg.Attribute Never) -> List (Svg Never) -> Icon
svgIcon attributes nodes =
    SvgIcon { node = Svg.svg, attributes = attributes, nodes = nodes }
