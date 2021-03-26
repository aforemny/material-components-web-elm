module Demo.TabBar exposing (Model, Msg(..), defaultModel, update, view)

import Browser.Dom
import Demo.CatalogPage exposing (CatalogPage)
import Demo.ElmLogo exposing (elmLogo)
import Html exposing (Html, text)
import Html.Attributes exposing (class)
import Material.Button as Button
import Material.Tab as Tab
import Material.TabBar as TabBar
import Material.Typography as Typography
import Svg.Attributes
import Task


type alias Model =
    { activeHeroTab : Int
    , activeIconTab : Int
    , activeStackedTab : Int
    , activeScrollingTab : Int
    , activeCustomIconTab : Int
    }


defaultModel : Model
defaultModel =
    { activeHeroTab = 0
    , activeIconTab = 0
    , activeStackedTab = 0
    , activeScrollingTab = 0
    , activeCustomIconTab = 0
    }


type Msg
    = SetActiveHeroTab Int
    | SetActiveIconTab Int
    | SetActiveStackedTab Int
    | SetActiveScrollingTab Int
    | SetActiveCustomIconTab Int
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

        SetActiveCustomIconTab index ->
            ( { model | activeCustomIconTab = index }, Cmd.none )

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
        [ Html.h3 [ Typography.subtitle1 ] [ text "Tabs with Icons Next to Labels" ]
        , tabsWithIcons model
        , Html.h3 [ Typography.subtitle1 ]
            [ text "Tabs with Icons Above Labels and Indicators Restricted to Content" ]
        , tabsWithStackedIcons model
        , Html.h3 [ Typography.subtitle1 ] [ text "Scrolling Tabs" ]
        , scrollingTabs model
        , Html.h3 [ Typography.subtitle1 ] [ text "Tabs with Custom Icon" ]
        , tabsWithCustomIcons model
        , Html.h3 [ Typography.subtitle1 ] [ text "Focus Tabs" ]
        , focusTabs model
        ]
    }


heroTabs : Model -> String -> Html Msg
heroTabs model index =
    TabBar.tabBar TabBar.config
        (Tab.tab
            (Tab.config
                |> Tab.setActive (model.activeHeroTab == 0)
                |> Tab.setOnClick (SetActiveHeroTab 0)
            )
            { label = "Home", icon = Nothing }
        )
        [ Tab.tab
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
                |> Tab.setActive (model.activeCustomIconTab == index)
                |> Tab.setOnClick (SetActiveCustomIconTab index)
    in
    TabBar.tabBar TabBar.config
        (Tab.tab (config 0)
            { label = "Recents", icon = Just (Tab.icon "access_time") }
        )
        [ Tab.tab (config 1)
            { label = "Nearby", icon = Just (Tab.icon "near_me") }
        , Tab.tab (config 2)
            { label = "Favorites", icon = Just (Tab.icon "favorite") }
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
        (Tab.tab (config 0)
            { label = "Recents", icon = Just (Tab.icon "access_time") }
        )
        [ Tab.tab (config 1)
            { label = "Nearby", icon = Just (Tab.icon "near_me") }
        , Tab.tab (config 2)
            { label = "Favorites", icon = Just (Tab.icon "favorite") }
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
        (Tab.tab (config 0) { label = "Tab One", icon = Nothing })
        (List.indexedMap
            (\index label ->
                Tab.tab (config (1 + index))
                    { label = "Tab " ++ label, icon = Nothing }
            )
            [ "Two", "Three", "Four", "Five", "Six", "Seven", "Eight" ]
        )


tabsWithCustomIcons : Model -> Html Msg
tabsWithCustomIcons model =
    let
        config index =
            Tab.config
                |> Tab.setActive (model.activeIconTab == index)
                |> Tab.setOnClick (SetActiveIconTab index)
    in
    TabBar.tabBar TabBar.config
        (Tab.tab (config 0)
            { label = "Material Design"
            , icon = Just (Tab.icon "access_time")
            }
        )
        [ Tab.tab (config 1)
            { label = "Font Awesome"
            , icon =
                Just (Tab.customIcon Html.i [ class "fab fa-font-awesome" ] [])
            }
        , Tab.tab (config 2)
            { label = "SVG"
            , icon =
                Just (Tab.svgIcon [ Svg.Attributes.viewBox "0 0 100 100" ] elmLogo)
            }
        ]


focusTabs : Model -> Html Msg
focusTabs model =
    Html.div []
        [ TabBar.tabBar
            (TabBar.config
                |> TabBar.setAttributes [ Html.Attributes.id "my-tabs" ]
            )
            (Tab.tab
                (Tab.config
                    |> Tab.setActive (model.activeHeroTab == 0)
                    |> Tab.setOnClick (SetActiveHeroTab 0)
                )
                { label = "Home", icon = Nothing }
            )
            [ Tab.tab
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
