module Demo.Selects exposing (Model, Msg(..), defaultModel, subscriptions, update, view)

import Demo.Helper.ResourceLink as ResourceLink
import Demo.Page as Page exposing (Page)
import Dict exposing (Dict)
import Html exposing (Html, text)
import Html.Attributes
import Html.Events
import Material.Select as Select exposing (SelectOption, filledSelect, outlinedSelect, selectConfig, selectOption, selectOptionConfig)
import Material.Typography as Typography


type alias Model =
    { value : String
    }


defaultModel : Model
defaultModel =
    { value = ""
    }


type Msg
    = Select String


update : (Msg -> m) -> Msg -> Model -> ( Model, Cmd m )
update lift msg model =
    case msg of
        Select value ->
            ( { model | value = value }, Cmd.none )


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
            [ Html.h3 [ Typography.subtitle1 ] [ text "Filled" ]
            , filledSelects lift model
            , Html.h3 [ Typography.subtitle1 ] [ text "Outlined" ]
            , outlinedSelects lift model
            , Html.h3 [ Typography.subtitle1 ] [ text "Shaped Filled" ]
            , shapedFilledSelects lift model
            , Html.h3 [ Typography.subtitle1 ] [ text "Shaped Outlined" ]
            , shapedOutlinedSelects lift model
            ]
        ]


heroSelects : (Msg -> m) -> Model -> Html m
heroSelects lift model =
    filledSelect
        { selectConfig
            | label = "Fruit"
            , value = Just model.value
            , onChange = Just (lift << Select)
        }
        items


filledSelects : (Msg -> m) -> Model -> Html m
filledSelects lift model =
    filledSelect { selectConfig | label = "Fruit" } items


outlinedSelects : (Msg -> m) -> Model -> Html m
outlinedSelects lift model =
    outlinedSelect { selectConfig | label = "Fruit" } items


shapedFilledSelects : (Msg -> m) -> Model -> Html m
shapedFilledSelects lift model =
    filledSelect
        { selectConfig
            | label = "Fruit"
            , additionalAttributes =
                [ Html.Attributes.style "border-radius" "17.92px 17.92px 0 0" ]
        }
        items


shapedOutlinedSelects : (Msg -> m) -> Model -> Html m
shapedOutlinedSelects lift model =
    outlinedSelect
        { selectConfig
            | label = "Fruit"
            , additionalAttributes =
                [-- TODO:
                 -- , Select.nativeControl
                 --     [ Html.Attributes.style "border-radius" "28px"
                 --     , Html.Attributes.style "padding-left" "32px"
                 --     , Html.Attributes.style "padding-right" "52px"
                 --     ]
                ]
        }
        items


items : List (SelectOption m)
items =
    [ selectOption { selectOptionConfig | value = "" } [ text "" ]
    , selectOption { selectOptionConfig | value = "Apple" } [ text "Apple" ]
    , selectOption { selectOptionConfig | value = "Orange" } [ text "Orange" ]
    , selectOption { selectOptionConfig | value = "Banana" } [ text "Banana" ]
    ]


subscriptions : (Msg -> m) -> Model -> Sub m
subscriptions lift model =
    Sub.none
