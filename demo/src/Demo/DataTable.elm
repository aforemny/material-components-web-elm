module Demo.DataTable exposing (Model, Msg, defaultModel, update, view)

import Demo.CatalogPage exposing (CatalogPage)
import Html exposing (Html, text)
import Material.Checkbox as Checkbox
import Material.DataTable as DataTable
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


label : { desert : String, carbs : String, protein : String, comments : String }
label =
    { desert = "Desert"
    , carbs = "Carbs (g)"
    , protein = "Protein (g)"
    , comments = "Comments"
    }


data : List { desert : String, carbs : String, protein : String, comments : String }
data =
    [ { desert = "Frozen yogurt"
      , carbs = "24"
      , protein = "4.0"
      , comments = "Super tasty"
      }
    , { desert = "Ice cream sandwich"
      , carbs = "37"
      , protein = "4.33333333333"
      , comments = "I like ice cream more"
      }
    , { desert = "Eclair"
      , carbs = "24"
      , protein = "6.0"
      , comments = "New filing flavor"
      }
    ]


standardDataTable : Html msg
standardDataTable =
    let
        row { desert, carbs, protein, comments } =
            DataTable.row []
                [ DataTable.cell [] [ text desert ]
                , DataTable.numericCell [] [ text carbs ]
                , DataTable.numericCell [] [ text protein ]
                , DataTable.cell [] [ text comments ]
                ]
    in
    DataTable.dataTable DataTable.config
        { thead = [ row label ]
        , tbody = List.map row data
        }


dataTableWithRowSelection : Model -> Html Msg
dataTableWithRowSelection model =
    let
        allSelected =
            Set.size model.selected == 3

        allUnselected =
            Set.size model.selected == 0

        headerRow { onChange, state } { desert, carbs, protein, comments } =
            [ DataTable.row []
                [ DataTable.checkboxCell []
                    (Checkbox.config
                        |> Checkbox.setState (Just state)
                        |> Checkbox.setOnChange onChange
                    )
                , DataTable.cell [] [ text desert ]
                , DataTable.numericCell [] [ text carbs ]
                , DataTable.numericCell [] [ text protein ]
                , DataTable.cell [] [ text comments ]
                ]
            ]

        row { onChange, selected } { desert, carbs, protein, comments } =
            DataTable.row
                (if selected then
                    DataTable.selected

                 else
                    []
                )
                [ DataTable.checkboxCell []
                    (Checkbox.config
                        |> Checkbox.setState
                            (Just
                                (if selected then
                                    Checkbox.checked

                                 else
                                    Checkbox.unchecked
                                )
                            )
                        |> Checkbox.setOnChange onChange
                    )
                , DataTable.cell [] [ text desert ]
                , DataTable.numericCell [] [ text carbs ]
                , DataTable.numericCell [] [ text protein ]
                , DataTable.cell [] [ text comments ]
                ]
    in
    DataTable.dataTable DataTable.config
        { thead =
            headerRow
                { onChange =
                    if allSelected then
                        AllUnselected

                    else
                        AllSelected
                , state =
                    if allSelected then
                        Checkbox.checked

                    else if allUnselected then
                        Checkbox.unchecked

                    else
                        Checkbox.indeterminate
                }
                label
        , tbody =
            List.map
                (\({ desert } as data_) ->
                    row
                        { onChange = ItemSelected desert
                        , selected = Set.member desert model.selected
                        }
                        data_
                )
                data
        }
