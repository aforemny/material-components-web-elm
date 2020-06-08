module Demo.Chips exposing (Model, Msg(..), defaultModel, update, view)

import Demo.CatalogPage exposing (CatalogPage)
import Html exposing (Html, text)
import Html.Attributes exposing (style)
import Html.Events
import Json.Decode as Decode
import Material.Chip.Action as ActionChip
import Material.Chip.Choice as ChoiceChip
import Material.Chip.Filter as FilterChip
import Material.Chip.Input as InputChip
import Material.ChipSet.Action as ActionChipSet
import Material.ChipSet.Choice as ChoiceChipSet
import Material.ChipSet.Filter as FilterChipSet
import Material.ChipSet.Input as InputChipSet
import Material.Typography as Typography
import Set exposing (Set)


type alias Model =
    { chip : Maybe String
    , size : Size
    , inputChips : List String
    , input : String
    , accessories : Set String
    , contacts : Set String
    }


defaultModel : Model
defaultModel =
    { chip = Just "Chip One"
    , size = Small
    , inputChips = [ "Portland", "Biking" ]
    , input = ""
    , accessories = Set.singleton "Tops"
    , contacts = Set.singleton "Alice"
    }


type Size
    = ExtraSmall
    | Small
    | Medium
    | Large
    | ExtraLarge


type Msg
    = ChipChanged String
    | SizeChanged Size
    | AccessoriesChanged String
    | ContactChanged String
    | InputChanged String
    | InputChipDeleted String
    | KeyPressed Int


update : Msg -> Model -> Model
update msg model =
    case msg of
        ChipChanged chip ->
            { model | chip = Just chip }

        SizeChanged size ->
            { model | size = size }

        InputChanged newInput ->
            { model | input = newInput }

        AccessoriesChanged accessory ->
            { model
                | accessories =
                    (if Set.member accessory model.accessories then
                        Set.remove accessory

                     else
                        Set.insert accessory
                    )
                        model.accessories
            }

        ContactChanged contact ->
            { model
                | contacts =
                    (if Set.member contact model.contacts then
                        Set.remove contact

                     else
                        Set.insert contact
                    )
                        model.contacts
            }

        InputChipDeleted inputChip ->
            { model | inputChips = List.filter ((/=) inputChip) model.inputChips }

        KeyPressed keyCode ->
            let
                backspace =
                    8

                enter =
                    13

                trimmedInput =
                    String.trim model.input
            in
            if keyCode == enter && not (String.isEmpty trimmedInput) then
                { model
                    | input = ""
                    , inputChips =
                        if not (List.member trimmedInput model.inputChips) then
                            model.inputChips ++ [ trimmedInput ]

                        else
                            model.inputChips
                }

            else if keyCode == backspace && String.isEmpty model.input then
                { model
                    | inputChips =
                        List.take (List.length model.inputChips - 1)
                            model.inputChips
                }

            else
                model


view : Model -> CatalogPage Msg
view model =
    { title = "Chips"
    , prelude = "Chips are compact elements that allow users to enter information, select a choice, filter content, or trigger an action."
    , resources =
        { materialDesignGuidelines = Just "https://material.io/go/design-chips"
        , documentation = Just "https://package.elm-lang.org/packages/aforemny/material-components-web-elm/latest/Material-Chips"
        , sourceCode = Just "https://github.com/material-components/material-components-web/tree/master/packages/mdc-chips"
        }
    , hero = heroChips model
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
        , Html.h2 [ Typography.subtitle1 ] [ text "Input Chips" ]
        , inputChips model
        ]
    }


heroChips : Model -> List (Html Msg)
heroChips model =
    [ ChoiceChipSet.chipSet
        (ChoiceChipSet.config { toLabel = identity }
            |> ChoiceChipSet.setSelected model.chip
            |> ChoiceChipSet.setOnChange ChipChanged
        )
        [ ChoiceChip.chip ChoiceChip.config "Chip One"
        , ChoiceChip.chip ChoiceChip.config "Chip Two"
        , ChoiceChip.chip ChoiceChip.config "Chip Three"
        , ChoiceChip.chip ChoiceChip.config "Chip Four"
        ]
    ]


choiceChips : Model -> Html Msg
choiceChips model =
    let
        toLabel size =
            case size of
                ExtraSmall ->
                    "Extra Small"

                Small ->
                    "Small"

                Medium ->
                    "Medium"

                Large ->
                    "Large"

                ExtraLarge ->
                    "Extra Large"
    in
    ChoiceChipSet.chipSet
        (ChoiceChipSet.config { toLabel = toLabel }
            |> ChoiceChipSet.setSelected (Just model.size)
            |> ChoiceChipSet.setOnChange SizeChanged
        )
        [ ChoiceChip.chip ChoiceChip.config ExtraSmall
        , ChoiceChip.chip ChoiceChip.config Small
        , ChoiceChip.chip ChoiceChip.config Medium
        , ChoiceChip.chip ChoiceChip.config Large
        , ChoiceChip.chip ChoiceChip.config ExtraLarge
        ]


inputChips : Model -> Html Msg
inputChips model =
    Html.div
        [ style "position" "relative"
        , style "display" "flex"
        ]
        [ InputChipSet.chipSet []
            (List.map
                (\label ->
                    ( label
                    , InputChip.chip
                        (InputChip.config
                            |> InputChip.setOnDelete (InputChipDeleted label)
                        )
                        label
                    )
                )
                model.inputChips
            )
        , Html.input
            [ Html.Attributes.value model.input
            , Html.Events.onInput InputChanged
            , Html.Events.on "keydown" (Decode.map KeyPressed Html.Events.keyCode)
            ]
            []
        ]


filterChips1 : Model -> Html Msg
filterChips1 model =
    let
        chip accessory =
            FilterChip.chip
                (FilterChip.config
                    |> FilterChip.setSelected (Set.member accessory model.accessories)
                    |> FilterChip.setOnChange (AccessoriesChanged accessory)
                )
                accessory
    in
    FilterChipSet.chipSet []
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
                    |> FilterChip.setSelected (Set.member label model.contacts)
                    |> FilterChip.setIcon (Just "face")
                    |> FilterChip.setOnChange (ContactChanged label)
                )
                label
    in
    FilterChipSet.chipSet []
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
            ActionChip.chip
                (ActionChip.config
                    |> ActionChip.setIcon (Just icon)
                )
                label
    in
    ActionChipSet.chipSet []
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
            ActionChip.chip
                (ActionChip.config
                    |> ActionChip.setAttributes [ style "border-radius" "4px" ]
                )
                label
    in
    ActionChipSet.chipSet []
        (List.map chip
            [ "Bookcase"
            , "TV Stand"
            , "Sofas"
            , "Office chairs"
            ]
        )
