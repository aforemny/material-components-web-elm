module Material.LayoutGrid exposing
    ( layoutGrid, layoutGridCell, layoutGridInner
    , span1, span2, span3, span4, span5, span6, span7, span8, span9, span10, span11, span12
    , alignTop, alignMiddle, alignBottom
    , alignLeft, alignRight
    , span1Desktop, span2Desktop, span3Desktop, span4Desktop, span5Desktop, span6Desktop, span7Desktop, span8Desktop, span9Desktop, span10Desktop, span11Desktop, span12Desktop
    , span1Tablet, span2Tablet, span3Tablet, span4Tablet, span5Tablet, span6Tablet, span7Tablet, span8Tablet
    , span1Phone, span2Phone, span3Phone, span4Phone
    )

{-| Material design’s responsive UI is based on a column-variate grid layout.
It has 12 columns on desktop, 8 columns on tablet and 4 columns on phone.


# Table of Contents

  - [Resources](#resources)
  - [Basic Usage](#basic-usage)
  - [Layout Grid](#layout-grid)
  - [Cell Spans](#cell-spans)
  - [Cell Alignment](#cell-alignment)
  - [Grid Alignment](#grid-alignment)
  - [Nested Grid](#nested-grid)
  - [Device-Specific Cell Spans](#device-specific-cell-spans)
      - [Desktop Cell Spans](#desktop-cell-spans)
      - [Tablet Cell Spans](#tablet-cell-spans)
      - [Phone Cell Spans](#phone-cell-spans)


# Resources

  - [Demo: Layout Grids](https://aforemny.github.io/material-components-web-elm/#layout-grids)
  - [Material Design Guidelines: Layout Grid](https://material.io/guidelines/layout/responsive-ui.html#responsive-ui-grid)
  - [MDC Web: Layout Grid](https://github.com/material-components/material-components-web/tree/master/packages/mdc-layout-grid)
  - [Sass Mixins (MDC Web)](https://github.com/material-components/material-components-web/tree/master/packages/mdc-layout-grid#sass-mixins)


# Basic Usage

    import Material.LayoutGrid as LayoutGrid
        exposing
            ( layoutGrid
            , layoutGridCell
            , layoutGridInner
            )

    main =
        layoutGrid []
            [ layoutGridInner []
                [ layoutGridCell [] []
                , layoutGridCell [] []
                , layoutGridCell [] []
                ]
            ]


# Layout Grid

@docs layoutGrid, layoutGridCell, layoutGridInner


# Cell Spans

Cells span by default four columns within the grid. Use one of the following
functions to change this behavior.

@docs span1, span2, span3, span4, span5, span6, span7, span8, span9, span10, span11, span12


# Cell Alignment

Cells are by default stretched. You can add attributes `alignTop`,
`alignMiddle` or `alignBottom` to a cell to change this behavior.

@docs alignTop, alignMiddle, alignBottom


# Grid Alignment

The layout grid is by default center aligned. You can add attributes
`alignLeft` or `alignRight` to the `layoutGrid` to change this behavior.

Note that effects will only be visible if the layout grid does not span the
entire available width.

@docs alignLeft, alignRight


# Nested Grid

When your contents need extra structure that cannot be supported by a single
layout grid, you can nest layout grids within each other. To nest layout grid,
add a new `layoutGridInner` around nested `layoutGridCell`s within an existing
`layoutGridCell`.

The nested layout grid behaves exactly like when they are not nested, e.g, they
have 12 columns on desktop, 8 columns on tablet and 4 columns on phone. They
also use the same gutter size as their parents, but margins are not
re-introduced since they are living within another cell.

However, the Material Design guidelines do not recommend having a deeply nested
grid as it might mean an over complicated UX.

    layoutGrid []
        [ layoutGridInner []
            [ layoutGridCell []
                [ layoutGridInner []
                    [ layoutGridCell [] []
                    , layoutGridCell [] []
                    ]
                ]
            , layoutGridCell [] []
            ]
        ]


# Device-Specific Cell Spans


## Desktop Cell Spans

@docs span1Desktop, span2Desktop, span3Desktop, span4Desktop, span5Desktop, span6Desktop, span7Desktop, span8Desktop, span9Desktop, span10Desktop, span11Desktop, span12Desktop


## Tablet Cell Spans

@docs span1Tablet, span2Tablet, span3Tablet, span4Tablet, span5Tablet, span6Tablet, span7Tablet, span8Tablet


## Phone Cell Spans

@docs span1Phone, span2Phone, span3Phone, span4Phone

-}

import Html exposing (Html, text)
import Html.Attributes exposing (class, style)


type Device
    = Desktop
    | Tablet
    | Phone


{-| Grid view function
-}
layoutGrid : List (Html.Attribute msg) -> List (Html msg) -> Html msg
layoutGrid attributes nodes =
    Html.node "mdc-layout-grid"
        (class "mdc-layout-grid" :: style "display" "block" :: attributes)
        nodes


{-| Cell view function
-}
layoutGridCell : List (Html.Attribute msg) -> List (Html msg) -> Html msg
layoutGridCell attributes nodes =
    Html.div (class "mdc-layout-grid__cell" :: attributes) nodes


{-| Mandatory wrapper around `layoutGridCell`
-}
layoutGridInner : List (Html.Attribute msg) -> List (Html msg) -> Html msg
layoutGridInner attributes nodes =
    Html.div (class "mdc-layout-grid__inner" :: attributes) nodes


{-| Aligns a cell to the bottom
-}
alignBottom : Html.Attribute msg
alignBottom =
    class "mdc-layout-grid__cell--align-bottom"


{-| Aligns the layout grid to the left
-}
alignLeft : Html.Attribute msg
alignLeft =
    class "mdc-layout-grid--align-left"


{-| Aligns the layout grid to the right
-}
alignRight : Html.Attribute msg
alignRight =
    class "mdc-layout-grid--align-right"


{-| Aligns a cell to the middle
-}
alignMiddle : Html.Attribute msg
alignMiddle =
    class "mdc-layout-grid__cell--align-middle"


{-| Aligns a cell to the top
-}
alignTop : Html.Attribute msg
alignTop =
    class "mdc-layout-grid__cell--align-top"


span : Int -> Html.Attribute msg
span n =
    class ("mdc-layout-grid__cell--span-" ++ String.fromInt n)


spanDesktop : Int -> Html.Attribute msg
spanDesktop n =
    class ("mdc-layout-grid__cell--span-" ++ String.fromInt n ++ "-desktop")


spanTablet : Int -> Html.Attribute msg
spanTablet n =
    class ("mdc-layout-grid__cell--span-" ++ String.fromInt n ++ "-tablet")


spanPhone : Int -> Html.Attribute msg
spanPhone n =
    class ("mdc-layout-grid__cell--span-" ++ String.fromInt n ++ "-phone")


{-| Change a cell to span one column
-}
span1 : Html.Attribute msg
span1 =
    span 1


{-| Change a cell to span two columns
-}
span2 : Html.Attribute msg
span2 =
    span 2


{-| Change a cell to span three columns
-}
span3 : Html.Attribute msg
span3 =
    span 3


{-| Change a cell to span four columns
-}
span4 : Html.Attribute msg
span4 =
    span 4


{-| Change a cell to span five columns
-}
span5 : Html.Attribute msg
span5 =
    span 5


{-| Change a cell to span six columns
-}
span6 : Html.Attribute msg
span6 =
    span 6


{-| Change a cell to span seven columns
-}
span7 : Html.Attribute msg
span7 =
    span 7


{-| Change a cell to span eight columns
-}
span8 : Html.Attribute msg
span8 =
    span 8


{-| Change a cell to span nine columns
-}
span9 : Html.Attribute msg
span9 =
    span 9


{-| Change a cell to span ten columns
-}
span10 : Html.Attribute msg
span10 =
    span 10


{-| Change a cell to span eleven columns
-}
span11 : Html.Attribute msg
span11 =
    span 11


{-| Change a cell to span twelve columns
-}
span12 : Html.Attribute msg
span12 =
    span 12


{-| Change a cell to span one column (desktop only)
-}
span1Desktop : Html.Attribute msg
span1Desktop =
    spanDesktop 1


{-| Change a cell to span two columns (desktop only)
-}
span2Desktop : Html.Attribute msg
span2Desktop =
    spanDesktop 2


{-| Change a cell to span three columns (desktop only)
-}
span3Desktop : Html.Attribute msg
span3Desktop =
    spanDesktop 3


{-| Change a cell to span four columns (desktop only)
-}
span4Desktop : Html.Attribute msg
span4Desktop =
    spanDesktop 4


{-| Change a cell to span five columns (desktop only)
-}
span5Desktop : Html.Attribute msg
span5Desktop =
    spanDesktop 5


{-| Change a cell to span six columns (desktop only)
-}
span6Desktop : Html.Attribute msg
span6Desktop =
    spanDesktop 6


{-| Change a cell to span seven columns (desktop only)
-}
span7Desktop : Html.Attribute msg
span7Desktop =
    spanDesktop 7


{-| Change a cell to span eight columns (desktop only)
-}
span8Desktop : Html.Attribute msg
span8Desktop =
    spanDesktop 8


{-| Change a cell to span nine columns (desktop only)
-}
span9Desktop : Html.Attribute msg
span9Desktop =
    spanDesktop 9


{-| Change a cell to span ten columns (desktop only)
-}
span10Desktop : Html.Attribute msg
span10Desktop =
    spanDesktop 10


{-| Change a cell to span eleven columns (desktop only)
-}
span11Desktop : Html.Attribute msg
span11Desktop =
    spanDesktop 11


{-| Change a cell to span twelve columns (desktop only)
-}
span12Desktop : Html.Attribute msg
span12Desktop =
    spanDesktop 12


{-| Change a cell to span one column (tablet only)
-}
span1Tablet : Html.Attribute msg
span1Tablet =
    spanTablet 1


{-| Change a cell to span two columns (tablet only)
-}
span2Tablet : Html.Attribute msg
span2Tablet =
    spanTablet 2


{-| Change a cell to span three columns (tablet only)
-}
span3Tablet : Html.Attribute msg
span3Tablet =
    spanTablet 3


{-| Change a cell to span four columns (tablet only)
-}
span4Tablet : Html.Attribute msg
span4Tablet =
    spanTablet 4


{-| Change a cell to span five columns (tablet only)
-}
span5Tablet : Html.Attribute msg
span5Tablet =
    spanTablet 5


{-| Change a cell to span six columns (tablet only)
-}
span6Tablet : Html.Attribute msg
span6Tablet =
    spanTablet 6


{-| Change a cell to span seven columns (tablet only)
-}
span7Tablet : Html.Attribute msg
span7Tablet =
    spanTablet 7


{-| Change a cell to span eight columns (tablet only)
-}
span8Tablet : Html.Attribute msg
span8Tablet =
    spanTablet 8


{-| Change a cell to span one column (phone only)
-}
span1Phone : Html.Attribute msg
span1Phone =
    spanPhone 1


{-| Change a cell to span two columns (phone only)
-}
span2Phone : Html.Attribute msg
span2Phone =
    spanPhone 2


{-| Change a cell to span three columns (phone only)
-}
span3Phone : Html.Attribute msg
span3Phone =
    spanPhone 3


{-| Change a cell to span four columns (phone only)
-}
span4Phone : Html.Attribute msg
span4Phone =
    spanPhone 4
