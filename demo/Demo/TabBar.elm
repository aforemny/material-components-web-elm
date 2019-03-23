module Demo.TabBar exposing (Model, Msg(..), defaultModel, subscriptions, update, view)

import Demo.Helper.Hero as Hero
import Demo.Helper.ResourceLink as ResourceLink
import Demo.Page as Page exposing (Page)
import Dict exposing (Dict)
import Html exposing (Html, text)
import Html.Attributes
import Html.Events
import Material.Tab as Tab exposing (tab, tabConfig)
import Material.TabBar as TabBar exposing (tabBar, tabBarConfig)
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


tab_ :
    (Msg -> m)
    -> String
    -> Int
    -> Model
    -> String
    -> Html m
tab_ lift index tabIndex model label =
    let
        active =
            tabIndex == Maybe.withDefault 0 (Dict.get index model.states)
    in
    tab
        { tabConfig
            | active = active
            , onClick = Just (lift (SelectTab index tabIndex))
        }
        { label = label, icon = Nothing }


heroTabs : (Msg -> m) -> Model -> String -> Html m
heroTabs lift model index =
    tabBar tabBarConfig
        [ tab_ lift index 0 model "Home"
        , tab_ lift index 1 model "Merchandise"
        , tab_ lift index 2 model "About Us"
        ]


tabsWithIcons : (Msg -> m) -> Model -> String -> List (Html.Attribute m) -> Html m
tabsWithIcons lift model index options =
    tabBar tabBarConfig
        [ iconTab lift index 0 model "access_time" "Recents" options
        , iconTab lift index 1 model "near_me" "Nearby" options
        , iconTab lift index 2 model "favorite" "Favorites" options
        ]


tabsWithStackedIcons : (Msg -> m) -> Model -> String -> Html m
tabsWithStackedIcons lift model index =
    tabBar tabBarConfig
        [ stackedTab lift index 0 model "access_time" "Recents"
        , stackedTab lift index 1 model "near_me" "Nearby"
        , stackedTab lift index 2 model "favorite" "Favorites"
        ]


scrollingTabs : (Msg -> m) -> Model -> String -> Html m
scrollingTabs lift model index =
    tabBar tabBarConfig
        ([ "One", "Two", "Three", "Four", "Five", "Six", "Seven", "Eight" ]
            |> List.indexedMap (\i v -> tab_ lift index i model ("Tab " ++ v))
        )


iconTab :
    (Msg -> m)
    -> String
    -> Int
    -> Model
    -> String
    -> String
    -> List (Html.Attribute m)
    -> Html m
iconTab lift index tabIndex model icon label options =
    let
        active =
            tabIndex == Maybe.withDefault 0 (Dict.get index model.states)
    in
    tab
        { tabConfig
            | active = active
            , onClick = Just (lift (SelectTab index tabIndex))
        }
        { label = label, icon = Just icon }


stackedTab :
    (Msg -> m)
    -> String
    -> Int
    -> Model
    -> String
    -> String
    -> Html m
stackedTab lift index tabIndex model icon label =
    let
        active =
            tabIndex == Maybe.withDefault 0 (Dict.get index model.states)
    in
    tab
        { tabConfig
            | onClick = Just (lift (SelectTab index tabIndex))
            , stacked = True
            , indicatorSpansContent = False
        }
        { label = label, icon = Just icon }


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
            , tabsWithIcons lift model "tabs-with-icons" []
            , Html.h3 [ Typography.subtitle1 ]
                [ text "Tabs with icons above labels and indicators restricted to content"
                ]
            , tabsWithStackedIcons lift model "tabs-with-stacked-icons"
            , Html.h3 [ Typography.subtitle1 ] [ text "Scrolling tabs" ]
            , scrollingTabs lift model "scrolling-tabs"
            ]
        ]
