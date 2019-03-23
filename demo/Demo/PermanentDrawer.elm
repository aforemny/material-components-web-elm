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
import Material.Drawer as Drawer
import Material.Icon as Icon
import Material.List as Lists
import Material.TopAppBar as TopAppBar
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
        []
        [ Html.h3
            [ Drawer.title ]
            [ text "Mail" ]
        , Html.h6
            [ Drawer.subTitle ]
            [ text "email@material.io" ]
        ]


drawerItems : Html m
drawerItems =
    Drawer.content []
        [ Lists.nav []
            [ Lists.a
                [ Html.Attributes.href "#persistent-drawer"
                , Lists.activated
                ]
                [ Lists.graphicIcon [] "inbox"
                , text "Inbox"
                ]
            , Lists.a
                [ Html.Attributes.href "#persistent-drawer"
                ]
                [ Lists.graphicIcon [] "star"
                , text "Star"
                ]
            , Lists.a
                [ Html.Attributes.href "#persistent-drawer"
                ]
                [ Lists.graphicIcon [] "send"
                , text "Sent Mail"
                ]
            , Lists.a
                [ Html.Attributes.href "#persistent-drawer"
                ]
                [ Lists.graphicIcon [] "drafts"
                , text "Drafts"
                ]
            , Lists.divider [] []
            , Html.h6 [ Html.Attributes.class "mdc-list-group__subheader" ]
                [ text "Labels" ]
            , Lists.a
                [ Html.Attributes.href "#persistent-drawer"
                ]
                [ Lists.graphicIcon [] "bookmark"
                , text "Family"
                ]
            , Lists.a
                [ Html.Attributes.href "#persistent-drawer"
                ]
                [ Lists.graphicIcon [] "bookmark"
                , text "Friends"
                ]
            , Lists.a
                [ Html.Attributes.href "#persistent-drawer"
                ]
                [ Lists.graphicIcon [] "bookmark"
                , text "Work"
                ]
            , Lists.divider [] []
            , Lists.a
                [ Html.Attributes.href "#persistent-drawer"
                ]
                [ Lists.graphicIcon [] "settings"
                , text "Settings"
                ]
            , Lists.a
                [ Html.Attributes.href "#persistent-drawer"
                ]
                [ Lists.graphicIcon [] "announcement"
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
        [ Html.div [ TopAppBar.fixedAdjust ] []
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
        [ Drawer.view lift
            "permanent-drawer-drawer"
            model.mdc
            []
            [ drawerHeader
            , drawerItems
            ]
        , Html.div
            [ Html.Attributes.class "drawer-frame-app-content" ]
            [ TopAppBar.view lift
                "permanent-drawer-top-app-bar"
                model.mdc
                []
                [ TopAppBar.section
                    [ TopAppBar.alignStart
                    ]
                    [ TopAppBar.title [] [ text "Permanent Drawer" ]
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
