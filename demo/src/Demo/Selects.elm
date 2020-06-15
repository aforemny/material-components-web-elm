module Demo.Selects exposing (Model, Msg(..), defaultModel, update, view)

import Browser.Dom
import Demo.CatalogPage exposing (CatalogPage)
import Html exposing (Html, text)
import Html.Attributes exposing (style)
import Material.Button as Button
import Material.List as List
import Material.Select as Select
import Material.Select.Option as SelectOption exposing (SelectOption)
import Material.Typography as Typography
import Task


type alias Model =
    { value : String }


defaultModel : Model
defaultModel =
    { value = "" }


type Msg
    = SetValue String
    | Focus String
    | Focused (Result Browser.Dom.Error ())


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        SetValue value ->
            ( { model | value = value }, Cmd.none )

        Focus id ->
            ( model, Task.attempt Focused (Browser.Dom.focus id) )

        Focused _ ->
            ( model, Cmd.none )


view : Model -> CatalogPage Msg
view model =
    { title = "Select"
    , prelude = "Selects allow users to select from a single-option menu. It functions as a wrapper around the browser's native <select> element."
    , resources =
        { materialDesignGuidelines = Just "https://material.io/go/design-text-fields"
        , documentation = Just "https://package.elm-lang.org/packages/aforemny/material-components-web-elm/latest/Material-Select"
        , sourceCode = Just "https://github.com/material-components/material-components-web/tree/master/packages/mdc-select"
        }
    , hero = [ heroSelects model ]
    , content =
        [ Html.div selectRow [ filledSelects model ]
        , Html.h3 [ Typography.subtitle1 ] [ text "Outlined" ]
        , Html.div selectRow [ outlinedSelects model ]
        , Html.h3 [ Typography.subtitle1 ] [ text "Shaped Filled" ]
        , Html.div selectRow [ shapedFilledSelects model ]
        , Html.h3 [ Typography.subtitle1 ] [ text "Shaped Outlined (TODO)" ]
        , Html.div selectRow [ shapedOutlinedSelects model ]
        , Html.h3 [ Typography.subtitle1 ] [ text "Focus Select" ]
        , focusSelect
        ]
    }


heroSelects : Model -> Html Msg
heroSelects model =
    Select.filled
        (Select.config
            |> Select.setLabel (Just "Fruit")
            |> Select.setValue (Just model.value)
            |> Select.setOnChange SetValue
        )
        items


filledSelects : Model -> Html msg
filledSelects model =
    Html.div []
        [ Html.h3 [ Typography.subtitle1 ] [ text "Filled" ]
        , Select.filled
            (Select.config
                |> Select.setLabel (Just "Fruit")
                |> Select.setAttributes marginRight
            )
            items
        ]


outlinedSelects : Model -> Html msg
outlinedSelects model =
    Select.outlined
        (Select.config
            |> Select.setLabel (Just "Fruit")
            |> Select.setAttributes marginRight
        )
        items


shapedFilledSelects : Model -> Html msg
shapedFilledSelects model =
    Select.filled
        (Select.config
            |> Select.setLabel (Just "Fruit")
            |> Select.setAttributes
                (style "border-radius" "17.92px 17.92px 0 0"
                    :: marginRight
                )
        )
        items


shapedOutlinedSelects : Model -> Html msg
shapedOutlinedSelects model =
    Select.outlined
        (Select.config
            |> Select.setLabel (Just "Fruit")
            |> Select.setAttributes
                -- TODO:
                -- [ style "border-radius" "28px"
                -- , style "padding-left" "32px"
                -- , style "padding-right" "52px"
                -- ]
                marginRight
        )
        items


focusSelect : Html Msg
focusSelect =
    Html.div []
        [ Select.filled
            (Select.config
                |> Select.setAttributes [ Html.Attributes.id "my-select" ]
            )
            items
        , text "\u{00A0}"
        , Button.raised
            (Button.config |> Button.setOnClick (Focus "my-select"))
            "Focus"
        ]


items : List (SelectOption msg)
items =
    List.map
        (\value ->
            SelectOption.selectOption
                (SelectOption.config |> SelectOption.setValue (Just value))
                [ text value ]
        )
        [ ""
        , "Apple"
        , "Orange"
        , "Banana"
        ]


selectRow : List (Html.Attribute msg)
selectRow =
    [ style "display" "-ms-flexbox"
    , style "display" "flex"
    , style "-ms-flex-align" "start"
    , style "align-items" "flex-start"
    , style "-ms-flex-pack" "start"
    , style "justify-content" "flex-start"
    , style "-ms-flex-wrap" "wrap"
    , style "flex-wrap" "wrap"
    ]


marginRight : List (Html.Attribute msg)
marginRight =
    [ style "margin-right" "5rem" ]
