module Demo.Chips exposing (Model, Msg(..), defaultModel, update, view)

import Demo.Helper.Hero as Hero
import Demo.Helper.ResourceLink as ResourceLink
import Demo.Page as Page exposing (Page)
import Html exposing (Html, text)
import Html.Attributes
import Material.Chip.Choice as ChoiceChip exposing (choiceChip, choiceChipConfig)
import Material.Chip.Filter as FilterChip exposing (filterChip, filterChipConfig)
import Material.Chip.Input as InputChip exposing (inputChip, inputChipConfig)
import Material.ChipSet as ChipSet exposing (chipSet, chipSetConfig)
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
    = ToggleChip ChipType String


type ChipType
    = Choice
    | Filter
    | Action


update : (Msg -> m) -> Msg -> Model -> ( Model, Cmd m )
update lift msg model =
    case msg of
        ToggleChip chipType index ->
            case chipType of
                Choice ->
                    ( { model
                        | choiceChip =
                            if model.choiceChip == Just index then
                                Nothing

                            else
                                Just index
                      }
                    , Cmd.none
                    )

                _ ->
                    let
                        selectedChips =
                            model.selectedChips
                                |> (if Set.member index model.selectedChips then
                                        Set.remove index

                                    else
                                        Set.insert index
                                   )
                    in
                    ( { model | selectedChips = selectedChips }, Cmd.none )


view : (Msg -> m) -> Page m -> Model -> Html m
view lift page model =
    page.body "Chips"
        "Chips are compact elements that allow users to enter information, select a choice, filter content, or trigger an action."
        [ Hero.view []
            [ heroChips lift model
            ]
        , Html.h2
            [ Typography.headline6
            , Html.Attributes.style "border-bottom" "1px solid rgba(0,0,0,.87)"
            ]
            [ text "Resources"
            ]
        , ResourceLink.view
            { link = "https://material.io/go/design-chips"
            , title = "Material Design Guidelines"
            , icon = "images/material.svg"
            , altText = "Material Design Guidelines icon"
            }
        , ResourceLink.view
            { link = "https://material.io/components/web/catalog/chips/"
            , title = "Documentation"
            , icon = "images/ic_drive_document_24px.svg"
            , altText = "Documentation icon"
            }
        , ResourceLink.view
            { link = "https://github.com/material-components/material-components-web/tree/master/packages/mdc-chips"
            , title = "Source Code (Material Components Web)"
            , icon = "images/ic_code_24px.svg"
            , altText = "Source Code"
            }
        , Page.demos
            (List.concat
                [ choiceChips lift model
                , filterChips lift model
                , actionChips lift model
                , shapedChips lift model
                ]
            )
        ]


heroChips : (Msg -> m) -> Model -> Html m
heroChips lift model =
    chipSet chipSetConfig
        [ choiceChip choiceChipConfig "Chip One"
        , choiceChip choiceChipConfig "Chip Two"
        , choiceChip choiceChipConfig "Chip Three"
        , choiceChip choiceChipConfig "Chip Four"
        ]


choiceChips : (Msg -> m) -> Model -> List (Html m)
choiceChips lift model =
    let
        chip index label =
            choiceChip
                { choiceChipConfig
                    | selected = Just index == model.choiceChip
                    , onClick = Just (lift (ToggleChip Choice index))
                }
                label
    in
    [ Html.h2
        [ Typography.subtitle1
        ]
        [ text "Choice Chips"
        ]
    , chipSet { chipSetConfig | variant = ChipSet.Choice }
        [ chip "chips-choice-extra-small" "Extra Small"
        , chip "chips-choice-small" "Small"
        , chip "chips-choice-medium" "Medium"
        , chip "chips-choice-large" "Large"
        , chip "chips-choice-extra-large" "Extra Large"
        ]
    ]


filterChips : (Msg -> m) -> Model -> List (Html m)
filterChips lift model =
    [ Html.h2
        [ Typography.subtitle1
        ]
        [ text "Filter Chips"
        ]
    , Html.h3
        [ Typography.body2 ]
        [ text "No leading icon" ]
    , let
        chip index label =
            filterChip
                { filterChipConfig
                    | selected = Set.member index model.selectedChips
                    , onClick = Just (lift (ToggleChip Filter index))
                }
                label
      in
      chipSet { chipSetConfig | variant = ChipSet.Filter }
        [ chip "chips-filter-chips-tops" "Tops"
        , chip "chips-filter-chips-bottoms" "Bottoms"
        , chip "chips-filter-chips-shoes" "Shoes"
        , chip "chips-filter-chips-accessories" "Accessories"
        ]
    , Html.h3
        [ Typography.body2 ]
        [ text "With leading icon" ]
    , let
        chip index label =
            filterChip
                { filterChipConfig
                    | selected = Set.member index model.selectedChips
                    , icon = Just "face"
                    , onClick = Just (lift (ToggleChip Filter index))
                }
                label
      in
      chipSet { chipSetConfig | variant = ChipSet.Filter }
        [ chip "chips-filter-chips-alice" "Alice"
        , chip "chips-filter-chips-bob" "Bob"
        , chip "chips-filter-chips-charlie" "Charlie"
        , chip "chips-filter-chips-danielle" "Danielle"
        ]
    ]


actionChips : (Msg -> m) -> Model -> List (Html m)
actionChips lift model =
    let
        chip index ( icon, label ) =
            filterChip
                { filterChipConfig
                    | icon = Just icon
                    , onClick = Just (lift (ToggleChip Action index))
                }
                label
    in
    [ Html.h2
        [ Typography.subtitle1
        ]
        [ text "Action Chips"
        ]
    , chipSet chipSetConfig
        [ chip "chips-action-chips-add-to-calendar" ( "event", "Add to calendar" )
        , chip "chips-action-chips-bookmark" ( "bookmark", "Bookmark" )
        , chip "chips-action-chips-set-alarm" ( "alarm", "Set alarm" )
        , chip "chips-action-chips-get-directions" ( "directions", "Get directions" )
        ]
    ]


shapedChips : (Msg -> m) -> Model -> List (Html m)
shapedChips lift model =
    let
        chip index label =
            choiceChip
                { choiceChipConfig
                    | additionalAttributes =
                        [ Html.Attributes.style "border-radius" "4px" ]
                }
                label
    in
    [ Html.h2
        [ Typography.subtitle1
        ]
        [ text "Shaped Chips"
        ]
    , chipSet chipSetConfig
        [ chip "chips-shaped-chips-bookcase" "Bookcase"
        , chip "chips-shaped-chips-tv-stand" "TV Stand"
        , chip "chips-shaped-chips-sofas" "Sofas"
        , chip "chips-shaped-chips-office-chairs" "Office chairs"
        ]
    ]
