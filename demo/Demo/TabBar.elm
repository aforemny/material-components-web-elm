module Demo.TabBar exposing (Model, Msg(..), defaultModel, subscriptions, update, view)

import Demo.Helper.Hero as Hero
import Demo.Helper.ResourceLink as ResourceLink
import Demo.Page as Page exposing (Page)
import Dict exposing (Dict)
import Html exposing (Html, text)
import Html.Attributes
import Html.Events
import Material.TabBar as TabBar
import Material.Theme as Theme
import Material.Typography as Typography
import Platform.Cmd exposing (Cmd, none)


type alias Model =
    { states : Dict String Int
    }


defaultModel : Model
defaultModel =
    { states = Dict.empty
    }


type Msg
    = SelectTab String Int


update : (Msg -> m) -> Msg -> Model -> ( Model, Cmd m )
update lift msg model =
    case msg of
        SelectTab index tabIndex ->
            ( { model | states = Dict.insert index tabIndex model.states }, Cmd.none )


subscriptions : (Msg -> m) -> Model -> Sub m
subscriptions lift model =
    Sub.none


tab :
    (Msg -> m)
    -> Model
    -> String
    -> Int
    -> String
    -> TabBar.Tab m
tab lift model index tab_index label =
    TabBar.tab
        [ Html.Events.onClick (lift (SelectTab index tab_index)) ]
        [ text label ]


heroTabs : (Msg -> m) -> Model -> String -> Html m
heroTabs lift model index =
    let
        active_tab_index =
            Dict.get index model.states |> Maybe.withDefault 0
    in
    TabBar.view lift
        index
        model.mdc
        [ TabBar.activeTab active_tab_index ]
        [ tab lift model index 0 "Home"
        , tab lift model index 1 "Merchandise"
        , tab lift model index 2 "About Us"
        ]


tabsWithIcons : (Msg -> m) -> Model -> String -> List (Html.Attribute m) -> Html m
tabsWithIcons lift model index options =
    let
        active_tab_index =
            Dict.get index model.states |> Maybe.withDefault 0
    in
    TabBar.view lift
        index
        model.mdc
        [ TabBar.activeTab active_tab_index ]
        [ iconTab lift model index 0 "access_time" "Recents" options
        , iconTab lift model index 1 "near_me" "Nearby" options
        , iconTab lift model index 2 "favorite" "Favorites" options
        ]


tabsWithStackedIcons : (Msg -> m) -> Model -> String -> Html m
tabsWithStackedIcons lift model index =
    let
        active_tab_index =
            Dict.get index model.states |> Maybe.withDefault 0
    in
    TabBar.view lift
        index
        model.mdc
        [ TabBar.activeTab active_tab_index ]
        [ stackedTab lift model index 0 "access_time" "Recents"
        , stackedTab lift model index 1 "near_me" "Nearby"
        , stackedTab lift model index 2 "favorite" "Favorites"
        ]


scrollingTabs : (Msg -> m) -> Model -> String -> Html m
scrollingTabs lift model index =
    let
        active_tab_index =
            Dict.get index model.states |> Maybe.withDefault 0
    in
    TabBar.view lift
        index
        model.mdc
        [ TabBar.activeTab active_tab_index ]
        ([ "One", "Two", "Three", "Four", "Five", "Six", "Seven", "Eight" ]
            |> List.indexedMap (\i v -> tab lift model index i ("Tab " ++ v))
        )


iconTab :
    (Msg -> m)
    -> Model
    -> String
    -> Int
    -> String
    -> String
    -> List (Html.Attribute m)
    -> TabBar.Tab m
iconTab lift model index tab_index icon label options =
    TabBar.tab
        ([ Html.Events.onClick (lift (SelectTab index tab_index))
         , TabBar.icon icon
         ]
            ++ options
        )
        [ text label ]


stackedTab :
    (Msg -> m)
    -> Model
    -> String
    -> Int
    -> String
    -> String
    -> TabBar.Tab m
stackedTab lift model index tab_index icon label =
    TabBar.tab
        [ Html.Events.onClick (lift (SelectTab index tab_index))
        , TabBar.icon icon
        , TabBar.stacked
        , TabBar.smallIndicator
        ]
        [ text label ]


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
            [ h3 [ Typography.subtitle1 ] [ text "Tabs with icons next to labels" ]
            , tabsWithIcons lift model "tabs-with-icons" []
            , h3 [ Typography.subtitle1 ] [ text "Tabs with icons above labels and indicators restricted to content" ]
            , tabsWithStackedIcons lift model "tabs-with-stacked-icons"
            , h3 [ Typography.subtitle1 ] [ text "Scrolling tabs" ]
            , scrollingTabs lift model "scrolling-tabs"
            ]
        ]
