module Demo.TextFields exposing (Model, Msg(..), defaultModel, update, view)

import Demo.CatalogPage exposing (CatalogPage)
import Demo.Helper.ResourceLink as ResourceLink
import Dict exposing (Dict)
import Html exposing (Html, text)
import Html.Attributes
import Html.Events
import Material.HelperText exposing (characterCounter, helperLine, helperText, helperTextConfig)
import Material.Icon exposing (icon, iconConfig)
import Material.TextArea exposing (textArea, textAreaConfig)
import Material.TextField exposing (textField, textFieldConfig, textFieldIcon)
import Material.Typography as Typography


type alias Model =
    { value : String }


defaultModel : Model
defaultModel =
    { value = "" }


type Msg
    = NoOp


update : Msg -> Model -> Model
update msg model =
    case msg of
        NoOp ->
            model


view : Model -> CatalogPage Msg
view model =
    { title = "Text Field"
    , prelude = "Text fields allow users to input, edit, and select text. Text fields typically reside in forms but can appear in other places, like dialog boxes and search."
    , resources =
        { materialDesignGuidelines = Just "https://material.io/go/design-text-fields"
        , documentation = Just "https://package.elm-lang.org/packages/aforemny/material-components-web-elm/latest/Material-TextField"
        , sourceCode = Just "https://github.com/material-components/material-components-web/tree/master/packages/mdc-textfield"
        }
    , hero = [ heroTextFields model ]
    , content =
        [ Html.h3 [ Typography.subtitle1 ] [ text "Filled" ]
        , filledTextFields model
        , Html.h3 [ Typography.subtitle1 ] [ text "Shaped Filled" ]
        , shapedFilledTextFields model
        , Html.h3 [ Typography.subtitle1 ] [ text "Outlined" ]
        , outlinedTextFields model
        , Html.h3 [ Typography.subtitle1 ] [ text "Shaped Outlined (TODO)" ]
        , shapedOutlinedTextFields model
        , Html.h3 [ Typography.subtitle1 ] [ text "Text Fields without Label" ]
        , textFieldsWithoutLabel model
        , Html.h3 [ Typography.subtitle1 ] [ text "Text Fields with Character Counter" ]
        , textFieldsWithCharacterCounter model
        , Html.h3 [ Typography.subtitle1 ] [ text "Textarea" ]
        , textareaTextField model
        , Html.h3 [ Typography.subtitle1 ] [ text "Full Width" ]
        , fullwidthTextField model
        , Html.h3 [ Typography.subtitle1 ] [ text "Full Width Textarea" ]
        , fullwidthTextareaTextField model
        ]
    }


heroTextFields : Model -> Html Msg
heroTextFields model =
    Html.div heroTextFieldContainer
        [ Html.div textFieldContainerHero
            [ textField { textFieldConfig | label = Just "Standard" } ]
        , Html.div textFieldContainerHero
            [ textField { textFieldConfig | label = Just "Standard", outlined = True } ]
        ]


filledTextFields : Model -> Html msg
filledTextFields model =
    Html.div textFieldRow
        [ Html.div textFieldContainer
            [ textField { textFieldConfig | label = Just "Standard" }
            , demoHelperText
            ]
        , Html.div textFieldContainer
            [ textField
                { textFieldConfig
                    | label = Just "Standard"
                    , leadingIcon = textFieldIcon iconConfig "event"
                }
            , demoHelperText
            ]
        , Html.div textFieldContainer
            [ textField
                { textFieldConfig
                    | label = Just "Standard"
                    , trailingIcon = textFieldIcon iconConfig "delete"
                }
            , demoHelperText
            ]
        ]


shapedFilledTextFields : Model -> Html msg
shapedFilledTextFields model =
    Html.div textFieldRow
        [ Html.div textFieldContainer
            [ textField
                { textFieldConfig
                    | label = Just "Standard"
                    , additionalAttributes =
                        [ Html.Attributes.style "border-radius" "16px 16px 0 0" ]
                }
            , demoHelperText
            ]
        , Html.div textFieldContainer
            [ textField
                { textFieldConfig
                    | label = Just "Standard"
                    , leadingIcon = textFieldIcon iconConfig "event"
                    , additionalAttributes =
                        [ Html.Attributes.style "border-radius" "16px 16px 0 0" ]
                }
            , demoHelperText
            ]
        , Html.div textFieldContainer
            [ textField
                { textFieldConfig
                    | label = Just "Standard"
                    , trailingIcon = textFieldIcon iconConfig "delete"
                    , additionalAttributes =
                        [ Html.Attributes.style "border-radius" "16px 16px 0 0" ]
                }
            , demoHelperText
            ]
        ]


