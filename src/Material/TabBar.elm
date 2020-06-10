module Material.TabBar exposing
    ( Config, config
    , setStacked
    , setMinWidth
    , setIndicatorSpansContent
    , setAlign
    , setAttributes
    , tabBar
    , Align(..)
    )

{-| Tabs organize and allow navigation between groups of content that are
related and at the same level of hierarchy. The tab bar contains the tab
components.

This module concerns the tab bar container. If you are looking for the tab
item, refer to [Material.Tab](Material-Tab).


# Table of Contents

  - [Resources](#resources)
  - [Basic Usage](#basic-usage)
  - [Configuration](#configuration)
      - [Configuration Options](#configuration-options)
  - [Tab Bar](#tab-bar)
  - [Stacked Tabs](#stacked-tabs)
  - [Minimum Width Tabs](#minimum-width-tabs)
  - [Content-Spanning Tab Indicator](#content-spanning-tab-indicator)
  - [Tab Scroller](#tab-scroller)
      - [Tab Scroller Alignment](#tab-scroller-alignment)


# Resources

  - [Demo: Tab Bar](https://aforemny.github.io/material-components-web-elm/#tabbar)
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

    import Material.Tab as Tab
    import Material.TabBar as TabBar

    type Msg
        = TabClicked Int

    main =
        TabBar.tabBar TabBar.config
            [ Tab.tab
                (Tab.config
                    |> Tab.setActive True
                    |> Tab.setOnClick (TabClicked 0)
                )
                { label = "Tab 1", icon = Nothing }
            , Tab.tab
                (Tab.config |> Tab.setOnClick (TabClicked 1))
                { label = "Tab 2", icon = Nothing }
            ]


# Configuration

@docs Config, config


## Configuration Options

@docs setStacked
@docs setMinWidth
@docs setIndicatorSpansContent
@docs setAlign
@docs setAttributes


# Tab Bar

@docs tabBar


# Stacked Tabs

In a _stacked_ tab bar, the label and icon of a tab flow vertically instead of
horizontally. To make a tab bar stacked, set its `setStacked` configuration
option to `True`.

Tabs within a stacked tab bar should specify both a label and an icon.

    TabBar.tabBar (TabBar.config |> TabBar.setStacked True) []


# Minimum Width Tabs

Tabs by defauls span a minimum width. If you want tabs to be as narrow as
possible, set the tab bar's `setMinWidth` configuration option to `True`.

    TabBar.tabBar (TabBar.config |> TabBar.setMinWidth True) []


# Content-Spanning Tab Indicator

The tab's active indicator by default spans the entire tab. If you want active
indicators to only span their tab's content, set the tab bar's
`setIndicatorSpansContent` configuration option to `True`.

    TabBar.tabBar
        (TabBar.config |> TabBar.setIndicatorSpansContent True)
        []


# Tab scroller

The tab bar supports tabs overflowing its width and will enable scrolling in
that case. You may change the alignment of the elements inside the scroll
content.

@docs Align


## Center-aligned tab scroller

    TabBar.tabBar
        (TabBar.config |> TabBar.setAlign (Just TabBar.Center))
        []

-}

import Html exposing (Html, text)
import Html.Attributes exposing (class)
import Html.Events
import Json.Decode as Decode
import Json.Encode as Encode
import Material.Tab.Internal as Tab exposing (Tab(..))


{-| Configuration of a tab bar
-}
type Config msg
    = Config
        { stacked : Bool
        , minWidth : Bool
        , indicatorSpansContent : Bool
        , additionalAttributes : List (Html.Attribute msg)
        , align : Maybe Align
        }


{-| Default configuration of a tab bar
-}
config : Config msg
config =
    Config
        { stacked = False
        , minWidth = False
        , indicatorSpansContent = False
        , align = Nothing
        , additionalAttributes = []
        }


{-| Specify a tab bar's tabs to be stacked

Stacked tabs display their icon below the their label.

-}
setStacked : Bool -> Config msg -> Config msg
setStacked stacked (Config config_) =
    Config { config_ | stacked = stacked }


{-| Specify whether a tab bar's tabs should be of minimum width

Usually, a tab bar's tabs have a minimum with. Using this option, tabs are as
narrow as possible.

-}
setMinWidth : Bool -> Config msg -> Config msg
setMinWidth minWidth (Config config_) =
    Config { config_ | minWidth = minWidth }


{-| Specify whether a tab bar's tab indicator spans its content

Usually, a tab bar's tab indicator spans the entire tab. Use this option to
make it span only it's label instead.

-}
setIndicatorSpansContent : Bool -> Config msg -> Config msg
setIndicatorSpansContent indicatorSpansContent (Config config_) =
    Config { config_ | indicatorSpansContent = indicatorSpansContent }


{-| Specify tab bar's alignment of tabs in case they overflow horizontally
-}
setAlign : Maybe Align -> Config msg -> Config msg
setAlign align (Config config_) =
    Config { config_ | align = align }


{-| Specify additional attribtues
-}
setAttributes : List (Html.Attribute msg) -> Config msg -> Config msg
setAttributes additionalAttributes (Config config_) =
    Config { config_ | additionalAttributes = additionalAttributes }


{-| Tab bar view function
-}
tabBar : Config msg -> List (Tab msg) -> Html msg
tabBar ((Config { additionalAttributes, align }) as config_) tabs =
    Html.node "mdc-tab-bar"
        (List.filterMap identity
            [ rootCs
            , tablistRoleAttr
            , activeTabIndexProp tabs
            ]
            ++ additionalAttributes
        )
        [ tabScroller config_ align tabs ]


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
                |> List.filter (\( _, Tab (Tab.Config { active }) ) -> active)
                |> List.head
                |> Maybe.map Tuple.first
    in
    Maybe.map (Html.Attributes.property "activeTabIndex" << Encode.int) activeTabIndex


viewTab : Config msg -> Tab msg -> Html msg
viewTab ((Config { indicatorSpansContent }) as barConfig) ((Tab ((Tab.Config { additionalAttributes, content }) as tabConfig)) as tab) =
    Html.button
        (List.filterMap identity
            [ tabCs
            , tabRoleAttr
            , tabStackedCs barConfig
            , tabMinWidthCs barConfig
            , tabClickHandler tabConfig
            ]
            ++ additionalAttributes
        )
        (List.filterMap identity <|
            if indicatorSpansContent then
                [ tabContentElt barConfig tabConfig content
                , tabRippleElt
                ]

            else
                [ tabContentElt barConfig tabConfig content
                , tabIndicatorElt tabConfig
                , tabRippleElt
                ]
        )


tabCs : Maybe (Html.Attribute msg)
tabCs =
    Just (class "mdc-tab")


tabStackedCs : Config msg -> Maybe (Html.Attribute msg)
tabStackedCs (Config { stacked }) =
    if stacked then
        Just (class "mdc-tab--stacked")

    else
        Nothing


tabMinWidthCs : Config msg -> Maybe (Html.Attribute msg)
tabMinWidthCs (Config { minWidth }) =
    if minWidth then
        Just (class "mdc-tab--min-width")

    else
        Nothing


tabRoleAttr : Maybe (Html.Attribute msg)
tabRoleAttr =
    Just (Html.Attributes.attribute "role" "tab")


tabClickHandler : Tab.Config msg -> Maybe (Html.Attribute msg)
tabClickHandler (Tab.Config { onClick }) =
    Maybe.map (Html.Events.on "MDCTab:interacted" << Decode.succeed) onClick


tabContentElt : Config msg -> Tab.Config msg -> Tab.Content -> Maybe (Html msg)
tabContentElt ((Config { indicatorSpansContent }) as barConfig) config_ content =
    Just
        (Html.div [ class "mdc-tab__content" ]
            (if indicatorSpansContent then
                List.filterMap identity
                    [ tabIconElt content
                    , tabTextLabelElt content
                    , tabIndicatorElt config_
                    ]

             else
                List.filterMap identity
                    [ tabIconElt content
                    , tabTextLabelElt content
                    ]
            )
        )


tabIconElt : Tab.Content -> Maybe (Html msg)
tabIconElt { icon } =
    Maybe.map
        (\iconName ->
            Html.span
                [ class "mdc-tab__icon material-icons" ]
                [ text iconName ]
        )
        icon


tabTextLabelElt : Tab.Content -> Maybe (Html msg)
tabTextLabelElt { label } =
    Just (Html.span [ class "mdc-tab__text-label" ] [ text label ])


tabIndicatorElt : Tab.Config msg -> Maybe (Html msg)
tabIndicatorElt config_ =
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


{-| Alignment of a tab scroller
-}
type Align
    = Start
    | End
    | Center


tabScroller : Config msg -> Maybe Align -> List (Tab msg) -> Html msg
tabScroller config_ align tabs =
    Html.div
        (List.filterMap identity
            [ tabScrollerCs
            , tabScrollerAlignCs align
            ]
        )
        [ tabScrollerScrollAreaElt config_ tabs ]


tabScrollerCs : Maybe (Html.Attribute msg)
tabScrollerCs =
    Just (class "mdc-tab-scroller")


tabScrollerAlignCs : Maybe Align -> Maybe (Html.Attribute msg)
tabScrollerAlignCs align =
    case align of
        Just Start ->
            Just (class "mdc-tab-scroller--align-start")

        Just End ->
            Just (class "mdc-tab-scroller--align-end")

        Just Center ->
            Just (class "mdc-tab-scroller--align-center")

        Nothing ->
            Nothing


tabScrollerScrollAreaElt : Config msg -> List (Tab msg) -> Html msg
tabScrollerScrollAreaElt barConfig tabs =
    Html.div [ class "mdc-tab-scroller__scroll-area" ]
        [ tabScrollerScrollContentElt barConfig tabs ]


tabScrollerScrollContentElt : Config msg -> List (Tab msg) -> Html msg
tabScrollerScrollContentElt barConfig tabs =
    Html.div [ class "mdc-tab-scroller__scroll-content" ]
        (List.map (viewTab barConfig) tabs)
