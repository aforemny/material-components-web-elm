module Demo.TextFields exposing (Model, Msg(..), defaultModel, update, view)

import Demo.Helper.ResourceLink as ResourceLink
import Demo.Page as Page exposing (Page)
import Dict exposing (Dict)
import Html exposing (Html, text)
import Html.Attributes
import Html.Events
import Material.Icon as Icon exposing (icon, iconConfig)
import Material.TextField as TextField exposing (textField, textFieldConfig, textFieldIcon)
import Material.TextField.HelperText exposing (helperText, helperTextConfig)
import Material.Typography as Typography


type alias Model =
    { value : String }


defaultModel : Model
defaultModel =
    { value = "" }


type Msg
    = NoOp
    | SetValue String


update : (Msg -> m) -> Msg -> Model -> ( Model, Cmd m )
update lift msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )

        SetValue value ->
            ( model, Cmd.none )


view : (Msg -> m) -> Page m -> Model -> Html m
view lift page model =
    page.body "Text Field"
        "Text fields allow users to input, edit, and select text. Text fields typically reside in forms but can appear in other places, like dialog boxes and search."
        [ Page.hero [] [ heroTextFields lift model ]
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
            { link = "https://material.io/components/web/catalog/input-controls/text-field/"
            , title = "Documentation"
            , icon = "images/ic_drive_document_24px.svg"
            , altText = "Documentation icon"
            }
        , ResourceLink.view
            { link = "https://github.com/material-components/material-components-web/tree/master/packages/mdc-textfield"
            , title = "Source Code (Material Components Web)"
            , icon = "images/ic_code_24px.svg"
            , altText = "Source Code"
            }
        , Page.demos
            [ Html.h3 [ Typography.subtitle1 ] [ text "Filled" ]
            , filledTextFields lift model
            , Html.h3 [ Typography.subtitle1 ] [ text "Shaped Filled" ]
            , shapedFilledTextFields lift model
            , Html.h3 [ Typography.subtitle1 ] [ text "Outlined" ]
            , outlinedTextFields lift model
            , Html.h3 [ Typography.subtitle1 ] [ text "Shaped Outlined (TODO)" ]
            , shapedOutlinedTextFields lift model
            , Html.h3 [ Typography.subtitle1 ] [ text "Textarea" ]
            , textareaTextField lift model
            , Html.h3 [ Typography.subtitle1 ] [ text "Full Width" ]
            , fullwidthTextField lift model
            , Html.h3 [ Typography.subtitle1 ] [ text "Full Width Textarea" ]
            , fullwidthTextareaTextField lift model
            ]
        ]


heroTextFields : (Msg -> m) -> Model -> Html m
heroTextFields lift model =
    Html.div heroTextFieldContainer
        [ Html.div textFieldContainerHero
            [ textField { textFieldConfig | label = "Standard", value = Just model.value, onInput = Just (lift << SetValue) } ]
        , Html.div textFieldContainerHero
            [ textField { textFieldConfig | label = "Standard", outlined = True, value = Just model.value, onInput = Just (lift << SetValue) } ]
        ]


filledTextFields : (Msg -> m) -> Model -> Html m
filledTextFields lift model =
    Html.div textFieldRow
        [ Html.div textFieldContainer
            [ textField { textFieldConfig | label = "Standard" }
            , demoHelperText
            ]
        , Html.div textFieldContainer
            [ textField
                { textFieldConfig
                    | label = "Standard"
                    , leadingIcon = textFieldIcon iconConfig "event"
                }
            , demoHelperText
            ]
        , Html.div textFieldContainer
            [ textField
                { textFieldConfig
                    | label = "Standard"
                    , trailingIcon = textFieldIcon iconConfig "delete"
                }
            , demoHelperText
            ]
        ]


shapedFilledTextFields : (Msg -> m) -> Model -> Html m
shapedFilledTextFields lift model =
    Html.div textFieldRow
        [ Html.div textFieldContainer
            [ textField
                { textFieldConfig
                    | label = "Standard"
                    , additionalAttributes =
                        [ Html.Attributes.style "border-radius" "16px 16px 0 0" ]
                }
            , demoHelperText
            ]
        , Html.div textFieldContainer
            [ textField
                { textFieldConfig
                    | label = "Standard"
                    , leadingIcon = textFieldIcon iconConfig "event"
                    , additionalAttributes =
                        [ Html.Attributes.style "border-radius" "16px 16px 0 0" ]
                }
            , demoHelperText
            ]
        , Html.div textFieldContainer
            [ textField
                { textFieldConfig
                    | label = "Standard"
                    , trailingIcon = textFieldIcon iconConfig "delete"
                    , additionalAttributes =
                        [ Html.Attributes.style "border-radius" "16px 16px 0 0" ]
                }
            , demoHelperText
            ]
        ]


