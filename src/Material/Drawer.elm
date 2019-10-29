module Material.Drawer exposing
    ( permanentDrawer, permanentDrawerConfig, PermanentDrawerConfig
    , drawerContent
    , drawerHeader, drawerTitle, drawerSubtitle
    , dismissibleDrawer, dismissibleDrawerConfig, DismissibleDrawerConfig, appContent
    , modalDrawer, modalDrawerConfig, ModalDrawerConfig, drawerScrim
    )

{-| The MDC Navigation Drawer is used to organize access to destinations and
other functionality on an app.


# Table of Contents

  - [Resources](#resources)
  - [Basic Usage](#basic-usage)
  - [Permanent Drawer](#permanent-drawer)
  - [Dismissible Drawer](#dismissible-drawer)
  - [Modal Drawer](#modal-drawer)


# Resources

  - [Demo: Drawers](https://aforemny.github.io/material-components-web-elm/#drawers)
  - [Material Design Guidelines: Navigation Drawer](https://material.io/go/design-navigation-drawer)
  - [MDC Web: List](https://github.com/material-components/material-components-web/tree/master/packages/mdc-drawer)
  - [Sass Mixins (MDC Web)](https://github.com/material-components/material-components-web/tree/master/packages/mdc-drawer#sass-mixins)


# Basic Usage

    import Html exposing (Html, text)
    import Html.Attributes exposing (style)
    import Material.Drawer as Drawer
        exposing
            ( permanentDrawer
            , permanentDrawerConfig
            )
    import Material.List
        exposing
            ( list
            , listConfig
            , listItem
            , listItemConfig
            )

    main =
        Html.div
            [ style "display" "flex"
            , style "flex-flow" "row nowrap"
            ]
            [ permanentDrawer permanentDrawerConfig
                [ drawerContent []
                    [ list listConfig
                        [ listItem listItemConfig
                            [ text "Home" ]
                        , listItem listItemConfig
                            [ text "Log out" ]
                        ]
                    ]
                ]
            , Html.div [] [ text "Main Content" ]
            ]


# Permanent Drawer

@docs permanentDrawer, permanentDrawerConfig, PermanentDrawerConfig
@docs drawerContent


# Drawer with Header

Drawers can contain a header element which will not scroll with the rest of the
drawer content. Things like account switchers and titles should live in the
header element.

@docs drawerHeader, drawerTitle, drawerSubtitle


# Dismissible Drawer

Dismissible drawers are by default hidden off screen, and can slide into view.
Dismissible drawers should be used when navigation is not common, and the main
app content is prioritized.

@docs dismissibleDrawer, dismissibleDrawerConfig, DismissibleDrawerConfig, appContent


# Modal Drawer

Modal drawers are elevated above most of the app's UI and don't affect the
screen's layout grid.

@docs modalDrawer, modalDrawerConfig, ModalDrawerConfig, drawerScrim

-}

import Html exposing (Html, text)
import Html.Attributes exposing (class)
import Html.Events
import Json.Decode as Decode
import Json.Encode as Encode


{-| Configuration of a permanent drawer
-}
type alias PermanentDrawerConfig msg =
    { additionalAttributes : List (Html.Attribute msg)
    }


{-| Default configuration of a permanent drawer
-}
permanentDrawerConfig : PermanentDrawerConfig msg
permanentDrawerConfig =
    { additionalAttributes = []
    }


{-| Configuration of a dismissible drawer
-}
type alias DismissibleDrawerConfig msg =
    { open : Bool
    , additionalAttributes : List (Html.Attribute msg)
    , onClose : Maybe msg
    }


{-| Default configuration of a dismissible drawer
-}
dismissibleDrawerConfig : DismissibleDrawerConfig msg
dismissibleDrawerConfig =
    { open = False
    , additionalAttributes = []
    , onClose = Nothing
    }


{-| Configuration of a model drawer
-}
type alias ModalDrawerConfig msg =
    { open : Bool
    , additionalAttributes : List (Html.Attribute msg)
    , onClose : Maybe msg
    }


{-| Default configuration of a modal drawer
-}
modalDrawerConfig : ModalDrawerConfig msg
modalDrawerConfig =
    { open = False
    , additionalAttributes = []
    , onClose = Nothing
    }


{-| Permanent drawer view function

    Html.div
        [ style "display" "flex"
        , style "flex-flow" "row nowrap"
        ]
        [ permanentDrawer permanentDrawerConfig
            [ drawerContent [] [] ]
        , Html.div [] [ text "Main Content" ]
        ]

-}
permanentDrawer : PermanentDrawerConfig msg -> List (Html msg) -> Html msg
permanentDrawer config nodes =
    Html.node "div"
        (List.filterMap identity [ rootCs ] ++ config.additionalAttributes)
        nodes


{-| Dismissible drawer view function

    Html.div []
        [ dismissibleDrawer
            { dismissibleDrawerConfig | open = True }
            [ drawerContent [] [] ]
        , Html.div [ Drawer.appContent ]
            [ text "Main Content" ]
        ]

-}
dismissibleDrawer : DismissibleDrawerConfig msg -> List (Html msg) -> Html msg
dismissibleDrawer config nodes =
    Html.node "mdc-drawer"
        (List.filterMap identity
            [ rootCs
            , dismissibleCs
            , openProp config
            , closeHandler config
            ]
            ++ config.additionalAttributes
        )
        nodes


{-| Modal drawer view function

    Html.div []
        [ modalDrawer
            { modalDrawerConfig
                | open = True
                , onClick = Just DrawerClosed
            }
            [ drawerContent [] [] ]
        , drawerScrim [] []
        , Html.div [] [ text "Main Content" ]
        ]

-}
modalDrawer : ModalDrawerConfig msg -> List (Html msg) -> Html msg
modalDrawer config nodes =
    Html.node "mdc-drawer"
        (List.filterMap identity
            [ rootCs
            , modalCs
            , openProp config
            , closeHandler config
            ]
            ++ config.additionalAttributes
        )
        nodes


{-| Drawer content
-}
drawerContent : List (Html.Attribute msg) -> List (Html msg) -> Html msg
drawerContent attributes nodes =
    Html.div (class "mdc-drawer__content" :: attributes) nodes


{-| Drawer header view function

    permanentDrawer permanentDrawerConfig
        [ drawerHeader []
            [ Html.h3 [ drawerTitle ] [ text "Title" ]
            , Html.h6 [ drawerSubtitle ] [ text "Subtitle" ]
            ]
        , drawerContent [] []
        ]

-}
drawerHeader : List (Html.Attribute msg) -> List (Html msg) -> Html msg
drawerHeader additionalAttributes nodes =
    Html.div (class "mdc-drawer__header" :: additionalAttributes) nodes


{-| Attribute to mark the title text element of the drawer header
-}
drawerTitle : Html.Attribute msg
drawerTitle =
    class "mdc-drawer__title"


{-| Attribute to mark the subtitle text element of the drawer header
-}
drawerSubtitle : Html.Attribute msg
drawerSubtitle =
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


openProp : { config | open : Bool } -> Maybe (Html.Attribute msg)
openProp { open } =
    Just (Html.Attributes.property "open" (Encode.bool open))


closeHandler : { config | onClose : Maybe msg } -> Maybe (Html.Attribute msg)
closeHandler { onClose } =
    Maybe.map (Html.Events.on "MDCDrawer:close" << Decode.succeed) onClose


contentElt : List (Html msg) -> Html msg
contentElt nodes =
    Html.div [ class "mdc-drawer__content" ] nodes


{-| Dismissible drawer's app content marker

Apply this attribute to the page's content for open/close animation to work.
The page content has to be the next sibling of the dismissible drawer.

-}
appContent : Html.Attribute msg
appContent =
    class "mdc-drawer-app-content"


{-| Modal drawer's scrim element

Prevents the application from interaction while the modal drawer is open. Has
to be the next sibling after the `modalDrawer` and before the page's content.

-}
drawerScrim : List (Html.Attribute msg) -> List (Html msg) -> Html msg
drawerScrim additionalAttributes nodes =
    Html.div ([ class "mdc-drawer-scrim" ] ++ additionalAttributes) nodes
