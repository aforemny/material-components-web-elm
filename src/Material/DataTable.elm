module Material.DataTable exposing
    ( Config, config
    , setLabel
    , setAttributes
    , dataTable
    , Row, row
    , selected
    , Cell, cell
    , numericCell
    , checkboxCell
    )

{-| Data tables display information in a way that’s easy to scan, so that users
can look for patterns and insights.


# Table of Contents

  - [Resources](#resources)
  - [Configution](#configuration)
      - [Configuration Options](#configuration-options)
  - [Basic Usage](#basic-usage)
  - [Data Table](#data-table)
  - [Row](#row)
      - [Selected Row](#selected-row)
  - [Cell](#cell)
      - [Numeric Cell](#numeric-cell)
      - [Checkbox Cell](#checkbox-cell)


# Resources

  - [Demo: Data Table](https://aforemny.github.io/material-components-web-elm/#data-table)
  - [Material Design Guidelines: Data tables](https://material.io/go/design-data-tables)
  - [MDC Web: Data Table](https://github.com/material-components/material-components-web/tree/master/packages/mdc-data-table)
  - [Sass Mixins (MDC Web)](https://github.com/material-components/material-components-web/tree/master/packages/mdc-data-table#sass-mixins)


# Basic Usage

    import Material.DataTable as DataTable

    main =
        DataTable.dataTable DataTable.config
            { thead =
                [ DataTable.row []
                    [ DataTable.cell [] [ text "Desert" ] ]
                ]
            , tbody =
                [ DataTable.row []
                    [ DataTable.cell [] [ text "Frozen yogurt" ]
                    ]
                ]
            }


# Configuration

@docs Config, config


## Configuration Options

@docs setLabel
@docs setAttributes


# Data Table

@docs dataTable


# Row

@docs Row, row


## Selected Row

    DataTable.row DataTable.selected []

@docs selected


# Cell

@docs Cell, cell


## Numeric Cell

    DataTable.numericCell [] [ text "9.000,00" ]

@docs numericCell


## Checkbox Cell

    import Material.Checkbox as Checkbox

    DataTable.checkboxCell [] Checkbox.config

@docs checkboxCell

-}

import Html exposing (Html)
import Html.Attributes exposing (class)
import Material.Checkbox as Checkbox
import Material.Checkbox.Internal


{-| Configuration of a data table
-}
type Config msg
    = Config
        { label : Maybe String
        , additionalAttributes : List (Html.Attribute msg)
        }


{-| Default configuration of a data table
-}
config : Config msg
config =
    Config
        { label = Nothing
        , additionalAttributes = []
        }


{-| Specify the data table's HTML5 aria-label attribute
-}
setLabel : Maybe String -> Config msg -> Config msg
setLabel label (Config config_) =
    Config { config_ | label = label }


{-| Specify additional attributes
-}
setAttributes : List (Html.Attribute msg) -> Config msg -> Config msg
setAttributes additionalAttributes (Config config_) =
    Config { config_ | additionalAttributes = additionalAttributes }


{-| Data table view function
-}
dataTable :
    Config msg
    ->
        { thead : List (Row msg)
        , tbody : List (Row msg)
        }
    -> Html msg
dataTable ((Config { additionalAttributes }) as config_) { thead, tbody } =
    Html.node "mdc-data-table"
        (dataTableCs :: additionalAttributes)
        [ Html.table
            (List.filterMap identity
                [ dataTableTableCs
                , ariaLabelAttr config_
                ]
            )
            [ Html.thead [] (List.map headerRow thead)
            , Html.tbody [ dataTableContentCs ] (List.map bodyRow tbody)
            ]
        ]


dataTableCs : Html.Attribute msg
dataTableCs =
    class "mdc-data-table"


dataTableTableCs : Maybe (Html.Attribute msg)
dataTableTableCs =
    Just (class "mdc-data-table__table")


dataTableContentCs : Html.Attribute msg
dataTableContentCs =
    class "mdc-data-table__content"


ariaLabelAttr : Config msg -> Maybe (Html.Attribute msg)
ariaLabelAttr (Config { label }) =
    Maybe.map (Html.Attributes.attribute "aria-label") label


{-| Row type
-}
type Row msg
    = Row { attributes : List (Html.Attribute msg), nodes : List (Cell msg) }


{-| Row view function
-}
row : List (Html.Attribute msg) -> List (Cell msg) -> Row msg
row attributes nodes =
    Row { attributes = attributes, nodes = nodes }


{-| Attribute to mark a row as selected

This has no effect on a header row.

Note that this is a list of attributes because it actually sets two HTML
attributes at once.

-}
selected : List (Html.Attribute msg)
selected =
    [ dataTableRowSelectedCs
    , Html.Attributes.attribute "aria-selected" "true"
    ]


dataTableRowSelectedCs : Html.Attribute msg
dataTableRowSelectedCs =
    class "mdc-data-table__row--selected"


headerRow : Row msg -> Html msg
headerRow (Row { attributes, nodes }) =
    Html.tr (dataTableHeaderRowCs :: attributes) (List.map headerCell nodes)


dataTableHeaderRowCs : Html.Attribute msg
dataTableHeaderRowCs =
    class "mdc-data-table__header-row"


bodyRow : Row msg -> Html msg
bodyRow (Row { attributes, nodes }) =
    Html.tr (dataTableRowCs :: attributes) (List.map bodyCell nodes)


dataTableRowCs : Html.Attribute msg
dataTableRowCs =
    class "mdc-data-table__row"


headerCell : Cell msg -> Html msg
headerCell cell_ =
    case cell_ of
        Cell { numeric, attributes, nodes } ->
            Html.th
                (List.filterMap identity
                    [ dataTableHeaderCellCs
                    , columnHeaderRoleAttr
                    , colScopeAttr
                    , dataTableHeaderCellNumericCs numeric
                    ]
                    ++ attributes
                )
                nodes

        CheckboxCell { attributes, config_ } ->
            Html.th
                (List.filterMap identity
                    [ dataTableHeaderCellCs
                    , columnHeaderRoleAttr
                    , colScopeAttr
                    , dataTableHeaderCellCheckboxCs
                    ]
                    ++ attributes
                )
                [ Checkbox.checkbox
                    (case config_ of
                        Material.Checkbox.Internal.Config config__ ->
                            Material.Checkbox.Internal.Config
                                { config__
                                    | additionalAttributes =
                                        class "mdc-data-table__row-checkbox"
                                            :: config__.additionalAttributes
                                }
                    )
                ]


dataTableHeaderCellCs : Maybe (Html.Attribute msg)
dataTableHeaderCellCs =
    Just (class "mdc-data-table__header-cell")


columnHeaderRoleAttr : Maybe (Html.Attribute msg)
columnHeaderRoleAttr =
    Just (Html.Attributes.attribute "role" "columnheader")


colScopeAttr : Maybe (Html.Attribute msg)
colScopeAttr =
    Just (Html.Attributes.attribute "scope" "col")


dataTableHeaderCellNumericCs : Bool -> Maybe (Html.Attribute msg)
dataTableHeaderCellNumericCs numeric =
    if numeric then
        Just (class "mdc-data-table__header-cell--numeric")

    else
        Nothing


dataTableHeaderCellCheckboxCs : Maybe (Html.Attribute msg)
dataTableHeaderCellCheckboxCs =
    Just (class "mdc-data-table__header-cell--checkbox")


bodyCell : Cell msg -> Html msg
bodyCell cell_ =
    case cell_ of
        Cell { numeric, attributes, nodes } ->
            Html.td
                (List.filterMap identity
                    [ dataTableCellCs
                    , dataTableCellNumericCs numeric
                    ]
                    ++ attributes
                )
                nodes

        CheckboxCell { attributes, config_ } ->
            Html.td
                (List.filterMap identity
                    [ dataTableCellCs
                    , dataTableCellCheckboxCs
                    ]
                    ++ attributes
                )
                [ Checkbox.checkbox
                    (case config_ of
                        Material.Checkbox.Internal.Config config__ ->
                            Material.Checkbox.Internal.Config
                                { config__
                                    | additionalAttributes =
                                        class "mdc-data-table__row-checkbox"
                                            :: config__.additionalAttributes
                                }
                    )
                ]


{-| Cell type
-}
type Cell msg
    = Cell
        { numeric : Bool
        , attributes : List (Html.Attribute msg)
        , nodes : List (Html msg)
        }
    | CheckboxCell
        { config_ : Checkbox.Config msg
        , attributes : List (Html.Attribute msg)
        }


{-| Data table cell
-}
cell : List (Html.Attribute msg) -> List (Html msg) -> Cell msg
cell attributes nodes =
    Cell { numeric = False, attributes = attributes, nodes = nodes }


{-| Numeric data table cell (right-aligned contents)
-}
numericCell : List (Html.Attribute msg) -> List (Html msg) -> Cell msg
numericCell attributes nodes =
    Cell { numeric = True, attributes = attributes, nodes = nodes }


{-| Data table cell that contians a checkbox
-}
checkboxCell : List (Html.Attribute msg) -> Checkbox.Config msg -> Cell msg
checkboxCell attributes config_ =
    CheckboxCell { attributes = attributes, config_ = config_ }


dataTableCellCs : Maybe (Html.Attribute msg)
dataTableCellCs =
    Just (class "mdc-data-table__cell")


dataTableCellNumericCs : Bool -> Maybe (Html.Attribute msg)
dataTableCellNumericCs numeric =
    if numeric then
        Just (class "mdc-data-table__cell--numeric")

    else
        Nothing


dataTableCellCheckboxCs : Maybe (Html.Attribute msg)
dataTableCellCheckboxCs =
    Just (class "mdc-data-table__cell--checkbox")
