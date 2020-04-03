module Material.DataTable exposing
    ( dataTable, dataTableConfig
    , dataTableHeaderRow, DataTableHeaderRow
    , dataTableHeaderCell, DataTableHeaderCell, dataTableHeaderCellConfig, DataTableHeaderCellConfig
    , dataTableHeaderRowCheckbox
    , dataTableRow, DataTableRow, dataTableRowConfig, DataTableRowConfig
    , dataTableCell, DataTableCell, dataTableCellConfig, DataTableCellConfig
    , dataTableRowCheckbox
    )

{-| Data tables display information in a way that’s easy to scan, so that users
can look for patterns and insights.


# Table of Contents

  - [Resources](#resources)
  - [Basic Usage](#basic-usage)
  - [Data Table](#data-table)
  - [Header Row](#header-row)
  - [Header Cell](#header-cell)
      - [Numeric Header Cell](#numeric-header-cell)
      - [Checkbox Header Cell](#checkbox-header-cell)
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

    import Material.DataTable
        exposing
            ( dataTable
            , dataTableCell
            , dataTableCellConfig
            , dataTableConfig
            , dataTableHeaderCell
            , dataTableHeaderCellConfig
            , dataTableHeaderRow
            , dataTableRow
            , dataTableRowConfig
            )

    main =
        dataTable dataTableConfig
            { thead =
                [ dataTableHeaderRow []
                    [ dataTableHeaderCell
                        dataTableHeaderCellConfig
                        [ text "Desert" ]
                    ]
                ]
            , tbody =
                [ dataTableRow dataTableRowConfig
                    [ dataTableCell dataTableCellConfig
                        [ text "Frozen yogurt" ]
                    ]
                ]
            }


# Data Table

@docs dataTable, dataTableConfig


# Header Row

@docs dataTableHeaderRow, DataTableHeaderRow


# Header Cell

@docs dataTableHeaderCell, DataTableHeaderCell, dataTableHeaderCellConfig, DataTableHeaderCellConfig


## Numeric Header Cell

    dataTableHeaderCell
        { dataTableHeaderCellConfig | numeric = True }
        [ text "Number" ]


## Checkbox Header Cell

    import Material.Checkbox as Checkbox

    dataTableHeaderCell
        { dataTableHeaderCellConfig | checkbox = True }
        [ dataTableHeaderRowCheckbox Checkbox.config ]

@docs dataTableHeaderRowCheckbox


# Row

@docs dataTableRow, DataTableRow, dataTableRowConfig, DataTableRowConfig


## Selected Row

    dataTableRow { dataTableRowConfig | selected = True }
      [ … ]


# Cell

@docs dataTableCell, DataTableCell, dataTableCellConfig, DataTableCellConfig


## Numeric Cell

    dataTableCell { dataTableCellConfig | numeric = True }
        [ text "123" ]


## Checkbox Cell

    import Material.Checkbox as Checkbox

    dataTableCell { dataTableCellConfig | checkbox = True }
        [ dataTableRowCheckbox Checkbox.config ]

@docs dataTableRowCheckbox

-}

import Html exposing (Html, text)
import Html.Attributes exposing (class)
import Html.Events
import Json.Encode as Encode
import Material.Checkbox as Checkbox
import Material.Checkbox.Internal


{-| Configuration of a data table
-}
type alias DataTableConfig msg =
    { label : Maybe String
    , additionalAttributes : List (Html.Attribute msg)
    }


{-| Default configuration of a data table
-}
dataTableConfig : DataTableConfig msg
dataTableConfig =
    { label = Nothing
    , additionalAttributes = []
    }


{-| Data Table view function
-}
dataTable :
    DataTableConfig msg
    ->
        { thead : List (DataTableHeaderRow msg)
        , tbody : List (DataTableRow msg)
        }
    -> Html msg
dataTable config { thead, tbody } =
    Html.node "mdc-data-table"
        (dataTableCs :: config.additionalAttributes)
        [ Html.table
            (List.filterMap identity
                [ dataTableTableCs
                , ariaLabelAttr config
                ]
            )
            [ Html.thead [] (List.map (\(DataTableHeaderRow node) -> node) thead)
            , Html.tbody [ dataTableContentCs ]
                (List.map (\(DataTableRow node) -> node) tbody)
            ]
        ]


dataTableCs : Html.Attribute msg
dataTableCs =
    class "mdc-data-table"


dataTableTableCs : Maybe (Html.Attribute msg)
dataTableTableCs =
    Just (class "mdc-data-table__table")


ariaLabelAttr : DataTableConfig msg -> Maybe (Html.Attribute msg)
ariaLabelAttr { label } =
    Maybe.map (Html.Attributes.attribute "aria-label") label


{-| Header row type
-}
type DataTableHeaderRow msg
    = DataTableHeaderRow (Html msg)


{-| Header row view function
-}
dataTableHeaderRow : List (Html.Attribute msg) -> List (DataTableHeaderCell msg) -> DataTableHeaderRow msg
dataTableHeaderRow attributes nodes =
    DataTableHeaderRow <|
        Html.tr (class "mdc-data-table__header-row" :: attributes)
            (List.map (\(DataTableHeaderCell node) -> node) nodes)


dataTableContentCs : Html.Attribute msg
dataTableContentCs =
    class "mdc-data-table__content"


{-| Configuration of a header cell
-}
type alias DataTableHeaderCellConfig msg =
    { numeric : Bool
    , checkbox : Bool
    , additionalAttributes : List (Html.Attribute msg)
    }


{-| Default configuration of a header cell
-}
dataTableHeaderCellConfig : DataTableHeaderCellConfig msg
dataTableHeaderCellConfig =
    { numeric = False
    , checkbox = False
    , additionalAttributes = []
    }


{-| Header cell type
-}
type DataTableHeaderCell msg
    = DataTableHeaderCell (Html msg)


{-| Header cell view function
-}
dataTableHeaderCell : DataTableHeaderCellConfig msg -> List (Html msg) -> DataTableHeaderCell msg
dataTableHeaderCell config nodes =
    DataTableHeaderCell <|
        Html.th
            (List.filterMap identity
                [ dataTableHeaderCellCs
                , columnHeaderRoleAttr
                , colScopeAttr
                , dataTableHeaderCellNumericCs config
                , dataTableHeaderCellCheckboxCs config
                ]
                ++ config.additionalAttributes
            )
            nodes


dataTableHeaderCellCs : Maybe (Html.Attribute msg)
dataTableHeaderCellCs =
    Just (class "mdc-data-table__header-cell")


columnHeaderRoleAttr : Maybe (Html.Attribute msg)
columnHeaderRoleAttr =
    Just (Html.Attributes.attribute "role" "columnheader")


colScopeAttr : Maybe (Html.Attribute msg)
colScopeAttr =
    Just (Html.Attributes.attribute "scope" "col")


dataTableHeaderCellNumericCs : DataTableHeaderCellConfig msg -> Maybe (Html.Attribute msg)
dataTableHeaderCellNumericCs { numeric } =
    if numeric then
        Just (class "mdc-data-table__header-cell--numeric")

    else
        Nothing


dataTableHeaderCellCheckboxCs : DataTableHeaderCellConfig msg -> Maybe (Html.Attribute msg)
dataTableHeaderCellCheckboxCs { checkbox } =
    if checkbox then
        Just (class "mdc-data-table__header-cell--checkbox")

    else
        Nothing


{-| Configuartion of a row
-}
type alias DataTableRowConfig msg =
    { selected : Bool
    , additionalAttributes : List (Html.Attribute msg)
    }


{-| Default configuration of a row
-}
dataTableRowConfig : DataTableRowConfig msg
dataTableRowConfig =
    { selected = False
    , additionalAttributes = []
    }


{-| Row type
-}
type DataTableRow msg
    = DataTableRow (Html msg)


{-| Row view function
-}
dataTableRow : DataTableRowConfig msg -> List (DataTableCell msg) -> DataTableRow msg
dataTableRow config nodes =
    DataTableRow <|
        Html.tr
            (List.filterMap identity
                [ dataTableRowCs
                , dataTableRowSelectedCs config
                , ariaSelectedAttr config
                ]
                ++ config.additionalAttributes
            )
            (List.map (\(DataTableCell node) -> node) nodes)


dataTableRowCs : Maybe (Html.Attribute msg)
dataTableRowCs =
    Just (class "mdc-data-table__row")


dataTableRowSelectedCs : DataTableRowConfig msg -> Maybe (Html.Attribute msg)
dataTableRowSelectedCs { selected } =
    if selected then
        Just (class "mdc-data-table__row--selected")

    else
        Nothing


ariaSelectedAttr : DataTableRowConfig msg -> Maybe (Html.Attribute msg)
ariaSelectedAttr { selected } =
    Just
        (Html.Attributes.attribute "aria-selected"
            (if selected then
                "true"

             else
                "false"
            )
        )


{-| Configuration of a cell
-}
type alias DataTableCellConfig msg =
    { numeric : Bool
    , checkbox : Bool
    , additionalAttributes : List (Html.Attribute msg)
    }


{-| Default configuration of a cell
-}
dataTableCellConfig : DataTableCellConfig msg
dataTableCellConfig =
    { numeric = False
    , checkbox = False
    , additionalAttributes = []
    }


{-| Cell type
-}
type DataTableCell msg
    = DataTableCell (Html msg)


{-| Cell view function
-}
dataTableCell : DataTableCellConfig msg -> List (Html msg) -> DataTableCell msg
dataTableCell config nodes =
    DataTableCell <|
        Html.td
            (List.filterMap identity
                [ dataTableCellCs
                , dataTableCellNumericCs config
                , dataTableCellCheckboxCs config
                ]
                ++ config.additionalAttributes
            )
            nodes


dataTableCellCs : Maybe (Html.Attribute msg)
dataTableCellCs =
    Just (class "mdc-data-table__cell")


dataTableCellNumericCs : DataTableHeaderCellConfig msg -> Maybe (Html.Attribute msg)
dataTableCellNumericCs { numeric } =
    if numeric then
        Just (class "mdc-data-table__cell--numeric")

    else
        Nothing


dataTableCellCheckboxCs : DataTableHeaderCellConfig msg -> Maybe (Html.Attribute msg)
dataTableCellCheckboxCs { checkbox } =
    if checkbox then
        Just (class "mdc-data-table__cell--checkbox")

    else
        Nothing


{-| Checkbox view function (header row variant)
-}
dataTableHeaderRowCheckbox : Checkbox.Config msg -> Html msg
dataTableHeaderRowCheckbox (Material.Checkbox.Internal.Config checkboxConfig) =
    Checkbox.checkbox
        (Material.Checkbox.Internal.Config
            { checkboxConfig
                | additionalAttributes =
                    class "mdc-data-table__header-row-checkbox"
                        :: checkboxConfig.additionalAttributes
            }
        )


{-| Checkbox view function (row variant)
-}
dataTableRowCheckbox : Checkbox.Config msg -> Html msg
dataTableRowCheckbox (Material.Checkbox.Internal.Config checkboxConfig) =
    Checkbox.checkbox
        (Material.Checkbox.Internal.Config
            { checkboxConfig
                | additionalAttributes =
                    class "mdc-data-table__row-checkbox"
                        :: checkboxConfig.additionalAttributes
            }
        )
