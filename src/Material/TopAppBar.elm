module Material.TopAppBar exposing
    ( topAppBar, topAppBarConfig, TopAppBarConfig
    , row, section, alignEnd, alignStart
    , navigationIcon, title
    , actionItem
    , fixedAdjust
    , denseFixedAdjust
    , denseProminentFixedAdjust
    , prominentFixedAdjust
    , shortFixedAdjust
    , shortTopAppBar
    , shortCollapsedTopAppBar
    , prominentTopAppBar
    )

{-| Top App Bar acts as a container for items such as application title,
navigation icon, and action items.


# Table of Contents

  - [Resources](#resources)
  - [Basic Usage](#basic-usage)
  - [Top App Bar](#top-app-bar)
      - [Top App Bar with Action Items](#top-app-bar-with-action-items)
  - [Fixed Variant](#fixed-variant)
  - [Short Variant](#short-variant)
      - [Short Always Closed Variant](#short-always-closed-variant)
  - [Prominent Variant](#prominent-variant)
  - [Dense Variant](#dense-variant)


# Resources

  - [Demo: Top App Bars](https://aforemny.github.io/material-components-web-elm/#top-app-bars)
  - [Material Design Guidelines: Top App Bar](https://material.io/go/design-app-bar-top)
  - [MDC Web: List](https://github.com/material-components/material-components-web/tree/master/packages/mdc-top-app-bar)
  - [Sass Mixins (MDC Web)](https://github.com/material-components/material-components-web/tree/master/packages/mdc-top-app-bar#sass-mixins)


# Basic Usage

    import Material.TopAppBar as TopAppBar
        exposing
            ( topAppBar
            , topAppBarConfig
            )

    main =
        topAppBar topAppBarConfig
            [ TopAppBar.row []
                [ TopAppBar.section [ TopAppBar.alignStart ]
                    [ iconButton
                        { iconButtonConfig
                            | additionalAttributes =
                                [ TopAppBar.navigationIcon ]
                        }
                        "menu"
                    , Html.span [ TopAppBar.title ]
                        [ text "Title" ]
                    ]
                ]
            ]


# Top App Bar

Usually a top app bar contains one row with at least one start-aligned section.
This is where you would normally place your navigation icon and title.

@docs topAppBar, topAppBarConfig, TopAppBarConfig
@docs row, section, alignEnd, alignStart
@docs navigationIcon, title


## Top App Bar with Action Items

A top app bar can contain action items that are placed on the opposite side of
the navigation icon. To do so, add another end-aligned section to the top app
bar's row. Do not forget to set the `actionItem` attribute on the icons.

    topAppBar topAppBarConfig
        [ TopAppBar.row []
            [ TopAppBar.section [ TopAppBar.alignStart ]
                [ iconButton
                    { iconButtonConfig
                        | additionalAttributes =
                            [ TopAppBar.navigationIcon ]
                    }
                    "menu"
                , Html.span [ TopAppBar.title ]
                    [ text "Title" ]
                ]
            , TopAppBar.section [ TopAppBar.alignEnd ]
                [ iconButton
                    { iconButtonConfig
                        | additionalAttributes =
                            [ TopAppBar.actionItem ]
                    }
                    "print"
                , iconButton
                    { iconButtonConfig
                        | additionalAttributes =
                            [ TopAppBar.actionItem ]
                    }
                    "bookmark"
                ]
            ]
        ]

@docs actionItem


# Fixed Variant

To make a top app bar fixed to the top, set its `fixed` configuration field to
`True`. Since a fixed top app bar would overlay the pages content, an
appropriate margin has to be applied to the page's content.

    topAppBar { topAppBarConfig | fixed = True } []

@docs fixedAdjust
@docs denseFixedAdjust
@docs denseProminentFixedAdjust
@docs prominentFixedAdjust
@docs shortFixedAdjust


# Short Variant

Short top app bars collapse to the navigation icon side when scrolled.

    shortTopAppBar topAppBarConfig []

@docs shortTopAppBar


## Short Always Closed Variant

A short top app bar can be configured to always appear closed.

    shortCollapsedtopAppBar topAppBarConfig []

@docs shortCollapsedTopAppBar


# Prominent Variant

To make a top app bar taller than the default, you may use a prominent top app bar.

    prominentTopAppBar topAppBarConfig []

@docs prominentTopAppBar


# Dense Variant

To make a top app bar shorter than the default, set its `dense` configuration
field to `True`.

    topAppBar { topAppBarConfig | dense = True }

-}

import Html exposing (Html, text)
import Html.Attributes exposing (class)


{-| Configuration of a top app bar
-}
type alias TopAppBarConfig msg =
    { dense : Bool
    , fixed : Bool
    , additionalAttributes : List (Html.Attribute msg)
    }


type Variant
    = Default
    | Short
    | ShortCollapsed
    | Prominent


{-| Default configuration of a top app bar
-}
topAppBarConfig : TopAppBarConfig msg
topAppBarConfig =
    { dense = False
    , fixed = False
    , additionalAttributes = []
    }


genericTopAppBar : Variant -> TopAppBarConfig msg -> List (Html msg) -> Html msg
genericTopAppBar variant config nodes =
    Html.node "mdc-top-app-bar"
        (List.filterMap identity
            [ rootCs
            , variantCs variant
            , denseCs config
            , fixedCs config
            ]
            ++ config.additionalAttributes
        )
        nodes


{-| Top app bar view function
-}
topAppBar : TopAppBarConfig msg -> List (Html msg) -> Html msg
topAppBar config nodes =
    genericTopAppBar Default config nodes


{-| Short top app bar view function
-}
shortTopAppBar : TopAppBarConfig msg -> List (Html msg) -> Html msg
shortTopAppBar config nodes =
    genericTopAppBar Short config nodes


{-| Short always closed top app bar view function
-}
shortCollapsedTopAppBar : TopAppBarConfig msg -> List (Html msg) -> Html msg
shortCollapsedTopAppBar config nodes =
    genericTopAppBar ShortCollapsed config nodes


{-| Prominent top app bar view function
-}
prominentTopAppBar : TopAppBarConfig msg -> List (Html msg) -> Html msg
prominentTopAppBar config nodes =
    genericTopAppBar Prominent config nodes


{-| A row is the first child of a top app bar. It contains the top app bar's
`section`s.
-}
row : List (Html.Attribute msg) -> List (Html msg) -> Html msg
row attributes nodes =
    Html.section ([ class "mdc-top-app-bar__row" ] ++ attributes) nodes


{-| Sections subdivide the top app bar's rows. A section may be start- or
end-aligned. Usually, the first section is start-aligned and contains the top
app bar's navigation icon and title.
-}
section : List (Html.Attribute msg) -> List (Html msg) -> Html msg
section attributes nodes =
    Html.section ([ class "mdc-top-app-bar__section" ] ++ attributes) nodes


{-| Start-align a top app bar's `section`
-}
alignStart : Html.Attribute msg
alignStart =
    class "mdc-top-app-bar__section--align-start"


{-| End-align a top app bar's `section`
-}
alignEnd : Html.Attribute msg
alignEnd =
    class "mdc-top-app-bar__section--align-end"


{-| Apply this attribute to an icon button to mark it as a top app bar's
navigation icon
-}
navigationIcon : Html.Attribute msg
navigationIcon =
    class "mdc-top-app-bar__navigation-icon"


{-| Apply this attribute to a element to mark it as the top app bar's title
-}
title : Html.Attribute msg
title =
    class "mdc-top-app-bar__title"


{-| Apply this attribute to a icon button to mark it as a top app bar's action
item
-}
actionItem : Html.Attribute msg
actionItem =
    class "mdc-top-app-bar__action-item"


rootCs : Maybe (Html.Attribute msg)
rootCs =
    Just (class "mdc-top-app-bar")


variantCs : Variant -> Maybe (Html.Attribute msg)
variantCs variant =
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


{-| Appropriate padding for a fixed top app bar.

Apply this to the page's content so that a fixed top app bar does not overlay
the content.

-}
fixedAdjust : Html.Attribute msg
fixedAdjust =
    class "mdc-top-app-bar--fixed-adjust"


{-| Appropriate padding for a dense fixed top app bar.

Apply this to the page's content so that a fixed top app bar does not overlay
the content.

-}
denseFixedAdjust : Html.Attribute msg
denseFixedAdjust =
    class "mdc-top-app-bar--dense-fixed-adjust"


{-| Appropriate padding for a short fixed top app bar.

Apply this to the page's content so that a fixed top app bar does not overlay
the content.

-}
shortFixedAdjust : Html.Attribute msg
shortFixedAdjust =
    class "mdc-top-app-bar--short-fixed-adjust"


{-| Appropriate padding for a prominent fixed top app bar.

Apply this to the page's content so that a fixed top app bar does not overlay
the content.

-}
prominentFixedAdjust : Html.Attribute msg
prominentFixedAdjust =
    class "mdc-top-app-bar--prominent-fixed-adjust"


{-| Appropriate padding for a dense prominent fixed top app bar.

Apply this to the page's content so that a fixed top app bar does not overlay
the content.

-}
denseProminentFixedAdjust : Html.Attribute msg
denseProminentFixedAdjust =
    class "mdc-top-app-bar--dense-prominent-fixed-adjust"
