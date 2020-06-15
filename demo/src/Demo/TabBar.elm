module Demo.TabBar exposing (Model, Msg(..), defaultModel, update, view)

import Browser.Dom
import Demo.CatalogPage exposing (CatalogPage)
import Html exposing (Html, text)
import Html.Attributes
import Material.Button as Button
import Material.Tab as Tab
import Material.TabBar as TabBar
import Material.Typography as Typography
import Task


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
    | Focus String
    | Focused (Result Browser.Dom.Error ())


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        SetActiveHeroTab index ->
            ( { model | activeHeroTab = index }, Cmd.none )

        SetActiveIconTab index ->
            ( { model | activeIconTab = index }, Cmd.none )

        SetActiveStackedTab index ->
            ( { model | activeStackedTab = index }, Cmd.none )

        SetActiveScrollingTab index ->
            ( { model | activeScrollingTab = index }, Cmd.none )

        Focus id ->
            ( model, Task.attempt Focused (Browser.Dom.focus id) )

        Focused _ ->
            ( model, Cmd.none )


view : Model -> CatalogPage Msg
view model =
    { title = "Tab Bar"
    , prelude = "Tabs organize and allow navigation between groups of content that are related and at the same level of hierarchy. The Tab Bar contains the Tab Scroller and Tab components."
    , resources =
        { materialDesignGuidelines = Just "https://material.io/go/design-tabs"
        , documentation = Just "https://package.elm-lang.org/packages/aforemny/material-components-web-elm/latest/Material-TabBar"
        , sourceCode = Just "https://github.com/material-components/material-components-web/tree/master/packages/mdc-tab-bar"
        }
    , hero = [ heroTabs model "tabs-hero-tabs" ]
    , content =
        [ Html.h3 [ Typography.subtitle1 ] [ text "Tabs with icons next to labels" ]
        , tabsWithIcons model
        , Html.h3 [ Typography.subtitle1 ]
            [ text "Tabs with icons above labels and indicators restricted to content" ]
        , tabsWithStackedIcons model
        , Html.h3 [ Typography.subtitle1 ] [ text "Scrolling tabs" ]
        , scrollingTabs model
        , Html.h3 [ Typography.subtitle1 ] [ text "Focus tabs" ]
        , focusTabs model
        ]
    }


heroTabs : Model -> String -> Html Msg
heroTabs model index =
    TabBar.tabBar TabBar.config
        [ Tab.tab
            (Tab.config
                |> Tab.setActive (model.activeHeroTab == 0)
                |> Tab.setOnClick (SetActiveHeroTab 0)
            )
            { label = "Home", icon = Nothing }
        , Tab.tab
            (Tab.config
                |> Tab.setActive (model.activeHeroTab == 1)
                |> Tab.setOnClick (SetActiveHeroTab 1)
            )
            { label = "Merchandise", icon = Nothing }
        , Tab.tab
            (Tab.config
                |> Tab.setActive (model.activeHeroTab == 2)
                |> Tab.setOnClick (SetActiveHeroTab 2)
            )
            { label = "About Us", icon = Nothing }
        ]


tabsWithIcons : Model -> Html Msg
tabsWithIcons model =
    let
        config index =
            Tab.config
                |> Tab.setActive (model.activeIconTab == index)
                |> Tab.setOnClick (SetActiveIconTab index)
    in
    TabBar.tabBar TabBar.config
        [ Tab.tab (config 0) { label = "Recents", icon = Just "access_time" }
        , Tab.tab (config 1) { label = "Nearby", icon = Just "near_me" }
        , Tab.tab (config 2) { label = "Favorites", icon = Just "favorite" }
        ]


tabsWithStackedIcons : Model -> Html Msg
tabsWithStackedIcons model =
    let
        config index =
            Tab.config
                |> Tab.setActive (model.activeStackedTab == index)
                |> Tab.setOnClick (SetActiveStackedTab index)
    in
    TabBar.tabBar
        (TabBar.config
            |> TabBar.setStacked True
            |> TabBar.setIndicatorSpansContent True
        )
        [ Tab.tab (config 0) { label = "Recents", icon = Just "access_time" }
        , Tab.tab (config 1) { label = "Nearby", icon = Just "near_me" }
        , Tab.tab (config 2) { label = "Favorites", icon = Just "favorite" }
        ]


scrollingTabs : Model -> Html Msg
scrollingTabs model =
    let
        config index =
            Tab.config
                |> Tab.setActive (model.activeScrollingTab == index)
                |> Tab.setOnClick (SetActiveScrollingTab index)
    in
    TabBar.tabBar TabBar.config
        (List.indexedMap
            (\index label ->
                Tab.tab (config index) { label = "Tab " ++ label, icon = Nothing }
            )
            [ "One", "Two", "Three", "Four", "Five", "Six", "Seven", "Eight" ]
        )


focusTabs : Model -> Html Msg
focusTabs model =
    Html.div []
        [ TabBar.tabBar
            (TabBar.config
                |> TabBar.setAttributes [ Html.Attributes.id "my-tabs" ]
            )
            [ Tab.tab
                (Tab.config
                    |> Tab.setActive (model.activeHeroTab == 0)
                    |> Tab.setOnClick (SetActiveHeroTab 0)
                )
                { label = "Home", icon = Nothing }
            , Tab.tab
                (Tab.config
                    |> Tab.setActive (model.activeHeroTab == 1)
                    |> Tab.setOnClick (SetActiveHeroTab 1)
                )
                { label = "Merchandise", icon = Nothing }
            , Tab.tab
                (Tab.config
                    |> Tab.setActive (model.activeHeroTab == 2)
                    |> Tab.setOnClick (SetActiveHeroTab 2)
                )
                { label = "About Us", icon = Nothing }
            ]
        , text "\u{00A0}"
        , Button.raised
            (Button.config |> Button.setOnClick (Focus "my-tabs"))
            "Focus"
        ]
