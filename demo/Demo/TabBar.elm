module Demo.TabBar exposing (Model, Msg(..), defaultModel, update, view)

import Demo.Helper.ResourceLink as ResourceLink
import Demo.Page as Page exposing (Page)
import Dict exposing (Dict)
import Html exposing (Html, text)
import Html.Attributes
import Html.Events
import Material.TabBar as TabBar exposing (tab, tabBar, tabBarConfig, tabConfig)
import Material.Theme as Theme
import Material.Typography as Typography
import Platform.Cmd exposing (Cmd, none)


type alias Model =
    { activeHeroTab : Int
    , activeIconTab : Int
    , activeStackedTab : Int
    , activeScrollingTab : Int
    }


defaultModel : Model
defaultModel =
    { activeHeroTab = 0
    , activeIconTab = 0
    , activeStackedTab = 0
    , activeScrollingTab = 0
    }


type Msg
    = SetActiveHeroTab Int
    | SetActiveIconTab Int
    | SetActiveStackedTab Int
    | SetActiveScrollingTab Int


update : (Msg -> m) -> Msg -> Model -> ( Model, Cmd m )
update lift msg model =
    case msg of
        SetActiveHeroTab index ->
            ( { model | activeHeroTab = index }, Cmd.none )

        SetActiveIconTab index ->
            ( { model | activeIconTab = index }, Cmd.none )

        SetActiveStackedTab index ->
            ( { model | activeStackedTab = index }, Cmd.none )

        SetActiveScrollingTab index ->
            ( { model | activeScrollingTab = index }, Cmd.none )


view : (Msg -> m) -> Page m -> Model -> Html m
view lift page model =
    page.body "Tab Bar"
        "Tabs organize and allow navigation between groups of content that are related and at the same level of hierarchy. The Tab Bar contains the Tab Scroller and Tab components."
        [ Page.hero []
            [ heroTabs lift model "tabs-hero-tabs"
            ]
        , Html.h2
            [ Typography.headline6
            , Html.Attributes.style "border-bottom" "1px solid rgba(0,0,0,.87)"
            ]
            [ text "Resources"
            ]
        , ResourceLink.view
            { link = "https://material.io/go/design-tabs"
            , title = "Material Design Guidelines"
            , icon = "images/material.svg"
            , altText = "Material Design Guidelines icon"
            }
        , ResourceLink.view
            { link = "https://material.io/components/web/catalog/tabs/"
            , title = "Documentation"
            , icon = "images/ic_drive_document_24px.svg"
            , altText = "Documentation icon"
            }
        , ResourceLink.view
            { link = "https://github.com/material-components/material-components-web/tree/master/packages/mdc-tab-bar"
            , title = "Source Code (Material Components Web)"
            , icon = "images/ic_code_24px.svg"
            , altText = "Source Code"
            }
        , Page.demos
            [ Html.h3 [ Typography.subtitle1 ] [ text "Tabs with icons next to labels" ]
            , tabsWithIcons lift model
            , Html.h3 [ Typography.subtitle1 ]
                [ text "Tabs with icons above labels and indicators restricted to content"
                ]
            , tabsWithStackedIcons lift model
            , Html.h3 [ Typography.subtitle1 ] [ text "Scrolling tabs" ]
            , scrollingTabs lift model
            ]
        ]


heroTabs : (Msg -> m) -> Model -> String -> Html m
heroTabs lift model index =
    tabBar tabBarConfig
        [ tab
            { tabConfig
                | active = model.activeHeroTab == 0
                , onClick = Just (lift (SetActiveHeroTab 0))
            }
            { label = "Home", icon = Nothing }
        , tab
            { tabConfig
                | active = model.activeHeroTab == 1
                , onClick = Just (lift (SetActiveHeroTab 1))
            }
            { label = "Merchandise", icon = Nothing }
        , tab
            { tabConfig
                | active = model.activeHeroTab == 2
                , onClick = Just (lift (SetActiveHeroTab 2))
            }
            { label = "About Us", icon = Nothing }
        ]


tabsWithIcons : (Msg -> m) -> Model -> Html m
tabsWithIcons lift model =
    let
        tabConfig_ index =
            { tabConfig
                | active = model.activeIconTab == index
                , onClick = Just (lift (SetActiveIconTab index))
            }
    in
    tabBar tabBarConfig
        [ tab (tabConfig_ 0) { label = "Recents", icon = Just "access_time" }
        , tab (tabConfig_ 1) { label = "Nearby", icon = Just "near_me" }
        , tab (tabConfig_ 2) { label = "Favorites", icon = Just "favorite" }
        ]


tabsWithStackedIcons : (Msg -> m) -> Model -> Html m
tabsWithStackedIcons lift model =
    let
        tabConfig_ index =
            { tabConfig
                | stacked = True
                , indicatorSpansContent = True
                , active = model.activeStackedTab == index
                , onClick = Just (lift (SetActiveStackedTab index))
            }
    in
    tabBar tabBarConfig
        [ tab (tabConfig_ 0) { label = "Recents", icon = Just "access_time" }
        , tab (tabConfig_ 1) { label = "Nearby", icon = Just "near_me" }
        , tab (tabConfig_ 2) { label = "Favorites", icon = Just "favorite" }
        ]


scrollingTabs : (Msg -> m) -> Model -> Html m
scrollingTabs lift model =
    let
        tabConfig_ index =
            { tabConfig
                | active = model.activeScrollingTab == index
                , onClick = Just (lift (SetActiveScrollingTab index))
            }
    in
    tabBar tabBarConfig
        (List.indexedMap
            (\index label ->
                tab (tabConfig_ index) { label = "Tab " ++ label, icon = Nothing }
            )
            [ "One", "Two", "Three", "Four", "Five", "Six", "Seven", "Eight" ]
        )
