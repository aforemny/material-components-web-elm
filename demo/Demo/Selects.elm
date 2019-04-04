module Demo.Selects exposing (Model, Msg(..), defaultModel, update, view)

import Demo.Helper.ResourceLink as ResourceLink
import Demo.Page as Page exposing (Page)
import Dict exposing (Dict)
import Html exposing (Html, text)
import Html.Attributes
import Html.Events
import Material.List as Lists exposing (list, listConfig, listItem, listItemConfig)
import Material.Select as Select exposing (SelectOption, filledSelect, outlinedSelect, selectConfig, selectOption, selectOptionConfig)
import Material.Select.Enhanced as EnhancedSelect exposing (enhancedSelectConfig, filledEnhancedSelect, outlinedEnhancedSelect, selectItem, selectItemConfig)
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
    | SetEnhancedValue String


update : (Msg -> m) -> Msg -> Model -> ( Model, Cmd m )
update lift msg model =
    case msg of
        SetValue value ->
            ( { model | value = value }, Cmd.none )

        SetEnhancedValue value ->
            ( { model | enhancedValue = value }, Cmd.none )


view : (Msg -> m) -> Page m -> Model -> Html m
view lift page model =
    page.body "Select"
        "Selects allow users to select from a single-option menu. It functions as a wrapper around the browser's native <select> element."
        [ Page.hero [] [ heroSelects lift model ]
        , Html.h2
            [ Typography.headline6
            , Html.Attributes.style "border-bottom" "1px solid rgba(0,0,0,.87)"
            ]
            [ text "Resources"
            ]
        , ResourceLink.view
            { link = "https://material.io/go/design-text-fields"
            , title = "Material Design Guidelines"
            , icon = "images/material.svg"
            , altText = "Material Design Guidelines icon"
            }
        , ResourceLink.view
            { link = "https://material.io/components/web/catalog/input-controls/select-menus/"
            , title = "Documentation"
            , icon = "images/ic_drive_document_24px.svg"
            , altText = "Documentation icon"
            }
        , ResourceLink.view
            { link = "https://github.com/material-components/material-components-web/tree/master/packages/mdc-select"
            , title = "Source Code (Material Components Web)"
            , icon = "images/ic_code_24px.svg"
            , altText = "Source Code"
            }
        , Page.demos
            [ Html.div selectRow
                [ filledSelects lift model
                , enhancedFilledSelects lift model
                ]
            , Html.h3 [ Typography.subtitle1 ] [ text "Outlined" ]
            , Html.div selectRow
                [ outlinedSelects lift model ]
            , Html.h3 [ Typography.subtitle1 ] [ text "Shaped Filled" ]
            , Html.div selectRow
                [ shapedFilledSelects lift model ]
            , Html.h3 [ Typography.subtitle1 ] [ text "Shaped Outlined (TODO)" ]
            , Html.div selectRow
                [ shapedOutlinedSelects lift model ]
            ]
        ]


heroSelects : (Msg -> m) -> Model -> Html m
heroSelects lift model =
    filledSelect
        { selectConfig
            | label = "Fruit"
            , value = Just model.value
            , onChange = Just (lift << SetValue)
        }
        items


filledSelects : (Msg -> m) -> Model -> Html m
filledSelects lift model =
    Html.div []
        [ Html.h3 [ Typography.subtitle1 ] [ text "Filled" ]
        , filledSelect
            { selectConfig
                | label = "Fruit"
                , additionalAttributes = marginRight
            }
            items
        ]


enhancedFilledSelects : (Msg -> m) -> Model -> Html m
enhancedFilledSelects lift model =
    let
        selectItemConfig_ value =
            { selectItemConfig
                | activated = model.enhancedValue == value
                , onClick = Just (lift (SetEnhancedValue value))
            }
    in
    Html.div []
        [ Html.h3 [ Typography.subtitle1 ] [ text "Filled Enhanced" ]
        , filledEnhancedSelect { enhancedSelectConfig | label = "Fruit" }
            [ list listConfig
                [ selectItem (selectItemConfig_ "") [ text "" ]
                , selectItem (selectItemConfig_ "Apple") [ text "Apple" ]
                , selectItem (selectItemConfig_ "Orange") [ text "Orange" ]
                , selectItem (selectItemConfig_ "Banana") [ text "Banana" ]
                ]
            ]
        ]


outlinedSelects : (Msg -> m) -> Model -> Html m
outlinedSelects lift model =
    outlinedSelect
        { selectConfig
            | label = "Fruit"
            , additionalAttributes = marginRight
        }
        items


shapedFilledSelects : (Msg -> m) -> Model -> Html m
shapedFilledSelects lift model =
    filledSelect
        { selectConfig
            | label = "Fruit"
            , additionalAttributes =
                Html.Attributes.style "border-radius" "17.92px 17.92px 0 0"
                    :: marginRight
        }
        items


shapedOutlinedSelects : (Msg -> m) -> Model -> Html m
shapedOutlinedSelects lift model =
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


items : List (SelectOption m)
items =
    [ selectOption { selectOptionConfig | value = "" } [ text "" ]
    , selectOption { selectOptionConfig | value = "Apple" } [ text "Apple" ]
    , selectOption { selectOptionConfig | value = "Orange" } [ text "Orange" ]
    , selectOption { selectOptionConfig | value = "Banana" } [ text "Banana" ]
    ]


selectRow : List (Html.Attribute m)
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


marginRight : List (Html.Attribute m)
marginRight =
    [ Html.Attributes.style "margin-right" "5rem" ]


demoWidth : List (Html.Attribute m)
demoWidth =
    [ Html.Attributes.style "width" "7rem" ]
