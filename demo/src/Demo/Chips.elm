module Demo.Chips exposing (Model, Msg(..), defaultModel, update, view)

import Browser.Dom
import Demo.CatalogPage exposing (CatalogPage)
import Demo.ElmLogo exposing (elmLogo)
import Html exposing (Html, text)
import Html.Attributes exposing (class, style)
import Html.Events
import Json.Decode as Decode
import Material.Button as Button
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
import Svg.Attributes
import Task


type alias Model =
    { chip : Maybe String
    , size : Size
    , inputChips : List String
    , input : String
    , accessories : Set String
    , contacts : Set String
    , focus : String
    }


defaultModel : Model
defaultModel =
    { chip = Just "Chip One"
    , size = Small
    , inputChips = [ "Portland", "Biking" ]
    , input = ""
    , accessories = Set.singleton "Tops"
    , contacts = Set.singleton "Alice"
    , focus = "One"
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
    | FocusChanged String
    | Focus String
    | Focused (Result Browser.Dom.Error ())


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        ChipChanged chip ->
            ( { model | chip = Just chip }, Cmd.none )

        SizeChanged size ->
            ( { model | size = size }, Cmd.none )

        InputChanged newInput ->
            ( { model | input = newInput }, Cmd.none )

        AccessoriesChanged accessory ->
            ( { model
                | accessories =
                    (if Set.member accessory model.accessories then
                        Set.remove accessory

                     else
                        Set.insert accessory
                    )
                        model.accessories
              }
            , Cmd.none
            )

        ContactChanged contact ->
            ( { model
                | contacts =
                    (if Set.member contact model.contacts then
                        Set.remove contact

                     else
                        Set.insert contact
                    )
                        model.contacts
              }
            , Cmd.none
            )

        InputChipDeleted inputChip ->
            ( { model | inputChips = List.filter ((/=) inputChip) model.inputChips }
            , Cmd.none
            )

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
                ( { model
                    | input = ""
                    , inputChips =
                        if not (List.member trimmedInput model.inputChips) then
                            model.inputChips ++ [ trimmedInput ]

                        else
                            model.inputChips
                  }
                , Cmd.none
                )

            else if keyCode == backspace && String.isEmpty model.input then
                ( { model
                    | inputChips =
                        List.take (List.length model.inputChips - 1)
                            model.inputChips
                  }
                , Cmd.none
                )

            else
                ( model, Cmd.none )

        FocusChanged focus ->
            ( { model | focus = focus }, Cmd.none )

        Focus id ->
            ( model, Task.attempt Focused (Browser.Dom.focus id) )

        Focused _ ->
            ( model, Cmd.none )


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
        , Html.h2 [ Typography.subtitle1 ] [ text "Chips with Custom Icons" ]
        , actionChipsWithCustomIcons model
        , Html.h2 [ Typography.subtitle1 ] [ text "Focus Chips" ]
        , focusChips model
        ]
    }


heroChips : Model -> List (Html Msg)
heroChips model =
    [ ChoiceChipSet.chipSet
        (ChoiceChipSet.config { toLabel = identity }
            |> ChoiceChipSet.setSelected model.chip
            |> ChoiceChipSet.setOnChange ChipChanged
        )
        (ChoiceChip.chip ChoiceChip.config "Chip One")
        [ ChoiceChip.chip ChoiceChip.config "Chip Two"
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
        (ChoiceChip.chip ChoiceChip.config ExtraSmall)
        [ ChoiceChip.chip ChoiceChip.config Small
        , ChoiceChip.chip ChoiceChip.config Medium
        , ChoiceChip.chip ChoiceChip.config Large
        , ChoiceChip.chip ChoiceChip.config ExtraLarge
        ]


inputChips : Model -> Html Msg
inputChips model =
    let
        chip label =
            ( label
            , InputChip.chip
                (InputChip.config
                    |> InputChip.setOnDelete (InputChipDeleted label)
                )
                label
            )
    in
    Html.div
        [ style "position" "relative"
        , style "display" "flex"
        ]
        [ case model.inputChips of
            [] ->
                text ""

            firstInputChip :: otherInputChips ->
                InputChipSet.chipSet []
                    (chip firstInputChip)
                    (List.map chip otherInputChips)
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
        (chip "Tops")
        (List.map chip
            [ "Bottoms"
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
                    |> FilterChip.setIcon (Just (FilterChip.icon "face"))
                    |> FilterChip.setOnChange (ContactChanged label)
                )
                label
    in
    FilterChipSet.chipSet []
        (chip "Alice")
        (List.map chip
            [ "Bob"
            , "Charlie"
            , "Danielle"
            ]
        )


actionChips : Model -> Html Msg
actionChips model =
    let
        chip ( iconName, label ) =
            ActionChip.chip
                (ActionChip.config
                    |> ActionChip.setIcon (Just (ActionChip.icon iconName))
                )
                label
    in
    ActionChipSet.chipSet []
        (chip ( "event", "Add to calendar" ))
        (List.map chip
            [ ( "bookmark", "Bookmark" )
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
        (chip "Bookcase")
        (List.map chip
            [ "TV Stand"
            , "Sofas"
            , "Office chairs"
            ]
        )


actionChipsWithCustomIcons : Model -> Html Msg
actionChipsWithCustomIcons model =
    ActionChipSet.chipSet []
        (ActionChip.chip
            (ActionChip.config
                |> ActionChip.setIcon (Just (ActionChip.icon "favorite"))
            )
            "Material Icons"
        )
        [ ActionChip.chip
            (ActionChip.config
                |> ActionChip.setIcon
                    (Just
                        (ActionChip.customIcon Html.i [ class "fab fa-font-awesome" ] [])
                    )
            )
            "Font Awesome"
        , ActionChip.chip
            (ActionChip.config
                |> ActionChip.setIcon
                    (Just
                        (ActionChip.svgIcon [ Svg.Attributes.viewBox "0 0 100 100" ]
                            elmLogo
                        )
                    )
            )
            "Font Awesome"
        ]


focusChips : Model -> Html Msg
focusChips model =
    Html.div []
        [ ChoiceChipSet.chipSet
            (ChoiceChipSet.config { toLabel = identity }
                |> ChoiceChipSet.setSelected (Just model.focus)
                |> ChoiceChipSet.setOnChange FocusChanged
                |> ChoiceChipSet.setAttributes [ Html.Attributes.id "my-chips" ]
            )
            (ChoiceChip.chip ChoiceChip.config "One")
            [ ChoiceChip.chip ChoiceChip.config "Two" ]
        , text "\u{00A0}"
        , Button.raised
            (Button.config
                |> Button.setOnClick (Focus "my-chips")
            )
            "Focus"
        ]
