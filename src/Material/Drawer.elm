module Material.Drawer exposing
    ( permanentDrawer, drawerConfig, DrawerConfig
    , drawerContent
    , drawerHeader, DrawerHeaderContent
    , dismissibleDrawer, appContent
    , modalDrawer, drawerScrim
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

  - [Demo: Drawers](https://aforemny.github.io/material-components-elm/#drawers)
  - [Material Design Guidelines: Navigation Drawer](https://material.io/go/design-navigation-drawer)
  - [MDC Web: List](https://github.com/material-components/material-components-web/tree/master/packages/mdc-drawer)
  - [Sass Mixins (MDC Web)](https://github.com/material-components/material-components-web/tree/master/packages/mdc-drawer#sass-mixins)


# Basic Usage

    import Html exposing (Html, text)
    import Html.Attributes exposing (style)
    import Material.Drawer as Drawer
        exposing
            ( drawerConfig
            , permanentDrawer
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
            [ permanentDrawer drawerConfig
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

@docs permanentDrawer, drawerConfig, DrawerConfig
@docs drawerContent


# Drawer with Header

Drawers can contain a header element which will not scroll with the rest of the
drawer content. Things like account switchers and titles should live in the
header element.

@docs drawerHeader, DrawerHeaderContent


# Dismissible Drawer

Dismissible drawers are by default hidden off screen, and can slide into view.
Dismissible drawers should be used when navigation is not common, and the main
app content is prioritized.

@docs dismissibleDrawer, appContent


# Modal Drawer

Modal drawers are elevated above most of the app's UI and don't affect the
screen's layout grid.

@docs modalDrawer, drawerScrim

-}

import Html exposing (Html, text)
import Html.Attributes exposing (class)
import Html.Events
import Json.Decode as Decode


{-| Configuration of a drawer

The configuration fields `open` and `onClose` are ignored for the permanent
drawer variant. The configuration field `onClose` is ignored for the
dismissible drawer variant. Only the modal drawer uses both `open` and
`onClose`.

-}
type alias DrawerConfig msg =
    { variant : Variant
    , open : Bool
    , additionalAttributes : List (Html.Attribute msg)
    , onClose : Maybe msg
    }


{-| Default configuration of a drawer
-}
drawerConfig : DrawerConfig msg
drawerConfig =
    { variant = Permanent
    , open = False
    , additionalAttributes = []
    , onClose = Nothing
    }


type Variant
    = Permanent
    | Dismissible
    | Modal


drawer : DrawerConfig msg -> List (Html msg) -> Html msg
drawer config nodes =
    Html.node "mdc-drawer"
        (List.filterMap identity
            [ rootCs
            , variantCs config
            , openAttr config
            , closeHandler config
            ]
            ++ config.additionalAttributes
        )
        nodes


{-| Permanent drawer view function

    Html.div
        [ style "display" "flex"
        , style "flex-flow" "row nowrap"
        ]
        [ permanentDrawer drawerConfig
            [ drawerContent [] [] ]
        , Html.div [] [ text "Main Content" ]
        ]

-}
permanentDrawer : DrawerConfig msg -> List (Html msg) -> Html msg
permanentDrawer config nodes =
    drawer { config | variant = Permanent } nodes


{-| Dismissible drawer view function

    Html.div []
        [ dismissibleDrawer
            { drawerConfig | open = True }
            [ drawerContent [] [] ]
        , Html.div [ Drawer.appContent ]
            [ text "Main Content" ]
        ]

-}
dismissibleDrawer : DrawerConfig msg -> List (Html msg) -> Html msg
dismissibleDrawer config nodes =
    drawer { config | variant = Dismissible } nodes


{-| Modal drawer view function

    Html.div []
        [ modalDrawer
            { drawerConfig
                | open = True
                , onClick = Just DrawerClosed
            }
            [ drawerContent [] [] ]
        , drawerScrim [] []
        , Html.div [] [ text "Main Content" ]
        ]

-}
modalDrawer : DrawerConfig msg -> List (Html msg) -> Html msg
modalDrawer config nodes =
    drawer { config | variant = Modal } nodes


{-| Drawer content
-}
drawerContent : List (Html.Attribute msg) -> List (Html msg) -> Html msg
drawerContent attributes nodes =
    Html.div (class "mdc-drawer__content" :: attributes) nodes


{-| Content of a drawer header
-}
type alias DrawerHeaderContent =
    { title : String
    , subtitle : String
    }


{-| Drawer header view function

    permanentDrawer drawerConfig
        [ drawerHeader []
            { title = "Title"
            , subtitle = "Subtitle"
            }
        , drawerContent [] []
        ]

-}
drawerHeader : List (Html.Attribute msg) -> DrawerHeaderContent -> Html msg
drawerHeader additionalAttributes content =
    Html.div (class "mdc-drawer__header" :: additionalAttributes)
        [ titleElt content
        , subtitleElt content
        ]


titleElt : DrawerHeaderContent -> Html msg
titleElt { title } =
    Html.h3 [ class "mdc-drawer__title" ] [ text title ]


subtitleElt : DrawerHeaderContent -> Html msg
subtitleElt { subtitle } =
    Html.h6 [ class "mdc-drawer__subtitle" ] [ text subtitle ]


rootCs : Maybe (Html.Attribute msg)
rootCs =
    Just (class "mdc-drawer")


variantCs : DrawerConfig msg -> Maybe (Html.Attribute msg)
variantCs { variant } =
    case variant of
        Permanent ->
            Nothing

        Dismissible ->
            Just (class "mdc-drawer--dismissible")

        Modal ->
            Just (class "mdc-drawer--modal")


openAttr : DrawerConfig msg -> Maybe (Html.Attribute msg)
openAttr { variant, open } =
    if open && variant /= Permanent then
        Just (Html.Attributes.attribute "open" "")

    else
        Nothing


closeHandler : DrawerConfig msg -> Maybe (Html.Attribute msg)
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
