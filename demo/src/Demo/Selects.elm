module Demo.Selects exposing (Model, Msg(..), defaultModel, update, view)

import Demo.CatalogPage exposing (CatalogPage)
import Demo.Helper.ResourceLink as ResourceLink
import Dict exposing (Dict)
import Html exposing (Html, text)
import Html.Attributes
import Html.Events
import Material.List exposing (list, listConfig, listItem, listItemConfig)
import Material.Select exposing (SelectOption, filledSelect, outlinedSelect, selectConfig, selectOption, selectOptionConfig)
import Material.Typography as Typography


type alias Model =
    { value : String
    , enhancedValue : String
    }


defaultModel : Model
defaultModel =
    { value = ""
    , enhancedValue = ""
    }


type Msg
    = SetValue String


update : Msg -> Model -> Model
update msg model =
    case msg of
        SetValue value ->
            { model | value = value }


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
        ]
    }


heroSelects : Model -> Html Msg
heroSelects model =
    filledSelect
        { selectConfig
            | label = "Fruit"
            , value = Just model.value
            , onChange = Just SetValue
        }
        items


filledSelects : Model -> Html msg
filledSelects model =
    Html.div []
        [ Html.h3 [ Typography.subtitle1 ] [ text "Filled" ]
        , filledSelect
            { selectConfig
                | label = "Fruit"
                , additionalAttributes = marginRight
            }
            items
        ]


outlinedSelects : Model -> Html msg
outlinedSelects model =
    outlinedSelect
        { selectConfig
            | label = "Fruit"
            , additionalAttributes = marginRight
        }
        items


shapedFilledSelects : Model -> Html msg
shapedFilledSelects model =
    filledSelect
        { selectConfig
            | label = "Fruit"
            , additionalAttributes =
                Html.Attributes.style "border-radius" "17.92px 17.92px 0 0"
                    :: marginRight
        }
        items


shapedOutlinedSelects : Model -> Html msg
shapedOutlinedSelects model =
    outlinedSelect
        { selectConfig
            | label = "Fruit"
            , additionalAttributes =
                -- TODO:
                -- [ Html.Attributes.style "border-radius" "28px"
                -- , Html.Attributes.style "padding-left" "32px"
                -- , Html.Attributes.style "padding-right" "52px"
                -- ]
                marginRight
        }
        items


items : List (SelectOption msg)
items =
    [ selectOption { selectOptionConfig | value = "" } [ text "" ]
    , selectOption { selectOptionConfig | value = "Apple" } [ text "Apple" ]
    , selectOption { selectOptionConfig | value = "Orange" } [ text "Orange" ]
    , selectOption { selectOptionConfig | value = "Banana" } [ text "Banana" ]
    ]


selectRow : List (Html.Attribute msg)
selectRow =
    [ Html.Attributes.style "display" "-ms-flexbox"
    , Html.Attributes.style "display" "flex"
    , Html.Attributes.style "-ms-flex-align" "start"
    , Html.Attributes.style "align-items" "flex-start"
    , Html.Attributes.style "-ms-flex-pack" "start"
    , Html.Attributes.style "justify-content" "flex-start"
    , Html.Attributes.style "-ms-flex-wrap" "wrap"
    , Html.Attributes.style "flex-wrap" "wrap"
    ]


marginRight : List (Html.Attribute msg)
marginRight =
    [ Html.Attributes.style "margin-right" "5rem" ]


demoWidth : List (Html.Attribute msg)
demoWidth =
    [ Html.Attributes.style "width" "7rem" ]