outlinedTextFields : Model -> Html msg
outlinedTextFields model =
    Html.div textFieldRow
        [ Html.div textFieldContainer
            [ textField { textFieldConfig | label = Just "Standard", outlined = True }
            , demoHelperText
            ]
        , Html.div textFieldContainer
            [ textField
                { textFieldConfig
                    | label = Just "Standard"
                    , outlined = True
                    , leadingIcon = textFieldIcon iconConfig "event"
                }
            , demoHelperText
            ]
        , Html.div textFieldContainer
            [ textField
                { textFieldConfig
                    | label = Just "Standard"
                    , outlined = True
                    , trailingIcon = textFieldIcon iconConfig "delete"
                }
            , demoHelperText
            ]
        ]


shapedOutlinedTextFields : Model -> Html msg
shapedOutlinedTextFields model =
    Html.div textFieldRow
        [ Html.div textFieldContainer
            [ textField { textFieldConfig | label = Just "Standard", outlined = True }
            , demoHelperText
            ]
        , Html.div textFieldContainer
            [ textField
                { textFieldConfig
                    | label = Just "Standard"
                    , outlined = True
                    , leadingIcon = textFieldIcon iconConfig "event"
                }
            , demoHelperText
            ]
        , Html.div textFieldContainer
            [ textField
                { textFieldConfig
                    | label = Just "Standard"
                    , outlined = True
                    , trailingIcon = textFieldIcon iconConfig "delete"
                }
            , demoHelperText
            ]
        ]


textFieldsWithoutLabel : Model -> Html msg
textFieldsWithoutLabel model =
    Html.div textFieldRow
        [ Html.div textFieldContainer
            [ textField { textFieldConfig | outlined = True }
            , demoHelperText
            ]
        , Html.div textFieldContainer
            [ textField
                { textFieldConfig
                    | outlined = True
                    , leadingIcon = textFieldIcon iconConfig "event"
                }
            , demoHelperText
            ]
        , Html.div textFieldContainer
            [ textField
                { textFieldConfig
                    | outlined = True
                    , trailingIcon = textFieldIcon iconConfig "delete"
                }
            , demoHelperText
            ]
        ]


textFieldsWithCharacterCounter : Model -> Html msg
textFieldsWithCharacterCounter model =
    Html.div textFieldRow
        [ Html.div textFieldContainer
            [ textField { textFieldConfig | outlined = True, maxLength = Just 18 }
            , demoHelperTextWithCharacterCounter
            ]
        , Html.div textFieldContainer
            [ textField
                { textFieldConfig
                    | outlined = True
                    , leadingIcon = textFieldIcon iconConfig "event"
                    , maxLength = Just 18
                }
            , demoHelperTextWithCharacterCounter
            ]
        , Html.div textFieldContainer
            [ textField
                { textFieldConfig
                    | outlined = True
                    , trailingIcon = textFieldIcon iconConfig "delete"
                    , maxLength = Just 18
                }
            , demoHelperTextWithCharacterCounter
            ]
        ]


textareaTextField : Model -> Html msg
textareaTextField model =
    Html.div textFieldContainer
        [ textArea { textAreaConfig | label = Just "Standard", outlined = True }
        , demoHelperText
        ]


fullwidthTextField : Model -> Html msg
fullwidthTextField model =
    Html.div textFieldContainer
        [ textField { textFieldConfig | placeholder = Just "Standard", fullwidth = True }
        , demoHelperText
        ]


fullwidthTextareaTextField : Model -> Html msg
fullwidthTextareaTextField model =
    Html.div textFieldRowFullwidth
        [ Html.div textFieldContainer
            [ textArea
                { textAreaConfig
                    | label = Just "Standard"
                    , fullwidth = True
                    , outlined = True
                }
            , demoHelperText
            ]
        ]


heroTextFieldContainer : List (Html.Attribute msg)
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


textFieldContainerHero : List (Html.Attribute msg)
textFieldContainerHero =
    Html.Attributes.style "padding" "20px" :: textFieldContainer


textFieldContainer : List (Html.Attribute msg)
textFieldContainer =
    [ Html.Attributes.class "text-field-container"
    , Html.Attributes.style "min-width" "200px"
    ]


textFieldRow : List (Html.Attribute msg)
textFieldRow =
    [ Html.Attributes.class "text-field-row"
    , Html.Attributes.style "display" "flex"
    , Html.Attributes.style "align-items" "flex-start"
    , Html.Attributes.style "justify-content" "space-between"
    , Html.Attributes.style "flex-wrap" "wrap"
    ]


textFieldRowFullwidth : List (Html.Attribute msg)
textFieldRowFullwidth =
    [ Html.Attributes.class "text-field-row text-field-row--fullwidth"
    , Html.Attributes.style "display" "block"
    ]


demoHelperText : Html msg
demoHelperText =
    helperLine []
        [ helperText { helperTextConfig | persistent = True } "Helper Text" ]


demoHelperTextWithCharacterCounter : Html msg
demoHelperTextWithCharacterCounter =
    helperLine []
        [ helperText { helperTextConfig | persistent = True } "Helper Text"
        , characterCounter []
        ]
