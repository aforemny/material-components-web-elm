module Material.Tab exposing
    ( Config, config
    , setOnClick
    , setActive
    , setAdditionalAttributes
    , Tab, tab, Content
    )

{-| Tabs organize and allow navigation between groups of content that are
related and at the same level of hierarchy. The Tab Bar contains the Tab
Scroller and Tab components.


# Table of Contents

  - [Resources](#resources)
  - [Basic Usage](#basic-usage)
  - [Configuration](#configuration)
      - [Configuration Options](#configuration-options)
  - [Tab](#tab)
  - [Active Tab](#active-tab)


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
                    |> Tab.setActive
                    |> Tab.setOnClick (TabClicked 0)
                )
                { label = "Tab 1", icon = Nothing }
            , Tab.tab
                (Tab.config
                    |> Tab.setActive
                    |> Tab.setOnClick (TabClicked 1)
                )
                { label = "Tab 1", icon = Nothing }
            ]


# Configuration

@docs Config, config


## Configuration Options

@docs setOnClick
@docs setActive
@docs setAdditionalAttributes


# Tab

@docs Tab, tab, Content


# Active Tab

Requires that the `tab`s have both `label` and `icon`.

    Tab.tab
        (Tab.config
            |> Tab.setActive
        )

-}

import Html exposing (Html, text)
import Html.Attributes exposing (class)
import Html.Events
import Json.Decode as Decode
import Json.Encode as Encode
import Material.Tab.Internal


{-| Configuration of a tab
-}
type alias Config msg =
    Material.Tab.Internal.Config msg


{-| Default configuration of a tab
-}
config : Config msg
config =
    Material.Tab.Internal.Config
        { active = False
        , additionalAttributes = []
        , onClick = Nothing
        , content = { label = "", icon = Nothing }
        }


{-| Specify a message when the user clicks a tab
-}
setOnClick : msg -> Config msg -> Config msg
setOnClick onClick (Material.Tab.Internal.Config config_) =
    Material.Tab.Internal.Config { config_ | onClick = Just onClick }


{-| Set the tab to active
-}
setActive : Config msg -> Config msg
setActive (Material.Tab.Internal.Config config_) =
    Material.Tab.Internal.Config { config_ | active = True }


{-| Specify additional attributes
-}
setAdditionalAttributes : List (Html.Attribute msg) -> Config msg -> Config msg
setAdditionalAttributes additionalAttributes (Material.Tab.Internal.Config config_) =
    Material.Tab.Internal.Config { config_ | additionalAttributes = additionalAttributes }


{-| Content of a tab
-}
type alias Content =
    { label : String
    , icon : Maybe String
    }


{-| Tab
-}
type alias Tab msg =
    Material.Tab.Internal.Tab msg


{-| Tab constructor
-}
tab : Config msg -> Content -> Tab msg
tab (Material.Tab.Internal.Config config_) content =
    Material.Tab.Internal.Tab
        (Material.Tab.Internal.Config { config_ | content = content })
