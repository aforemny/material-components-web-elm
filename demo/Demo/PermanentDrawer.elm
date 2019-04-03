module Demo.PermanentDrawer exposing
    ( Model
    , Msg(..)
    , defaultModel
    , drawerHeader
    , drawerItems
    , mainContent
    , subscriptions
    , update
    , view
    )

import Demo.Page exposing (Page)
import Html exposing (Html, text)
import Html.Attributes
import Html.Events
import Json.Decode as Json
import Material.Button as Button
import Material.Drawer as Drawer exposing (drawer, drawerConfig)
import Material.Icon as Icon exposing (icon, iconConfig)
import Material.List as Lists exposing (list, listConfig, listGroupSubheader, listItem, listItemConfig, listItemDivider, listItemDividerConfig, listItemGraphic)
import Material.TopAppBar as TopAppBar exposing (topAppBar, topAppBarConfig)
import Material.Typography as Typography
import Platform.Cmd exposing (Cmd, none)


type alias Model =
    {}


defaultModel : Model
defaultModel =
    {}


type Msg
    = NoOp


update : (Msg -> m) -> Msg -> Model -> ( Model, Cmd m )
update lift msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )


drawerHeader : Html m
drawerHeader =
    Drawer.header
        { title = "Mail"
        , subtitle = "email@material.io"
        , additionalAttributes = []
        }


drawerItems : Html m
drawerItems =
    Drawer.content []
        [ list listConfig
            [ listItem
                { listItemConfig
                    | activated = True
                    , additionalAttributes = [ Html.Attributes.href "#persistent-drawer" ]
                }
                [ listItemGraphic [] [ icon iconConfig "inbox" ]
                , text "Inbox"
                ]
            , listItem
                { listItemConfig
                    | additionalAttributes = [ Html.Attributes.href "#persistent-drawer" ]
                }
                [ listItemGraphic [] [ icon iconConfig "star" ]
                , text "Star"
                ]
            , listItem
                { listItemConfig
                    | additionalAttributes = [ Html.Attributes.href "#persistent-drawer" ]
                }
                [ listItemGraphic [] [ icon iconConfig "send" ]
                , text "Sent Mail"
                ]
            , listItem
                { listItemConfig
                    | additionalAttributes = [ Html.Attributes.href "#persistent-drawer" ]
                }
                [ listItemGraphic [] [ icon iconConfig "drafts" ]
                , text "Drafts"
                ]
            , listItemDivider listItemDividerConfig
            , listGroupSubheader [] [ text "Labels" ]
            , listItem
                { listItemConfig
                    | additionalAttributes = [ Html.Attributes.href "#persistent-drawer" ]
                }
                [ listItemGraphic [] [ icon iconConfig "bookmark" ]
                , text "Family"
                ]
            , listItem
                { listItemConfig
                    | additionalAttributes = [ Html.Attributes.href "#persistent-drawer" ]
                }
                [ listItemGraphic [] [ icon iconConfig "bookmark" ]
                , text "Friends"
                ]
            , listItem
                { listItemConfig
                    | additionalAttributes = [ Html.Attributes.href "#persistent-drawer" ]
                }
                [ listItemGraphic [] [ icon iconConfig "bookmark" ]
                , text "Work"
                ]
            , listItemDivider listItemDividerConfig
            , listItem
                { listItemConfig
                    | additionalAttributes = [ Html.Attributes.href "#persistent-drawer" ]
                }
                [ listItemGraphic [] [ icon iconConfig "settings" ]
                , text "Settings"
                ]
            , listItem
                { listItemConfig
                    | additionalAttributes = [ Html.Attributes.href "#persistent-drawer" ]
                }
                [ listItemGraphic [] [ icon iconConfig "announcement" ]
                , text "Help & feedback"
                ]
            ]
        ]


mainContent model mdc =
    Html.div
        [ Html.Attributes.class "drawer-main-content"
        , Html.Attributes.style "padding-left" "18px"
        , Html.Attributes.style "padding-right" "18px"
        , Html.Attributes.style "overflow" "auto"
        , Html.Attributes.style "height" "100%"
        ]
        [ Html.div [] []
        , Html.p
            []
            [ text "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
            ]
        , Html.p
            []
            [ text "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
            ]
        , Html.p
            []
            [ text "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
            ]
        , Html.p
            []
            [ text "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
            ]
        ]


view : (Msg -> m) -> Page m -> Model -> Html m
view lift page model =
    Html.div
        [ Html.Attributes.class "drawer-frame-root"
        , Html.Attributes.class "mdc-typography"
        , Html.Attributes.style "display" "flex"
        , Html.Attributes.style "height" "100vh"
        ]
        [ drawer drawerConfig
            [ drawerHeader
            , drawerItems
            ]
        , Html.div
            [ Html.Attributes.class "drawer-frame-app-content" ]
            [ topAppBar topAppBarConfig
                [ TopAppBar.section
                    [ TopAppBar.alignStart
                    ]
                    [ Html.span [ TopAppBar.title ] [ text "Permanent Drawer" ]
                    ]
                ]
            , mainContent model lift
            ]
        , Html.node "style"
            [ Html.Attributes.type_ "text/css"
            ]
            [ text """
html, body {
  width: 100%;
  height: 100%;
}
        """
            ]
        ]


subscriptions : (Msg -> m) -> Model -> Sub m
subscriptions lift model =
    Sub.none
