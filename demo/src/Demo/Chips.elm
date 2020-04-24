module Demo.Chips exposing (Model, Msg(..), defaultModel, update, view)

import Demo.CatalogPage exposing (CatalogPage)
import Demo.Helper.ResourceLink as ResourceLink
import Html exposing (Html, text)
import Html.Attributes exposing (style)
import Material.Chip.Choice as ChoiceChip
import Material.Chip.Filter as FilterChip
import Material.Chip.Input as InputChip
import Material.Typography as Typography
import Set exposing (Set)


type alias Model =
    { selectedChips : Set String
    , choiceChip : Maybe String
    , inputChips : Set String
    }


defaultModel : Model
defaultModel =
    { selectedChips =
        Set.fromList
            [ "chips-choice-medium"
            , "chips-filter-chips-tops"
            , "chips-filter-chips-bottoms"
            , "chips-filter-chips-alice"
            ]
    , choiceChip = Just "chips-choice-medium"
    , inputChips = Set.fromList [ "1", "2", "3" ]
    }


type Msg
    = ChoiceChipClicked String
    | FilterChipClicked String
    | InputChipClicked String


update : Msg -> Model -> Model
update msg model =
    case msg of
        ChoiceChipClicked index ->
            { model
                | choiceChip =
                    if model.choiceChip == Just index then
                        Nothing

                    else
                        Just index
            }

        FilterChipClicked index ->
            { model
                | selectedChips =
                    model.selectedChips
                        |> (if Set.member index model.selectedChips then
                                Set.remove index

                            else
                                Set.insert index
                           )
            }

        InputChipClicked index ->
            { model | inputChips = Set.remove index model.inputChips }


view : Model -> CatalogPage Msg
view model =
    { title = "Chips"
    , prelude = "Chips are compact elements that allow users to enter information, select a choice, filter content, or trigger an action."
    , resources =
        { materialDesignGuidelines = Just "https://material.io/go/design-chips"
        , documentation = Just "https://package.elm-lang.org/packages/aforemny/material-components-web-elm/latest/Material-Chips"
        , sourceCode = Just "https://github.com/material-components/material-components-web/tree/master/packages/mdc-chips"
        }
    , hero = heroChips
    , content =
        [ Html.h2 [ Typography.subtitle1 ] [ text "Choice Chips" ]
        , choiceChips model
        , Html.h2 [ Typography.subtitle1 ] [ text "Filter Chips" ]
        , Html.h3 [ Typography.body2 ] [ text "No leading icon" ]
        , filterChips1 model
        , Html.h3 [ Typography.body2 ] [ text "With leading icon" ]
        , filterChips2 model
        , Html.h2 [ Typography.subtitle1 ] [ text "Action Chips" ]
        , actionChips model
        , Html.h2 [ Typography.subtitle1 ] [ text "Shaped Chips" ]
        , shapedChips model

        -- , Html.h2 [ Typography.subtitle1 ] [ text "Input Chips" ]
        -- , inputChips model
        ]
    }


heroChips : List (Html msg)
heroChips =
    [ ChoiceChip.set []
        [ ChoiceChip.chip ChoiceChip.config "Chip One"
        , ChoiceChip.chip ChoiceChip.config "Chip Two"
        , ChoiceChip.chip ChoiceChip.config "Chip Three"
        , ChoiceChip.chip ChoiceChip.config "Chip Four"
        ]
    ]


choiceChips : Model -> Html Msg
choiceChips model =
    let
        chip label =
            ChoiceChip.chip
                (ChoiceChip.config
                    |> ChoiceChip.setSelected (Just label == model.choiceChip)
                    |> ChoiceChip.setOnClick (ChoiceChipClicked label)
                )
                label
    in
    ChoiceChip.set []
        (List.map chip
            [ "Extra Small"
            , "Small"
            , "Medium"
            , "Large"
            , "Extra Large"
            ]
        )


filterChips1 : Model -> Html Msg
filterChips1 model =
    let
        chip label =
            FilterChip.chip
                (FilterChip.config
                    |> FilterChip.setSelected (Set.member label model.selectedChips)
                    |> FilterChip.setOnClick (FilterChipClicked label)
                )
                label
    in
    FilterChip.set []
        (List.map chip
            [ "Tops"
            , "Bottoms"
            , "Shoes"
            , "Accessories"
            ]
        )


filterChips2 : Model -> Html Msg
filterChips2 model =
    let
        chip label =
            FilterChip.chip
                (FilterChip.config
                    |> FilterChip.setSelected (Set.member label model.selectedChips)
                    |> FilterChip.setIcon (Just "face")
                    |> FilterChip.setOnClick (FilterChipClicked label)
                )
                label
    in
    FilterChip.set []
        (List.map chip
            [ "Alice"
            , "Bob"
            , "Charlie"
            , "Danielle"
            ]
        )


actionChips : Model -> Html Msg
actionChips model =
    let
        chip ( icon, label ) =
            ChoiceChip.chip (ChoiceChip.config |> ChoiceChip.setIcon (Just icon)) label
    in
    ChoiceChip.set []
        (List.map chip
            [ ( "event", "Add to calendar" )
            , ( "bookmark", "Bookmark" )
            , ( "alarm", "Set alarm" )
            , ( "directions", "Get directions" )
            ]
        )


shapedChips : Model -> Html msg
shapedChips model =
    let
        chip label =
            ChoiceChip.chip
                (ChoiceChip.config
                    |> ChoiceChip.setAttributes [ style "border-radius" "4px" ]
                )
                label
    in
    ChoiceChip.set []
        (List.map chip
            [ "Bookcase"
            , "TV Stand"
            , "Sofas"
            , "Office chairs"
            ]
        )


inputChips : Model -> Html Msg
inputChips model =
    let
        chip index =
            InputChip.chip
                (InputChip.config
                    |> InputChip.setOnTrailingIconClick (InputChipClicked index)
                    |> InputChip.setAttributes [ style "border-radius" "4px" ]
                )
                index
    in
    InputChip.set [] (List.map chip (Set.toList model.inputChips))
