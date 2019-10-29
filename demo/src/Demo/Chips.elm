module Demo.Chips exposing (Model, Msg(..), defaultModel, update, view)

import Demo.CatalogPage exposing (CatalogPage)
import Demo.Helper.ResourceLink as ResourceLink
import Html exposing (Html, text)
import Html.Attributes
import Material.Chips exposing (choiceChip, choiceChipConfig, choiceChipSet, filterChip, filterChipConfig, filterChipSet, inputChip, inputChipConfig, inputChipSet)
import Material.Typography as Typography
import Set exposing (Set)


type alias Model =
    { selectedChips : Set String
    , choiceChip : Maybe String
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
    }


type Msg
    = ChipClicked ChipType String


type ChipType
    = Choice
    | Filter
    | Action


update : Msg -> Model -> Model
update msg model =
    case msg of
        ChipClicked chipType index ->
            case chipType of
                Choice ->
                    { model
                        | choiceChip =
                            if model.choiceChip == Just index then
                                Nothing

                            else
                                Just index
                    }

                _ ->
                    { model
                        | selectedChips =
                            model.selectedChips
                                |> (if Set.member index model.selectedChips then
                                        Set.remove index

                                    else
                                        Set.insert index
                                   )
                    }


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
        ]
    }


heroChips : List (Html msg)
heroChips =
    [ choiceChipSet []
        [ choiceChip choiceChipConfig "Chip One"
        , choiceChip choiceChipConfig "Chip Two"
        , choiceChip choiceChipConfig "Chip Three"
        , choiceChip choiceChipConfig "Chip Four"
        ]
    ]


choiceChips : Model -> Html Msg
choiceChips model =
    let
        chip index label =
            choiceChip
                { choiceChipConfig
                    | selected = Just index == model.choiceChip
                    , onClick = Just (ChipClicked Choice index)
                }
                label
    in
    choiceChipSet []
        [ chip "chips-choice-extra-small" "Extra Small"
        , chip "chips-choice-small" "Small"
        , chip "chips-choice-medium" "Medium"
        , chip "chips-choice-large" "Large"
        , chip "chips-choice-extra-large" "Extra Large"
        ]


filterChips1 : Model -> Html Msg
filterChips1 model =
    let
        chip index label =
            filterChip
                { filterChipConfig
                    | selected = Set.member index model.selectedChips
                    , onClick = Just (ChipClicked Filter index)
                }
                label
    in
    filterChipSet []
        [ chip "chips-filter-chips-tops" "Tops"
        , chip "chips-filter-chips-bottoms" "Bottoms"
        , chip "chips-filter-chips-shoes" "Shoes"
        , chip "chips-filter-chips-accessories" "Accessories"
        ]


filterChips2 : Model -> Html Msg
filterChips2 model =
    let
        chip index label =
            filterChip
                { filterChipConfig
                    | selected = Set.member index model.selectedChips
                    , icon = Just "face"
                    , onClick = Just (ChipClicked Filter index)
                }
                label
    in
    filterChipSet []
        [ chip "chips-filter-chips-alice" "Alice"
        , chip "chips-filter-chips-bob" "Bob"
        , chip "chips-filter-chips-charlie" "Charlie"
        , chip "chips-filter-chips-danielle" "Danielle"
        ]


actionChips : Model -> Html Msg
actionChips model =
    let
        chip index ( icon, label ) =
            choiceChip { choiceChipConfig | icon = Just icon } label
    in
    choiceChipSet []
        [ chip "chips-action-chips-add-to-calendar" ( "event", "Add to calendar" )
        , chip "chips-action-chips-bookmark" ( "bookmark", "Bookmark" )
        , chip "chips-action-chips-set-alarm" ( "alarm", "Set alarm" )
        , chip "chips-action-chips-get-directions" ( "directions", "Get directions" )
        ]


shapedChips : Model -> Html msg
shapedChips model =
    let
        chip index label =
            choiceChip
                { choiceChipConfig
                    | additionalAttributes =
                        [ Html.Attributes.style "border-radius" "4px" ]
                }
                label
    in
    choiceChipSet []
        [ chip "chips-shaped-chips-bookcase" "Bookcase"
        , chip "chips-shaped-chips-tv-stand" "TV Stand"
        , chip "chips-shaped-chips-sofas" "Sofas"
        , chip "chips-shaped-chips-office-chairs" "Office chairs"
        ]
