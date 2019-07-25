module Material.TabBar exposing
    ( TabBarConfig, tabBarConfig
    , tabBar
    , Tab, tabConfig
    , tab, TabContent
    , TabScrollerConfig, tabScrollerConfig
    , TabScrollerAlign(..)
    )

{-|

@docs TabBarConfig, tabBarConfig
@docs tabBar

@docs Tab, tabConfig
@docs tab, TabContent

@docs TabScrollerConfig, tabScrollerConfig
@docs TabScrollerAlign

-}

import Html exposing (Html, text)
import Html.Attributes exposing (class)
import Html.Events
import Json.Decode as Decode


{-| TODO docs
-}
type alias TabBarConfig msg =
    { additionalAttributes : List (Html.Attribute msg)
    , tabScrollerConfig : TabScrollerConfig msg
    }


{-| TODO docs
-}
tabBarConfig : TabBarConfig msg
tabBarConfig =
    { additionalAttributes = []
    , tabScrollerConfig = tabScrollerConfig
    }


{-| TODO docs
-}
tabBar : TabBarConfig msg -> List (Tab msg) -> Html msg
tabBar config tabs =
    Html.node "mdc-tab-bar"
        (List.filterMap identity
            [ rootCs
            , tablistRoleAttr
            , activeTabAttr tabs
            ]
            ++ config.additionalAttributes
        )
        [ tabScroller config.tabScrollerConfig tabs
        ]


rootCs : Maybe (Html.Attribute msg)
rootCs =
    Just (class "mdc-tab-bar")


tablistRoleAttr : Maybe (Html.Attribute msg)
tablistRoleAttr =
    Just (Html.Attributes.attribute "role" "tablist")


activeTabAttr : List (Tab msg) -> Maybe (Html.Attribute msg)
activeTabAttr tabs =
    let
        activeTabIndex =
            List.indexedMap Tuple.pair tabs
                |> List.filter (\( _, Tab { config } ) -> config.active)
                |> List.head
                |> Maybe.map Tuple.first
                |> Maybe.map String.fromInt
    in
    Maybe.map (Html.Attributes.attribute "activetab") activeTabIndex


{-| TODO docs
-}
type alias TabConfig msg =
    { active : Bool
    , stacked : Bool
    , minWidth : Bool
    , indicatorSpansContent : Bool
    , additionalAttributes : List (Html.Attribute msg)
    , onClick : Maybe msg
    }


{-| TODO docs
-}



-- TODO: move indicatorSpansContent to tab bar's TabBarConfig, possibly. also
-- stacked, minWidth, etc.?


tabConfig : TabConfig msg
tabConfig =
    { active = False
    , stacked = False
    , minWidth = False
    , indicatorSpansContent = False
    , additionalAttributes = []
    , onClick = Nothing
    }


{-| TODO docs
-}
type alias TabContent =
    { label : String
    , icon : Maybe String
    }


{-| TODO docs
-}
type Tab msg
    = Tab { config : TabConfig msg, content : TabContent }


{-| TODO docs
-}
tab : TabConfig msg -> TabContent -> Tab msg
tab config content =
    Tab { config = config, content = content }


viewTab : Tab msg -> Html msg
viewTab (Tab { config, content }) =
    Html.button
        (List.filterMap identity
            [ tabCs
            , tabRoleAttr
            , tabStackedCs config
            , tabMinWidthCs config
            , tabClickHandler config
            ]
            ++ config.additionalAttributes
        )
        (List.filterMap identity <|
            if config.indicatorSpansContent then
                [ tabContentElt config content
                , tabRippleElt
                ]

            else
                [ tabContentElt config content
                , tabIndicatorElt config
                , tabRippleElt
                ]
        )


tabCs : Maybe (Html.Attribute msg)
tabCs =
    Just (class "mdc-tab")


tabStackedCs : TabConfig msg -> Maybe (Html.Attribute msg)
tabStackedCs { stacked } =
    if stacked then
        Just (class "mdc-tab--stacked")

    else
        Nothing


tabMinWidthCs : TabConfig msg -> Maybe (Html.Attribute msg)
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


tabContentElt : TabConfig msg -> TabContent -> Maybe (Html msg)
tabContentElt config content =
    Just
        (Html.div [ class "mdc-tab__content" ]
            (if config.indicatorSpansContent then
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


{-| TODO docs
-}
type alias TabScrollerConfig msg =
    { align : Maybe TabScrollerAlign
    , additionalAttributes : List (Html.Attribute msg)
    }


{-| TODO docs
-}
type TabScrollerAlign
    = TabScrollerAlignStart
    | TabScrollerAlignEnd
    | TabScrollerAlignCenter


{-| TODO docs
-}
tabScrollerConfig : TabScrollerConfig msg
tabScrollerConfig =
    { align = Nothing
    , additionalAttributes = []
    }


tabScroller : TabScrollerConfig msg -> List (Tab msg) -> Html msg
tabScroller config tabs =
    Html.div
        (List.filterMap identity
            [ tabScrollerCs
            , tabScrollerAlignCs config
            ]
            ++ config.additionalAttributes
        )
        [ tabScrollerScrollAreaElt tabs
        ]


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


tabScrollerScrollAreaElt : List (Tab msg) -> Html msg
tabScrollerScrollAreaElt tabs =
    Html.div [ class "mdc-tab-scroller__scroll-area" ]
        [ tabScrollerScrollContentElt tabs ]


tabScrollerScrollContentElt : List (Tab msg) -> Html msg
tabScrollerScrollContentElt tabs =
    Html.div [ class "mdc-tab-scroller__scroll-content" ] (List.map viewTab tabs)
