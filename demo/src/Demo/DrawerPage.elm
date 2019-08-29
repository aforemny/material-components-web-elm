module Demo.DrawerPage exposing (DrawerPage, drawerBody, view)

import Html exposing (Html, text)
import Html.Attributes
import Html.Events
import Json.Decode as Decode
import Material.Drawer as Drawer exposing (drawerContent, drawerHeader, drawerSubtitle, drawerTitle)
import Material.Icon exposing (icon, iconConfig)
import Material.List exposing (list, listConfig, listGroupSubheader, listItem, listItemConfig, listItemDivider, listItemDividerConfig, listItemGraphic)
import Material.TopAppBar as TopAppBar exposing (topAppBar, topAppBarConfig)


type alias DrawerPage msg =
    { title : String
    , drawer : Html msg
    , scrim : Maybe (Html msg)
    , onMenuClick : Maybe msg
    }


view : (msg -> topMsg) -> DrawerPage msg -> Html topMsg
view lift { title, drawer, scrim, onMenuClick } =
    Html.map lift <|
        Html.div drawerFrameRoot
            [ drawer
            , Maybe.withDefault (text "") scrim
            , Html.div [ Drawer.appContent ]
                [ topAppBar topAppBarConfig
                    [ TopAppBar.row []
                        [ TopAppBar.section [ TopAppBar.alignStart ]
                            [ case onMenuClick of
                                Just handleClick ->
                                    icon
                                        { iconConfig
                                            | additionalAttributes =
                                                [ TopAppBar.navigationIcon
                                                , Html.Events.onClick handleClick
                                                ]
                                        }
                                        "menu"

                                Nothing ->
                                    text ""
                            , Html.span [ TopAppBar.title ] [ text title ]
                            ]
                        ]
                    ]
                , mainContent
                ]
            ]


drawerBody : (Int -> msg) -> Int -> List (Html msg)
drawerBody setSelectedIndex selectedIndex =
    let
        listItemConfig_ index =
            { listItemConfig
                | activated = selectedIndex == index
                , onClick = Just (setSelectedIndex index)
            }
    in
    [ drawerHeader []
        [ Html.h3 [ drawerTitle ] [ text "Mail" ]
        , Html.h6 [ drawerSubtitle ] [ text "email@material.io" ]
        ]
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


mainContent : Html msg
mainContent =
    Html.div
        [ Html.Attributes.style "padding-left" "18px"
        , Html.Attributes.style "padding-right" "18px"
        , Html.Attributes.style "overflow" "auto"
        , Html.Attributes.style "height" "100%"
        , Html.Attributes.style "box-sizing" "border-box"
        , TopAppBar.fixedAdjust
        , Drawer.appContent
        ]
        (List.repeat 4 <| Html.p [] [ text loremIpsum ])


loremIpsum : String
loremIpsum =
    "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."


drawerFrameRoot : List (Html.Attribute msg)
drawerFrameRoot =
    [ Html.Attributes.style "display" "-ms-flexbox"
    , Html.Attributes.style "display" "flex"
    , Html.Attributes.style "height" "100vh"
    ]