outlinedTextFields : (Msg -> m) -> Model -> Html m
outlinedTextFields lift model =
    Html.div textFieldRow
        [ Html.div textFieldContainer
            [ textField { textFieldConfig | label = "Standard", outlined = True }
            , demoHelperText
            ]
        , Html.div textFieldContainer
            [ textField
                { textFieldConfig
                    | label = "Standard"
                    , outlined = True
                    , leadingIcon = textFieldIcon iconConfig "event"
                }
            , demoHelperText
            ]
        , Html.div textFieldContainer
            [ textField
                { textFieldConfig
                    | label = "Standard"
                    , outlined = True
                    , trailingIcon = textFieldIcon iconConfig "delete"
                }
            , demoHelperText
            ]
        ]


shapedOutlinedTextFields : (Msg -> m) -> Model -> Html m
shapedOutlinedTextFields lift model =
    Html.div textFieldRow
        [ Html.div textFieldContainer
            [ textField { textFieldConfig | label = "Standard", outlined = True }
            , demoHelperText
            ]
        , Html.div textFieldContainer
            [ textField
                { textFieldConfig
                    | label = "Standard"
                    , outlined = True
                    , leadingIcon = textFieldIcon iconConfig "event"
                }
            , demoHelperText
            ]
        , Html.div textFieldContainer
            [ textField
                { textFieldConfig
                    | label = "Standard"
                    , outlined = True
                    , trailingIcon = textFieldIcon iconConfig "delete"
                }
            , demoHelperText
            ]
        ]


textareaTextField : (Msg -> m) -> Model -> Html m
textareaTextField lift model =
    Html.div textFieldContainer
        [ textField
            { textFieldConfig | label = "Standard", textarea = True, outlined = True }
        , demoHelperText
        ]


fullwidthTextField : (Msg -> m) -> Model -> Html m
fullwidthTextField lift model =
    Html.div textFieldContainer
        [ textField { textFieldConfig | placeholder = Just "Standard", fullwidth = True }
        , demoHelperText
        ]


fullwidthTextareaTextField : (Msg -> m) -> Model -> Html m
fullwidthTextareaTextField lift model =
    Html.div textFieldRowFullwidth
        [ Html.div textFieldContainer
            [ textField
                { textFieldConfig
                    | label = "Standard"
                    , textarea = True
                    , fullwidth = True
                    , outlined = True
                }
            , demoHelperText
            ]
        ]


heroTextFieldContainer : List (Html.Attribute m)
heroTextFieldContainer =
    [ Html.Attributes.class "hero-text-field-container"
    , Html.Attributes.style "display" "-ms-flexbox"
    , Html.Attributes.style "display" "flex"
    , Html.Attributes.style "-ms-flex" "1 1 100%"
    , Html.Attributes.style "flex" "1 1 100%"
    , Html.Attributes.style "-ms-flex-pack" "distribute"
    , Html.Attributes.style "justify-content" "space-around"
    , Html.Attributes.style "-ms-flex-wrap" "wrap"
    , Html.Attributes.style "flex-wrap" "wrap"
    ]


textFieldContainerHero : List (Html.Attribute m)
textFieldContainerHero =
    Html.Attributes.style "padding" "20px" :: textFieldContainer


textFieldContainer : List (Html.Attribute m)
textFieldContainer =
    [ Html.Attributes.class "text-field-container"
    , Html.Attributes.style "min-width" "200px"
    ]


textFieldRow : List (Html.Attribute m)
textFieldRow =
    [ Html.Attributes.class "text-field-row"
    , Html.Attributes.style "display" "flex"
    , Html.Attributes.style "align-items" "flex-start"
    , Html.Attributes.style "justify-content" "space-between"
    , Html.Attributes.style "flex-wrap" "wrap"
    ]


textFieldRowFullwidth : List (Html.Attribute m)
textFieldRowFullwidth =
    [ Html.Attributes.class "text-field-row text-field-row--fullwidth"
    , Html.Attributes.style "display" "block"
    ]


demoHelperText : Html m
demoHelperText =
    helperText { helperTextConfig | persistent = True } "Helper Text"
