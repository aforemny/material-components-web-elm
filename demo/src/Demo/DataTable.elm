module Demo.DataTable exposing (Model, Msg, defaultModel, update, view)

import Demo.CatalogPage exposing (CatalogPage)
import Demo.Helper.ResourceLink as ResourceLink
import Html exposing (Html, text)
import Html.Attributes
import Material.Button exposing (ButtonConfig, buttonConfig, outlinedButton, raisedButton, textButton, unelevatedButton)
import Material.Checkbox as Checkbox exposing (checkboxConfig)
import Material.DataTable exposing (dataTable, dataTableCell, dataTableCellConfig, dataTableConfig, dataTableHeaderCell, dataTableHeaderCellConfig, dataTableHeaderRow, dataTableHeaderRowCheckbox, dataTableRow, dataTableRowCheckbox, dataTableRowConfig)
import Material.Typography as Typography
import Set exposing (Set)


type alias Model =
    { selected : Set String }


defaultModel : Model
defaultModel =
    { selected = Set.empty }


type Msg
    = NoOp
    | ItemSelected String
    | AllSelected
    | AllUnselected


update : Msg -> Model -> Model
update msg model =
    case msg of
        NoOp ->
            model

        ItemSelected key ->
            { model
                | selected =
                    if Set.member key model.selected then
                        Set.remove key model.selected

                    else
                        Set.insert key model.selected
            }

        AllSelected ->
            { model
                | selected =
                    Set.fromList
                        [ "Frozen yogurt", "Ice cream sandwich", "Eclair" ]
            }

        AllUnselected ->
            { model | selected = Set.empty }


view : Model -> CatalogPage Msg
view model =
    { title = "Data Table"
    , prelude = "Data tables display information in a way that’s easy to scan, so that users can look for patterns and insights."
    , resources =
        { materialDesignGuidelines = Just "https://material.io/go/design-data-tables"
        , documentation = Just "https://material.io/components/web/catalog/data-tables/"
        , sourceCode = Just "https://github.com/material-components/material-components-web/tree/master/packages/mdc-data-table"
        }
    , hero = heroDataTable
    , content =
        [ Html.h3 [ Typography.subtitle1 ] [ text "Data Table Standard" ]
        , standardDataTable
        , Html.h3 [ Typography.subtitle1 ] [ text "Data Table with Row Selection" ]
        , dataTableWithRowSelection model
        ]
    }


heroDataTable : List (Html msg)
heroDataTable =
    [ standardDataTable ]


standardDataTable : Html msg
standardDataTable =
    dataTable dataTableConfig
        { thead =
            [ dataTableHeaderRow []
                [ dataTableHeaderCell dataTableHeaderCellConfig
                    [ text "Desert" ]
                , dataTableHeaderCell { dataTableHeaderCellConfig | numeric = True }
                    [ text "Carbs (g)" ]
                , dataTableHeaderCell { dataTableHeaderCellConfig | numeric = True }
                    [ text "Protein (g)" ]
                , dataTableHeaderCell dataTableHeaderCellConfig
                    [ text "Comments" ]
                ]
            ]
        , tbody =
            [ dataTableRow dataTableRowConfig
                [ dataTableCell dataTableCellConfig [ text "Frozen yogurt" ]
                , dataTableCell { dataTableCellConfig | numeric = True } [ text "24" ]
                , dataTableCell { dataTableCellConfig | numeric = True } [ text "4.0" ]
                , dataTableCell dataTableCellConfig [ text "Super tasty" ]
                ]
            , dataTableRow dataTableRowConfig
                [ dataTableCell dataTableCellConfig [ text "Ice cream sandwich" ]
                , dataTableCell { dataTableCellConfig | numeric = True }
                    [ text "37" ]
                , dataTableCell { dataTableCellConfig | numeric = True }
                    [ text "4.33333333333" ]
                , dataTableCell dataTableCellConfig [ text "I like ice cream more" ]
                ]
            , dataTableRow dataTableRowConfig
                [ dataTableCell dataTableCellConfig [ text "Eclair" ]
                , dataTableCell { dataTableCellConfig | numeric = True } [ text "24" ]
                , dataTableCell { dataTableCellConfig | numeric = True } [ text "6.0" ]
                , dataTableCell dataTableCellConfig [ text "New filing flavor" ]
                ]
            ]
        }


