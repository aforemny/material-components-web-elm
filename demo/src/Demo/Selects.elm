module Demo.Selects exposing (Model, Msg(..), defaultModel, update, view)

import Browser.Dom
import Demo.CatalogPage exposing (CatalogPage)
import Demo.ElmLogo exposing (elmLogo)
import Html exposing (Html, text)
import Html.Attributes exposing (class, style)
import Material.Button as Button
import Material.Select as Select
import Material.Select.Icon as SelectIcon
import Material.Select.Item as SelectItem exposing (SelectItem)
import Material.Typography as Typography
import Svg.Attributes
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
    | Interacted


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

        Interacted ->
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
        , Html.h3 [ Typography.subtitle1 ] [ text "Select with Custom Icon" ]
        , filledWithCustomIcon model
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
    SelectItem.selectItem (SelectItem.config { value = Nothing }) ""


remainingItems : List (SelectItem (Maybe Fruit) msg)
remainingItems =
    [ SelectItem.selectItem (SelectItem.config { value = Just Apple }) "Apple"
    , SelectItem.selectItem (SelectItem.config { value = Just Orange }) "Orange"
    , SelectItem.selectItem (SelectItem.config { value = Just Banana }) "Banana"
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
            |> Select.setLeadingIcon (Just (SelectIcon.icon "favorite"))
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
            |> Select.setLeadingIcon (Just (SelectIcon.icon "favorite"))
            |> Select.setOnChange OutlinedWithIconChanged
        )
        firstItem
        remainingItems


filledWithCustomIcon : Model -> Html Msg
filledWithCustomIcon model =
    Html.div []
        [ Select.filled
            (Select.config
                |> Select.setLabel (Just "Material Icons")
                |> Select.setLeadingIcon
                    (Just
                        (SelectIcon.icon "favorite"
                            |> SelectIcon.setOnInteraction Interacted
                        )
                    )
                |> Select.setAttributes [ style "margin-right" "24px" ]
            )
            firstItem
            remainingItems
        , Select.filled
            (Select.config
                |> Select.setLabel (Just "Font Awesome")
                |> Select.setLeadingIcon
                    (Just
                        (SelectIcon.customIcon Html.i
                            [ class "fab fa-font-awesome"
                            , style "font-size" "24px"
                            ]
                            []
                        )
                    )
                |> Select.setAttributes [ style "margin-right" "24px" ]
            )
            firstItem
            remainingItems
        , Select.filled
            (Select.config
                |> Select.setLabel (Just "Font Awesome")
                |> Select.setLeadingIcon
                    (Just
                        (SelectIcon.svgIcon
                            [ Svg.Attributes.viewBox "0 0 100 100" ]
                            elmLogo
                        )
                    )
            )
            firstItem
            remainingItems
        ]


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
