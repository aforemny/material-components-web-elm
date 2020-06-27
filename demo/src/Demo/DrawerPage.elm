module Demo.DrawerPage exposing (DrawerPage, drawerBody, view)

import Html exposing (Html, text)
import Html.Attributes exposing (style)
import Html.Events
import Material.Drawer.Dismissible as DismissibleDrawer
import Material.Drawer.Permanent as PermanentDrawer
import Material.Icon as Icon
import Material.List as List
import Material.List.Divider as ListDivider
import Material.List.Item as ListItem
import Material.TopAppBar as TopAppBar


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
            , Html.div [ DismissibleDrawer.appContent ]
                [ TopAppBar.regular TopAppBar.config
                    [ TopAppBar.row []
                        [ TopAppBar.section [ TopAppBar.alignStart ]
                            [ case onMenuClick of
                                Just handleClick ->
                                    Icon.icon
                                        [ TopAppBar.navigationIcon
                                        , Html.Events.onClick handleClick
                                        ]
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
        listItemConfig index =
            ListItem.config
                |> ListItem.setSelected
                    (if selectedIndex == index then
                        Just ListItem.activated

                     else
                        Nothing
                    )
                |> ListItem.setOnClick (setSelectedIndex index)
    in
    [ PermanentDrawer.header []
        [ Html.h3 [ PermanentDrawer.title ] [ text "Mail" ]
        , Html.h6 [ PermanentDrawer.subtitle ] [ text "email@material.io" ]
        ]
    , PermanentDrawer.content []
        [ List.group []
            [ List.list List.config
                (ListItem.listItem (listItemConfig 0)
                    [ ListItem.graphic [] [ Icon.icon [] "inbox" ]
                    , text "Inbox"
                    ]
                )
                [ ListItem.listItem (listItemConfig 1)
                    [ ListItem.graphic [] [ Icon.icon [] "star" ]
                    , text "Star"
                    ]
                , ListItem.listItem (listItemConfig 2)
                    [ ListItem.graphic [] [ Icon.icon [] "send" ]
                    , text "Sent Mail"
                    ]
                , ListItem.listItem (listItemConfig 3)
                    [ ListItem.graphic [] [ Icon.icon [] "drafts" ]
                    , text "Drafts"
                    ]
                ]
            , ListDivider.group []
            , List.subheader [] [ text "Labels" ]
            , List.list List.config
                (ListItem.listItem (listItemConfig 4)
                    [ ListItem.graphic [] [ Icon.icon [] "bookmark" ]
                    , text "Family"
                    ]
                )
                [ ListItem.listItem (listItemConfig 5)
                    [ ListItem.graphic [] [ Icon.icon [] "bookmark" ]
                    , text "Friends"
                    ]
                , ListItem.listItem (listItemConfig 6)
                    [ ListItem.graphic [] [ Icon.icon [] "bookmark" ]
                    , text "Work"
                    ]
                , ListDivider.listItem ListDivider.config
                , ListItem.listItem (listItemConfig 7)
                    [ ListItem.graphic [] [ Icon.icon [] "settings" ]
                    , text "Settings"
                    ]
                , ListItem.listItem (listItemConfig 8)
                    [ ListItem.graphic [] [ Icon.icon [] "announcement" ]
                    , text "Help & feedback"
                    ]
                ]
            ]
        ]
    ]


mainContent : Html msg
mainContent =
    Html.div
        [ style "padding-left" "18px"
        , style "padding-right" "18px"
        , style "overflow" "auto"
        , style "height" "100%"
        , style "box-sizing" "border-box"
        , TopAppBar.fixedAdjust
        , DismissibleDrawer.appContent
        ]
        (List.repeat 4 <| Html.p [] [ text loremIpsum ])


loremIpsum : String
loremIpsum =
    "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."


drawerFrameRoot : List (Html.Attribute msg)
drawerFrameRoot =
    [ style "display" "-ms-flexbox"
    , style "display" "flex"
    , style "height" "100vh"
    ]