dataTableWithRowSelection : Model -> Html Msg
dataTableWithRowSelection model =
    let
        allSelected =
            Set.size model.selected == 3

        allUnselected =
            Set.size model.selected == 0
    in
    dataTable dataTableConfig
        { thead =
            [ dataTableHeaderRow []
                [ dataTableHeaderCell { dataTableHeaderCellConfig | checkbox = True }
                    [ dataTableHeaderRowCheckbox
                        { checkboxConfig
                            | state =
                                if allSelected then
                                    Checkbox.Checked

                                else if allUnselected then
                                    Checkbox.Unchecked

                                else
                                    Checkbox.Indeterminate
                            , onChange =
                                Just
                                    (if allSelected then
                                        AllUnselected

                                     else
                                        AllSelected
                                    )
                        }
                    ]
                , dataTableHeaderCell dataTableHeaderCellConfig
                    [ text "Desert" ]
                , dataTableHeaderCell { dataTableHeaderCellConfig | numeric = True }
                    [ text "Carbs (g)" ]
                , dataTableHeaderCell { dataTableHeaderCellConfig | numeric = True }
                    [ text "Protein (g)" ]
                , dataTableHeaderCell dataTableHeaderCellConfig
                    [ text "Comments" ]
                ]
            ]
        , tbody =
            [ let
                label =
                    "Frozen yogurt"

                selected =
                    Set.member label model.selected
              in
              dataTableRow { dataTableRowConfig | selected = selected }
                [ dataTableCell { dataTableCellConfig | checkbox = True }
                    [ dataTableRowCheckbox
                        { checkboxConfig
                            | state =
                                if selected then
                                    Checkbox.Checked

                                else
                                    Checkbox.Unchecked
                            , onChange = Just (ItemSelected label)
                        }
                    ]
                , dataTableCell dataTableCellConfig [ text label ]
                , dataTableCell { dataTableCellConfig | numeric = True } [ text "24" ]
                , dataTableCell { dataTableCellConfig | numeric = True } [ text "4.0" ]
                , dataTableCell dataTableCellConfig [ text "Super tasty" ]
                ]
            , let
                label =
                    "Ice cream sandwich"

                selected =
                    Set.member label model.selected
              in
              dataTableRow { dataTableRowConfig | selected = selected }
                [ dataTableCell { dataTableCellConfig | checkbox = True }
                    [ dataTableRowCheckbox
                        { checkboxConfig
                            | state =
                                if selected then
                                    Checkbox.Checked

                                else
                                    Checkbox.Unchecked
                            , onChange = Just (ItemSelected label)
                        }
                    ]
                , dataTableCell dataTableCellConfig [ text label ]
                , dataTableCell { dataTableCellConfig | numeric = True }
                    [ text "37" ]
                , dataTableCell { dataTableCellConfig | numeric = True }
                    [ text "4.33333333333" ]
                , dataTableCell dataTableCellConfig [ text "I like ice cream more" ]
                ]
            , let
                label =
                    "Eclair"

                selected =
                    Set.member label model.selected
              in
              dataTableRow { dataTableRowConfig | selected = selected }
                [ dataTableCell { dataTableCellConfig | checkbox = True }
                    [ dataTableRowCheckbox
                        { checkboxConfig
                            | state =
                                if selected then
                                    Checkbox.Checked

                                else
                                    Checkbox.Unchecked
                            , onChange = Just (ItemSelected label)
                        }
                    ]
                , dataTableCell dataTableCellConfig [ text label ]
                , dataTableCell { dataTableCellConfig | numeric = True } [ text "24" ]
                , dataTableCell { dataTableCellConfig | numeric = True } [ text "6.0" ]
                , dataTableCell dataTableCellConfig [ text "New filing flavor" ]
                ]
            ]
        }
