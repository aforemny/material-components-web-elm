module Material.TopAppBar exposing
    ( TopAppBarConfig
    , actionItem
    , alignEnd
    , alignStart
    , denseFixedAdjust
    , denseProminentFixedAdjust
    , fixedAdjust
    , navigationIcon
    , prominentFixedAdjust
    , prominentTopAppBar
    , row
    , section
    , shortCollapsedTopAppBar
    , shortFixedAdjust
    , shortTopAppBar
    , title
    , topAppBar
    , topAppBarConfig
    )

import Html exposing (Html, text)
import Html.Attributes exposing (class)


type alias TopAppBarConfig msg =
    { variant : Variant
    , dense : Bool
    , fixed : Bool
    , additionalAttributes : List (Html.Attribute msg)
    }


type Variant
    = Default
    | Short
    | ShortCollapsed
    | Prominent


topAppBarConfig : TopAppBarConfig msg
topAppBarConfig =
    { variant = Default
    , dense = False
    , fixed = False
    , additionalAttributes = []
    }


topAppBar : TopAppBarConfig msg -> List (Html msg) -> Html msg
topAppBar config nodes =
    Html.node "mdc-top-app-bar"
        (List.filterMap identity
            [ rootCs
            , variantCs config
            , denseCs config
            , fixedCs config
            ]
            ++ config.additionalAttributes
        )
        nodes


shortTopAppBar : TopAppBarConfig msg -> List (Html msg) -> Html msg
shortTopAppBar config nodes =
    topAppBar { config | variant = Short } nodes


shortCollapsedTopAppBar : TopAppBarConfig msg -> List (Html msg) -> Html msg
shortCollapsedTopAppBar config nodes =
    topAppBar { config | variant = ShortCollapsed } nodes


prominentTopAppBar : TopAppBarConfig msg -> List (Html msg) -> Html msg
prominentTopAppBar config nodes =
    topAppBar { config | variant = Prominent } nodes


row : List (Html.Attribute msg) -> List (Html msg) -> Html msg
row attributes nodes =
    Html.section ([ class "mdc-top-app-bar__row" ] ++ attributes) nodes


section : List (Html.Attribute msg) -> List (Html msg) -> Html msg
section attributes nodes =
    Html.section ([ class "mdc-top-app-bar__section" ] ++ attributes) nodes


alignStart : Html.Attribute msg
alignStart =
    class "mdc-top-app-bar__section--align-start"


alignEnd : Html.Attribute msg
alignEnd =
    class "mdc-top-app-bar__section--align-end"


navigationIcon : Html.Attribute msg
navigationIcon =
    class "mdc-top-app-bar__navigation-icon"


title : Html.Attribute msg
title =
    class "mdc-top-app-bar__title"


actionItem : Html.Attribute msg
actionItem =
    class "mdc-top-app-bar__action-item"


rootCs : Maybe (Html.Attribute msg)
rootCs =
    Just (class "mdc-top-app-bar")


variantCs : TopAppBarConfig msg -> Maybe (Html.Attribute msg)
variantCs { variant } =
    case variant of
        Default ->
            Nothing

        Short ->
            Just (class "mdc-top-app-bar--short")

        ShortCollapsed ->
            Just (class "mdc-top-app-bar--short mdc-top-app-bar--short-collapsed")

        Prominent ->
            Just (class "mdc-top-app-bar--prominent")


denseCs : TopAppBarConfig msg -> Maybe (Html.Attribute msg)
denseCs { dense } =
    if dense then
        Just (class "mdc-top-app-bar--dense")

    else
        Nothing


fixedCs : TopAppBarConfig msg -> Maybe (Html.Attribute msg)
fixedCs { fixed } =
    if fixed then
        Just (class "mdc-top-app-bar--fixed")

    else
        Nothing


fixedAdjust : Html.Attribute msg
fixedAdjust =
    class "mdc-top-app-bar--fixed-adjust"


denseFixedAdjust : Html.Attribute msg
denseFixedAdjust =
    class "mdc-top-app-bar--dense-fixed-adjust"


shortFixedAdjust : Html.Attribute msg
shortFixedAdjust =
    class "mdc-top-app-bar--short-fixed-adjust"


prominentFixedAdjust : Html.Attribute msg
prominentFixedAdjust =
    class "mdc-top-app-bar--prominent-fixed-adjust"


denseProminentFixedAdjust : Html.Attribute msg
denseProminentFixedAdjust =
    class "mdc-top-app-bar--dense-prominent-fixed-adjust"
