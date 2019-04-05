module Demo.PermanentDrawer exposing
    ( Model
    , Msg(..)
    , defaultModel
    , drawerBody
    , mainContent
    , update
    , view
    )

import Demo.Page exposing (Page)
import Html exposing (Html, text)
import Html.Attributes
import Html.Events
import Json.Decode as Decode
import Material.Button as Button
import Material.Drawer as Drawer exposing (drawerConfig, drawerContent, drawerHeader, permanentDrawer)
import Material.Icon as Icon exposing (icon, iconConfig)
import Material.List as Lists exposing (list, listConfig, listGroupSubheader, listItem, listItemConfig, listItemDivider, listItemDividerConfig, listItemGraphic)
import Material.TopAppBar as TopAppBar exposing (topAppBar, topAppBarConfig)
import Material.Typography as Typography
import Platform.Cmd exposing (Cmd, none)


type alias Model =
    { selectedIndex : Int }


defaultModel : Model
defaultModel =
    { selectedIndex = 0 }


type Msg
    = NoOp
    | SetSelectedIndex Int


update : (Msg -> m) -> Msg -> Model -> ( Model, Cmd m )
update lift msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )

        SetSelectedIndex index ->
            ( { model | selectedIndex = index }, Cmd.none )


drawerBody : (Int -> m) -> Int -> List (Html m)
drawerBody setSelectedIndex selectedIndex =
    let
        listItemConfig_ index =
            { listItemConfig
                | activated = selectedIndex == index
                , onClick = Just (setSelectedIndex index)
                , additionalAttributes =
                    [ Html.Events.on "keydown"
                        (Html.Events.keyCode
                            |> Decode.andThen
                                (\keyCode ->
                                    if keyCode == 32 || keyCode == 13 then
                                        Decode.succeed (setSelectedIndex index)

                                    else
                                        Decode.fail ""
                                )
                        )
                    ]
            }
    in
    [ drawerHeader
        { title = "Mail"
        , subtitle = "email@material.io"
        , additionalAttributes = []
        }
    , drawerContent []
        [ list listConfig
            [ listItem (listItemConfig_ 0)
                [ listItemGraphic [] [ icon iconConfig "inbox" ]
                , text "Inbox"
                ]
            , listItem (listItemConfig_ 1)
                [ listItemGraphic [] [ icon iconConfig "star" ]
                , text "Star"
                ]
            , listItem (listItemConfig_ 2)
                [ listItemGraphic [] [ icon iconConfig "send" ]
                , text "Sent Mail"
                ]
            , listItem (listItemConfig_ 3)
                [ listItemGraphic [] [ icon iconConfig "drafts" ]
                , text "Drafts"
                ]
            , listItemDivider listItemDividerConfig
            , listGroupSubheader [] [ text "Labels" ]
            , listItem (listItemConfig_ 4)
                [ listItemGraphic [] [ icon iconConfig "bookmark" ]
                , text "Family"
                ]
            , listItem (listItemConfig_ 5)
                [ listItemGraphic [] [ icon iconConfig "bookmark" ]
                , text "Friends"
                ]
            , listItem (listItemConfig_ 6)
                [ listItemGraphic [] [ icon iconConfig "bookmark" ]
                , text "Work"
                ]
            , listItemDivider listItemDividerConfig
            , listItem (listItemConfig_ 7)
                [ listItemGraphic [] [ icon iconConfig "settings" ]
                , text "Settings"
                ]
            , listItem (listItemConfig_ 8)
                [ listItemGraphic [] [ icon iconConfig "announcement" ]
                , text "Help & feedback"
                ]
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
        , Html.Attributes.style "box-sizing" "border-box"
        , TopAppBar.fixedAdjust
        , Drawer.appContent
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
        [ permanentDrawer drawerConfig
            (drawerBody (lift << SetSelectedIndex) model.selectedIndex)
        , Html.div
            [ Html.Attributes.class "drawer-frame-app-content" ]
            [ topAppBar topAppBarConfig
                [ TopAppBar.row []
                    [ TopAppBar.section
                        [ TopAppBar.alignStart
                        ]
                        [ Html.span [ TopAppBar.title ] [ text "Permanent Drawer" ]
                        ]
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
