module Material.LayoutGrid exposing
    ( layoutGrid, layoutGridInner, layoutGridCell
    , span1, span2, span3, span4, span5, span6, span7, span8, span9, span10, span11, span12
    , alignTop, alignMiddle, alignBottom
    , alignLeft, alignRight
    )

{-| Material design’s responsive UI is based on a column-variate grid layout.
It has 12 columns on desktop, 8 columns on tablet and 4 columns on phone.

  - [Demo: Layout Grids](https://aforemny.github.io/material-components-elm/#layout-grids)
  - [Material Design Guidelines: Layout Grid](https://material.io/guidelines/layout/responsive-ui.html#responsive-ui-grid)
  - [MDC Web: Layout Grid](https://github.com/material-components/material-components-web/tree/master/packages/mdc-layout-grid)
  - [Sass Mixins (MDC Web)](https://github.com/material-components/material-components-web/tree/master/packages/mdc-layout-grid#sass-mixins)


# Example

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


# Configuration

@docs layoutGrid, layoutGridInner, layoutGridCell


# Cell spans

Cells span by default four columns within the grid. Use one of the following
functions to change this behavior.

@docs span1, span2, span3, span4, span5, span6, span7, span8, span9, span10, span11, span12


# Cell alignment

Cells are by default stretched. You can add attributes `alignTop`,
`alignMiddle` or `alignBottom` to a cell to change this behavior.

@docs alignTop, alignMiddle, alignBottom


# Layout grid alignment

The layout grid is by default center aligned. You can add attributes
`alignLeft` or `alignRight` to the `layoutGrid` to change this behavior.

Note that effects will only be visible if the layout grid does not span the
entire available width.

@docs alignLeft, alignRight


# Nested grids

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

-}

import Html exposing (Html, text)
import Html.Attributes exposing (class, style)


type Device
    = Desktop
    | Tablet
    | Phone


{-| Layout grid
-}
layoutGrid : List (Html.Attribute msg) -> List (Html msg) -> Html msg
layoutGrid attributes nodes =
    Html.node "mdc-layout-grid"
        (class "mdc-layout-grid" :: style "display" "block" :: attributes)
        nodes


{-| Mandatory wrapper around `layoutGridCell`
-}
layoutGridInner : List (Html.Attribute msg) -> List (Html msg) -> Html msg
layoutGridInner attributes nodes =
    Html.div (class "mdc-layout-grid__inner" :: attributes) nodes


{-| Layout grid cell
-}
layoutGridCell : List (Html.Attribute msg) -> List (Html msg) -> Html msg
layoutGridCell attributes nodes =
    Html.div (class "mdc-layout-grid__cell" :: attributes) nodes


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
