module Material.TopAppBar exposing
    ( TopAppBarConfig, topAppBarConfig
    , topAppBar, prominentTopAppBar, shortTopAppBar, shortCollapsedTopAppBar
    , section, row
    , alignEnd, alignStart
    , title
    , navigationIcon
    , actionItem
    , fixedAdjust
    , denseFixedAdjust
    , denseProminentFixedAdjust
    , prominentFixedAdjust
    , shortFixedAdjust
    )

{-|

@docs TopAppBarConfig, topAppBarConfig
@docs topAppBar, prominentTopAppBar, shortTopAppBar, shortCollapsedTopAppBar

@docs section, row
@docs alignEnd, alignStart

@docs title
@docs navigationIcon
@docs actionItem

@docs fixedAdjust
@docs denseFixedAdjust
@docs denseProminentFixedAdjust
@docs prominentFixedAdjust
@docs shortFixedAdjust

-}

import Html exposing (Html, text)
import Html.Attributes exposing (class)


{-| TODO docs
-}
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


{-| TODO docs
-}
topAppBarConfig : TopAppBarConfig msg
topAppBarConfig =
    { variant = Default
    , dense = False
    , fixed = False
    , additionalAttributes = []
    }


{-| TODO docs
-}
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


{-| TODO docs
-}
shortTopAppBar : TopAppBarConfig msg -> List (Html msg) -> Html msg
shortTopAppBar config nodes =
    topAppBar { config | variant = Short } nodes


{-| TODO docs
-}
shortCollapsedTopAppBar : TopAppBarConfig msg -> List (Html msg) -> Html msg
shortCollapsedTopAppBar config nodes =
    topAppBar { config | variant = ShortCollapsed } nodes


{-| TODO docs
-}
prominentTopAppBar : TopAppBarConfig msg -> List (Html msg) -> Html msg
prominentTopAppBar config nodes =
    topAppBar { config | variant = Prominent } nodes


{-| TODO docs
-}
row : List (Html.Attribute msg) -> List (Html msg) -> Html msg
row attributes nodes =
    Html.section ([ class "mdc-top-app-bar__row" ] ++ attributes) nodes


{-| TODO docs
-}
section : List (Html.Attribute msg) -> List (Html msg) -> Html msg
section attributes nodes =
    Html.section ([ class "mdc-top-app-bar__section" ] ++ attributes) nodes


{-| TODO docs
-}
alignStart : Html.Attribute msg
alignStart =
    class "mdc-top-app-bar__section--align-start"


{-| TODO docs
-}
alignEnd : Html.Attribute msg
alignEnd =
    class "mdc-top-app-bar__section--align-end"


{-| TODO docs
-}
navigationIcon : Html.Attribute msg
navigationIcon =
    class "mdc-top-app-bar__navigation-icon"


{-| TODO docs
-}
title : Html.Attribute msg
title =
    class "mdc-top-app-bar__title"


{-| TODO docs
-}
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


{-| TODO docs
-}
fixedAdjust : Html.Attribute msg
fixedAdjust =
    class "mdc-top-app-bar--fixed-adjust"


{-| TODO docs
-}
denseFixedAdjust : Html.Attribute msg
denseFixedAdjust =
    class "mdc-top-app-bar--dense-fixed-adjust"


{-| TODO docs
-}
shortFixedAdjust : Html.Attribute msg
shortFixedAdjust =
    class "mdc-top-app-bar--short-fixed-adjust"


{-| TODO docs
-}
prominentFixedAdjust : Html.Attribute msg
prominentFixedAdjust =
    class "mdc-top-app-bar--prominent-fixed-adjust"


{-| TODO docs
-}
denseProminentFixedAdjust : Html.Attribute msg
denseProminentFixedAdjust =
    class "mdc-top-app-bar--dense-prominent-fixed-adjust"
