module Demo.Selects exposing (Model, Msg(..), defaultModel, update, view)

import Browser.Dom
import Demo.CatalogPage exposing (CatalogPage)
import Html exposing (Html, text)
import Html.Attributes exposing (style)
import Material.Button as Button
import Material.Select as Select
import Material.Select.Item as SelectItem exposing (SelectItem)
import Material.Typography as Typography
import Task


type alias Model =
    { hero : Maybe Fruit
    , filled : Maybe Fruit
    , outlined : Maybe Fruit
    , filledWithIcon : Maybe Fruit
    , outlinedWithIcon : Maybe Fruit
    , focused : Maybe Fruit
    }


defaultModel : Model
defaultModel =
    { hero = Nothing
    , filled = Nothing
    , outlined = Nothing
    , filledWithIcon = Nothing
    , outlinedWithIcon = Nothing
    , focused = Nothing
    }


type Fruit
    = Apple
    | Orange
    | Banana


type Msg
    = HeroChanged (Maybe Fruit)
    | FilledChanged (Maybe Fruit)
    | OutlinedChanged (Maybe Fruit)
    | FilledWithIconChanged (Maybe Fruit)
    | OutlinedWithIconChanged (Maybe Fruit)
    | FocusedChanged (Maybe Fruit)
    | Focus String
    | Focused (Result Browser.Dom.Error ())


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        HeroChanged hero ->
            ( { model | hero = hero }, Cmd.none )

        FilledChanged filled ->
            ( { model | filled = filled }, Cmd.none )

        OutlinedChanged outlined ->
            ( { model | outlined = outlined }, Cmd.none )

        FilledWithIconChanged filledWithIcon ->
            ( { model | filledWithIcon = filledWithIcon }, Cmd.none )

        OutlinedWithIconChanged outlinedWithIcon ->
            ( { model | outlinedWithIcon = outlinedWithIcon }, Cmd.none )

        FocusedChanged focused ->
            ( { model | focused = focused }, Cmd.none )

        Focus id ->
            ( model, Task.attempt Focused (Browser.Dom.focus id) )

        Focused _ ->
            ( model, Cmd.none )


view : Model -> CatalogPage Msg
view model =
    { title = "Select"
    , prelude = "Selects allow users to select from a single-option menu."
    , resources =
        { materialDesignGuidelines = Just "https://material.io/go/design-text-fields"
        , documentation = Just "https://package.elm-lang.org/packages/aforemny/material-components-web-elm/latest/Material-Select"
        , sourceCode = Just "https://github.com/material-components/material-components-web/tree/master/packages/mdc-select"
        }
    , hero = [ heroSelect model ]
    , content =
        [ Html.h3 [ Typography.subtitle1 ] [ text "Filled" ]
        , filledSelect model
        , Html.h3 [ Typography.subtitle1 ] [ text "Outlined" ]
        , outlinedSelect model
        , Html.h3 [ Typography.subtitle1 ] [ text "Filled with Icon" ]
        , filledWithIconSelect model
        , Html.h3 [ Typography.subtitle1 ] [ text "Outlined with Icon" ]
        , outlinedWithIconSelect model
        , Html.h3 [ Typography.subtitle1 ] [ text "Focus Select" ]
        , focusSelect model
        ]
    }


heroSelect : Model -> Html Msg
heroSelect model =
    Select.filled
        (Select.config
            |> Select.setLabel (Just "Fruit")
            |> Select.setSelected (Just model.hero)
            |> Select.setOnChange HeroChanged
        )
        firstItem
        remainingItems


firstItem : SelectItem (Maybe a) msg
firstItem =
    SelectItem.selectItem
        (SelectItem.config { value = Nothing })
        [ text "" ]


remainingItems : List (SelectItem (Maybe Fruit) msg)
remainingItems =
    [ SelectItem.selectItem
        (SelectItem.config { value = Just Apple })
        [ text "Apple" ]
    , SelectItem.selectItem
        (SelectItem.config { value = Just Orange })
        [ text "Orange" ]
    , SelectItem.selectItem
        (SelectItem.config { value = Just Banana })
        [ text "Banana" ]
    ]


filledSelect : Model -> Html Msg
filledSelect model =
    Select.filled
        (Select.config
            |> Select.setLabel (Just "Fruit")
            |> Select.setSelected (Just model.filled)
            |> Select.setOnChange FilledChanged
        )
        firstItem
        remainingItems


outlinedSelect : Model -> Html Msg
outlinedSelect model =
    Select.outlined
        (Select.config
            |> Select.setLabel (Just "Fruit")
            |> Select.setSelected (Just model.outlined)
            |> Select.setOnChange OutlinedChanged
        )
        firstItem
        remainingItems


filledWithIconSelect : Model -> Html Msg
filledWithIconSelect model =
    Select.filled
        (Select.config
            |> Select.setLabel (Just "Fruit")
            |> Select.setSelected (Just model.filledWithIcon)
            |> Select.setLeadingIcon (Just (Select.icon [] "favorite"))
            |> Select.setOnChange FilledWithIconChanged
        )
        firstItem
        remainingItems


outlinedWithIconSelect : Model -> Html Msg
outlinedWithIconSelect model =
    Select.outlined
        (Select.config
            |> Select.setLabel (Just "Fruit")
            |> Select.setSelected (Just model.outlinedWithIcon)
            |> Select.setLeadingIcon (Just (Select.icon [] "favorite"))
            |> Select.setOnChange OutlinedWithIconChanged
        )
        firstItem
        remainingItems


focusSelect : Model -> Html Msg
focusSelect model =
    Html.div
        [ style "display" "flex"
        , style "align-items" "center"
        ]
        [ Select.filled
            (Select.config
                |> Select.setSelected (Just model.focused)
                |> Select.setOnChange FocusedChanged
                |> Select.setAttributes [ Html.Attributes.id "my-select" ]
            )
            firstItem
            remainingItems
        , text "\u{00A0}"
        , Button.raised
            (Button.config |> Button.setOnClick (Focus "my-select"))
            "Focus"
        ]
