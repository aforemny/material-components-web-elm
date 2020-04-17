module Material.Drawer.Permanent exposing
    ( Config, config
    , setAttributes
    , drawer, content
    , header, title, subtitle
    )

{-| The MDC Navigation Drawer is used to organize access to destinations and
other functionality on an app.


# Table of Contents

  - [Resources](#resources)
  - [Basic Usage](#basic-usage)
  - [Configuration](#configuration)
      - [Configuration Options](#configuration-options)
  - [Permanent Drawer](#permanent-drawer)
  - [Drawer with Header](#drawer-with-header)


# Resources

  - [Demo: Drawers](https://aforemny.github.io/material-components-web-elm/#drawer)
  - [Material Design Guidelines: Navigation Drawer](https://material.io/go/design-navigation-drawer)
  - [MDC Web: List](https://github.com/material-components/material-components-web/tree/master/packages/mdc-drawer)
  - [Sass Mixins (MDC Web)](https://github.com/material-components/material-components-web/tree/master/packages/mdc-drawer#sass-mixins)


# Basic Usage

    import Html exposing (Html, text)
    import Html.Attributes exposing (style)
    import Material.Drawer.Permanent as PermanentDrawer
    import Material.List as List
    import Material.ListItem as ListItem

    main =
        Html.div
            [ style "display" "flex"
            , style "flex-flow" "row nowrap"
            ]
            [ PermanentDrawer.drawer PermanentDrawer.config
                [ PermanentDrawer.content []
                    [ List.list List.config
                        [ ListItem.listItem ListItem.config
                            [ text "Home" ]
                        , ListItem.listItem ListItem.config
                            [ text "Log out" ]
                        ]
                    ]
                ]
            , Html.div [] [ text "Main Content" ]
            ]


# Configuration

@docs Config, config


## Configuration Options

@docs setAttributes


# Permanent Drawer

@docs drawer, content


# Drawer with Header

Drawers can contain a header element which will not scroll with the rest of the
drawer content. Things like account switchers and titles should live in the
header element.

@docs header, title, subtitle

-}

import Html exposing (Html, text)
import Html.Attributes exposing (class)
import Html.Events
import Json.Decode as Decode
import Json.Encode as Encode


{-| Configuration of a permanent drawer
-}
type Config msg
    = Config { additionalAttributes : List (Html.Attribute msg) }


{-| Default configuration of a permanent drawer
-}
config : Config msg
config =
    Config { additionalAttributes = [] }


{-| Specify additional attributes
-}
setAttributes : List (Html.Attribute msg) -> Config msg -> Config msg
setAttributes additionalAttributes (Config config_) =
    Config { config_ | additionalAttributes = additionalAttributes }


{-| Permanent drawer view function
-}
drawer : Config msg -> List (Html msg) -> Html msg
drawer (Config { additionalAttributes }) nodes =
    Html.div
        (List.filterMap identity [ rootCs ] ++ additionalAttributes)
        nodes


{-| Drawer content
-}
content : List (Html.Attribute msg) -> List (Html msg) -> Html msg
content attributes nodes =
    Html.div (class "mdc-drawer__content" :: attributes) nodes


{-| Drawer header view function

    PermanentDrawer.drawer PermanentDrawer.config
        [ PermanentDrawer.header []
            [ Html.h3 [ PermanentDrawer.title ] [ text "Title" ]
            , Html.h6 [ PermanentDrawer.subtitle ] [ text "Subtitle" ]
            ]
        , PermanentDrawer.content [] []
        ]

-}
header : List (Html.Attribute msg) -> List (Html msg) -> Html msg
header additionalAttributes nodes =
    Html.div (class "mdc-drawer__header" :: additionalAttributes) nodes


{-| Attribute to mark the title text element of the drawer header
-}
title : Html.Attribute msg
title =
    class "mdc-drawer__title"


{-| Attribute to mark the subtitle text element of the drawer header
-}
subtitle : Html.Attribute msg
subtitle =
    class "mdc-drawer__subtitle"


rootCs : Maybe (Html.Attribute msg)
rootCs =
    Just (class "mdc-drawer")
