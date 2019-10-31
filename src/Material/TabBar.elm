module Material.TabBar exposing
    ( tabBar, tabBarConfig, TabBarConfig
    , tab, tabConfig, TabConfig, TabContent, Tab
    , TabScrollerConfig, tabScrollerConfig
    , TabScrollerAlign(..)
    )

{-| Tabs organize and allow navigation between groups of content that are
related and at the same level of hierarchy. The Tab Bar contains the Tab
Scroller and Tab components.


# Table of Contents

  - [Resources](#resources)
  - [Basic Usage](#basic-usage)
  - [Tab Bar](#tab-bar)
  - [Tabs](#tabs)
  - [Stacked Tabs](#stacked-tabs)
  - [Minimum Width Tabs](#minimum-width-tabs)
  - [Content-Spanning Tab Indicator](#content-spanning-tab-indicator)
  - [Tab Scroller](#tab-scroller)
      - [Tab Scroller Alignment](#tab-scroller-alignment)


# Resources

  - [Demo: Tab Bar](https://aforemny.github.io/material-components-web-elm/#tab-bars)
  - [Material Design Guidelines: Tabs](https://material.io/go/design-tabs)
  - MDC Web:
    [Tab Bar](https://github.com/material-components/material-components-web/tree/master/packages/mdc-tab-bar),
    [Tab](https://github.com/material-components/material-components-web/tree/master/packages/mdc-tab),
    [Tab Scroller](https://github.com/material-components/material-components-web/tree/master/packages/mdc-tab-scroller)
  - Sass Mixins:
    [Tab Bar](https://github.com/material-components/material-components-web/tree/master/packages/mdc-tab-bar#sass-mixins),
    [Tab](https://github.com/material-components/material-components-web/tree/master/packages/mdc-tab#sass-mixins),
    [Tab Scroller](https://github.com/material-components/material-components-web/tree/master/packages/mdc-tab-scroller#sass-mixins)


# Basic Usage

    import Material.TabBar
        exposing
            ( tab
            , tabBar
            , tabBarConfig
            , tabConfig
            )

    type Msg
        = TabClicked Int

    main =
        tabBar tabBarConfig
            [ tab
                { tabConfig
                    | active = True
                    , onClick = Just (TabClicked 0)
                }
                { label = "Tab 1", icon = Nothing }
            , tab
                { tabConfig
                    | active = False
                    , onClick = Just (TabClicked 1)
                }
                { label = "Tab 1", icon = Nothing }
            ]


# Tab Bar

@docs tabBar, tabBarConfig, TabBarConfig


# Tabs

@docs tab, tabConfig, TabConfig, TabContent, Tab


# Stacked Tabs

In a stacked tab bar, the label and icon of a tab flow vertically instead of
horizontally. To make a tab bar stacked, set its `stacked` configuration
field to `True`.

Requires that the `tab`s have both `label` and `icon`.

        tabBar
            { tabBarConfig | stacked = True }
            [ tab tabConfig
            { label = "Favorites", icon = Just "favorite" }
            ]


# Minimum Width Tabs

Tabs by defauls span a minimum width. If you want tabs to be as narrow as
possible, set the tab bar's `minWidth` configuration field to `True`.

        tabBar
            { tabBarConfig | minWidth = True }
            [ tab tabConfig
                { label = "Favorites", icon = Nothing }
            ]


# Content-Spanning Tab Indicator

The tab's active indicator by default spans the entire tab. If you want active
indicators to only span their tab's content, set the tab bar's
`indicatorSpansContent` configuration field to `True`.

        tabBar
            { tabBarConfig | indicatorSpansContent = True }
            [ tab tabConfig
                { label = "Favorites", icon = Nothing }
            ]


# Tab scroller

The tab bar supports tabs overflowing its width and will enable scrolling in
that case. You may change the alignment of the elements inside the scroll
content.

@docs TabScrollerConfig, tabScrollerConfig
@docs TabScrollerAlign


## Center-aligned tab scroller

        tabBar
            { tabBarConfig
                | tabScrollerConfig =
                  { tabScrollerConfig
                      | align =
                          Just TabBar.TabScrollerAlignCenter
                  }
            }
            [ tab
                { tabConfig
                    | active = True
                    , onClick = Just (TabClicked 0)
                }
                { label = "Tab 1", icon = Nothing }
            , tab
                { tabConfig
                    | active = False
                    , onClick = Just (TabClicked 1)
                }
                { label = "Tab 1", icon = Nothing }
            ]

-}

import Html exposing (Html, text)
import Html.Attributes exposing (class)
import Html.Events
import Json.Decode as Decode
import Json.Encode as Encode


{-| Configuration of a tab bar
-}
type alias TabBarConfig msg =
    { stacked : Bool
    , minWidth : Bool
    , indicatorSpansContent : Bool
    , additionalAttributes : List (Html.Attribute msg)
    , tabScrollerConfig : TabScrollerConfig msg
    }


{-| Default configuration of a tab bar
-}
tabBarConfig : TabBarConfig msg
tabBarConfig =
    { stacked = False
    , minWidth = False
    , indicatorSpansContent = False
    , additionalAttributes = []
    , tabScrollerConfig = tabScrollerConfig
    }


{-| Tab bar view function
-}
tabBar : TabBarConfig msg -> List (Tab msg) -> Html msg
tabBar config tabs =
    Html.node "mdc-tab-bar"
        (List.filterMap identity
            [ rootCs
            , tablistRoleAttr
            , activeTabIndexProp tabs
            ]
            ++ config.additionalAttributes
        )
        [ tabScroller config config.tabScrollerConfig tabs
        ]


rootCs : Maybe (Html.Attribute msg)
rootCs =
    Just (class "mdc-tab-bar")


tablistRoleAttr : Maybe (Html.Attribute msg)
tablistRoleAttr =
    Just (Html.Attributes.attribute "role" "tablist")


activeTabIndexProp : List (Tab msg) -> Maybe (Html.Attribute msg)
activeTabIndexProp tabs =
    let
        activeTabIndex =
            List.indexedMap Tuple.pair tabs
                |> List.filter (\( _, Tab { config } ) -> config.active)
                |> List.head
                |> Maybe.map Tuple.first
    in
    Maybe.map (Html.Attributes.property "activeTabIndex" << Encode.int) activeTabIndex


{-| Configuration of a tab
-}
type alias TabConfig msg =
    { active : Bool
    , additionalAttributes : List (Html.Attribute msg)
    , onClick : Maybe msg
    }


{-| Default configuration of a tab
-}
tabConfig : TabConfig msg
tabConfig =
    { active = False
    , additionalAttributes = []
    , onClick = Nothing
    }


{-| Content of a tab
-}
type alias TabContent =
    { label : String
    , icon : Maybe String
    }


{-| Tab
-}
type Tab msg
    = Tab { config : TabConfig msg, content : TabContent }


{-| Tab constructor
-}
tab : TabConfig msg -> TabContent -> Tab msg
tab config content =
    Tab { config = config, content = content }


viewTab : TabBarConfig msg -> Tab msg -> Html msg
viewTab barConfig (Tab { config, content }) =
    Html.button
        (List.filterMap identity
            [ tabCs
            , tabRoleAttr
            , tabStackedCs barConfig
            , tabMinWidthCs barConfig
            , tabClickHandler config
            ]
            ++ config.additionalAttributes
        )
        (List.filterMap identity <|
            if barConfig.indicatorSpansContent then
                [ tabContentElt barConfig config content
                , tabRippleElt
                ]

            else
                [ tabContentElt barConfig config content
                , tabIndicatorElt config
                , tabRippleElt
                ]
        )


tabCs : Maybe (Html.Attribute msg)
tabCs =
    Just (class "mdc-tab")


tabStackedCs : TabBarConfig msg -> Maybe (Html.Attribute msg)
tabStackedCs { stacked } =
    if stacked then
        Just (class "mdc-tab--stacked")

    else
        Nothing


tabMinWidthCs : TabBarConfig msg -> Maybe (Html.Attribute msg)
tabMinWidthCs { minWidth } =
    if minWidth then
        Just (class "mdc-tab--min-width")

    else
        Nothing


tabRoleAttr : Maybe (Html.Attribute msg)
tabRoleAttr =
    Just (Html.Attributes.attribute "role" "tab")


tabClickHandler : TabConfig msg -> Maybe (Html.Attribute msg)
tabClickHandler { onClick } =
    Maybe.map (Html.Events.on "MDCTab:interacted" << Decode.succeed) onClick


tabContentElt : TabBarConfig msg -> TabConfig msg -> TabContent -> Maybe (Html msg)
tabContentElt barConfig config content =
    Just
        (Html.div [ class "mdc-tab__content" ]
            (if barConfig.indicatorSpansContent then
                List.filterMap identity
                    [ tabIconElt content
                    , tabTextLabelElt content
                    , tabIndicatorElt config
                    ]

             else
                List.filterMap identity
                    [ tabIconElt content
                    , tabTextLabelElt content
                    ]
            )
        )


tabIconElt : TabContent -> Maybe (Html msg)
tabIconElt { icon } =
    Maybe.map
        (\iconName ->
            Html.span
                [ class "mdc-tab__icon material-icons" ]
                [ text iconName ]
        )
        icon


tabTextLabelElt : TabContent -> Maybe (Html msg)
tabTextLabelElt { label } =
    Just (Html.span [ class "mdc-tab__text-label" ] [ text label ])


tabIndicatorElt : TabConfig msg -> Maybe (Html msg)
tabIndicatorElt config =
    Just (Html.span [ class "mdc-tab-indicator" ] [ tabIndicatorContentElt ])


tabIndicatorContentElt : Html msg
tabIndicatorContentElt =
    Html.span
        [ class "mdc-tab-indicator__content"
        , class "mdc-tab-indicator__content--underline"
        ]
        []


tabRippleElt : Maybe (Html msg)
tabRippleElt =
    Just (Html.span [ class "mdc-tab__ripple" ] [])


{-| Configuration of a tab scroller
-}
type alias TabScrollerConfig msg =
    { align : Maybe TabScrollerAlign
    , additionalAttributes : List (Html.Attribute msg)
    }


{-| Alignment of a tab scroller
-}
type TabScrollerAlign
    = TabScrollerAlignStart
    | TabScrollerAlignEnd
    | TabScrollerAlignCenter


{-| Default configuration of a tab scroller
-}
tabScrollerConfig : TabScrollerConfig msg
tabScrollerConfig =
    { align = Nothing
    , additionalAttributes = []
    }


tabScroller : TabBarConfig msg -> TabScrollerConfig msg -> List (Tab msg) -> Html msg
tabScroller barConfig config tabs =
    Html.div
        (List.filterMap identity
            [ tabScrollerCs
            , tabScrollerAlignCs config
            ]
            ++ config.additionalAttributes
        )
        [ tabScrollerScrollAreaElt barConfig tabs ]


tabScrollerCs : Maybe (Html.Attribute msg)
tabScrollerCs =
    Just (class "mdc-tab-scroller")


tabScrollerAlignCs : TabScrollerConfig msg -> Maybe (Html.Attribute msg)
tabScrollerAlignCs { align } =
    case align of
        Just TabScrollerAlignStart ->
            Just (class "mdc-tab-scroller--align-start")

        Just TabScrollerAlignEnd ->
            Just (class "mdc-tab-scroller--align-end")

        Just TabScrollerAlignCenter ->
            Just (class "mdc-tab-scroller--align-center")

        Nothing ->
            Nothing


tabScrollerScrollAreaElt : TabBarConfig msg -> List (Tab msg) -> Html msg
tabScrollerScrollAreaElt barConfig tabs =
    Html.div [ class "mdc-tab-scroller__scroll-area" ]
        [ tabScrollerScrollContentElt barConfig tabs ]


tabScrollerScrollContentElt : TabBarConfig msg -> List (Tab msg) -> Html msg
tabScrollerScrollContentElt barConfig tabs =
    Html.div [ class "mdc-tab-scroller__scroll-content" ]
        (List.map (viewTab barConfig) tabs)
