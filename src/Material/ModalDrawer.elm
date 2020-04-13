module Material.ModalDrawer exposing
    ( Config, config
    , setOnClose
    , setOpen
    , setAdditionalAttributes
    , drawer, content
    , scrim
    , header, title, subtitle
    )

{-| The MDC Navigation Drawer is used to organize access to destinations and
other functionality on an app.


# Table of Contents

  - [Resources](#resources)
  - [Basic Usage](#basic-usage)
  - [Configuration](#configuration)
      - [Configuration Options](#configuration-options)
  - [Modal Drawer](#modal-drawer)
  - [Drawer with Header](#drawer-with-header)


# Resources

  - [Demo: Drawers](https://aforemny.github.io/material-components-web-elm/#drawer)
  - [Material Design Guidelines: Navigation Drawer](https://material.io/go/design-navigation-drawer)
  - [MDC Web: List](https://github.com/material-components/material-components-web/tree/master/packages/mdc-drawer)
  - [Sass Mixins (MDC Web)](https://github.com/material-components/material-components-web/tree/master/packages/mdc-drawer#sass-mixins)


# Basic Usage

    import Html exposing (Html, text)
    import Html.Attributes exposing (style)
    import Material.List as List
    import Material.ListItem as ListItem
    import Material.ModalDrawer as ModalDrawer

    main =
        Html.div
            [ style "display" "flex"
            , style "flex-flow" "row nowrap"
            ]
            [ ModalDrawer.drawer ModalDrawer.config
                [ ModalDrawer.content []
                    [ List.list List.config
                        [ ListItem.listItem ListItem.config
                            [ text "Home" ]
                        , ListItem.listItem ListItem.config
                            [ text "Log out" ]
                        ]
                    ]
                ]
            , ModalDrawer.scrim [] []
            , Html.div [] [ text "Main Content" ]
            ]


# Configuration

@docs Config, config


## Configuration Options

@docs setOnClose
@docs setOpen
@docs setAdditionalAttributes


# Modal Drawer

Modal drawers are elevated above most of the app's UI and don't affect the
screen's layout grid.

@docs drawer, content
@docs scrim


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


{-| Configuration of a model drawer
-}
type Config msg
    = Config
        { open : Bool
        , additionalAttributes : List (Html.Attribute msg)
        , onClose : Maybe msg
        }


{-| Default configuration of a modal drawer
-}
config : Config msg
config =
    Config
        { open = False
        , additionalAttributes = []
        , onClose = Nothing
        }


{-| Set the drawer to be open
-}
setOpen : Config msg -> Config msg
setOpen (Config config_) =
    Config { config_ | open = True }


{-| Specify message when the user closes the drawer
-}
setOnClose : msg -> Config msg -> Config msg
setOnClose onClose (Config config_) =
    Config { config_ | onClose = Just onClose }


{-| Specify additional attributes
-}
setAdditionalAttributes : List (Html.Attribute msg) -> Config msg -> Config msg
setAdditionalAttributes additionalAttributes (Config config_) =
    Config { config_ | additionalAttributes = additionalAttributes }


{-| Modal drawer view function
-}
drawer : Config msg -> List (Html msg) -> Html msg
drawer ((Config { additionalAttributes }) as config_) nodes =
    Html.node "mdc-drawer"
        (List.filterMap identity
            [ rootCs
            , modalCs
            , openProp config_
            , closeHandler config_
            ]
            ++ additionalAttributes
        )
        nodes


{-| Drawer content
-}
content : List (Html.Attribute msg) -> List (Html msg) -> Html msg
content attributes nodes =
    Html.div (class "mdc-drawer__content" :: attributes) nodes


{-| Drawer header view function

    ModalDrawer.drawer ModalDrawer.config
        [ ModalDrawer.header []
            [ Html.h3 [ ModalDrawer.title ] [ text "Title" ]
            , Html.h6 [ ModalDrawer.subtitle ] [ text "Subtitle" ]
            ]
        , ModalDrawer.content [] []
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


modalCs : Maybe (Html.Attribute msg)
modalCs =
    Just (class "mdc-drawer--modal")


dismissibleCs : Maybe (Html.Attribute msg)
dismissibleCs =
    Just (class "mdc-drawer--dismissible")


openProp : Config msg -> Maybe (Html.Attribute msg)
openProp (Config { open }) =
    Just (Html.Attributes.property "open" (Encode.bool open))


closeHandler : Config msg -> Maybe (Html.Attribute msg)
closeHandler (Config { onClose }) =
    Maybe.map (Html.Events.on "MDCDrawer:close" << Decode.succeed) onClose


{-| Modal drawer's scrim element

Prevents the application from interaction while the modal drawer is open. Has
to be the next sibling after the `modalDrawer` and before the page's content.

-}
scrim : List (Html.Attribute msg) -> List (Html msg) -> Html msg
scrim additionalAttributes nodes =
    Html.div (class "mdc-drawer-scrim" :: additionalAttributes) nodes
