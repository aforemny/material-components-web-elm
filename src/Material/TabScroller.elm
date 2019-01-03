module Material.TabScroller exposing (Align(..), Config, tabScroller, tabScrollerConfig)

import Html exposing (Html, text)
import Html.Attributes exposing (class)


type alias Config msg =
    { align : Maybe Align
    , additionalAttributes : List (Html.Attribute msg)
    }


type Align
    = AlignStart
    | AlignEnd
    | AlignCenter


tabScrollerConfig : Config msg
tabScrollerConfig =
    { align = Nothing
    , additionalAttributes = []
    }


tabScroller : Config msg -> List (Html msg) -> Html msg
tabScroller config nodes =
    Html.node "mdc-tab-scroller"
        (List.filterMap identity
            [ rootCs
            , alignCs config
            ]
            ++ config.additionalAttributes
        )
        [ scrollAreaElt nodes
        ]


rootCs : Maybe (Html.Attribute msg)
rootCs =
    Just (class "mdc-tab-scroller")


alignCs : Config msg -> Maybe (Html.Attribute msg)
alignCs { align } =
    case align of
        Just AlignStart ->
            Just (class "mdc-tab-scroller--align-start")

        Just AlignEnd ->
            Just (class "mdc-tab-scroller--align-end")

        Just AlignCenter ->
            Just (class "mdc-tab-scroller--align-center")

        Nothing ->
            Nothing


scrollAreaElt : List (Html msg) -> Html msg
scrollAreaElt nodes =
    Html.div [ class "mdc-tab-scroller__scroll-area" ] [ scrollContentElt nodes ]


scrollContentElt : List (Html msg) -> Html msg
scrollContentElt nodes =
    Html.div [ class "mdc-tab-scroller__scroll-content" ] nodes
