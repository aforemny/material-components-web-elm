module Demo.TextFields exposing (Model, Msg(..), defaultModel, update, view)

import Demo.CatalogPage exposing (CatalogPage)
import Demo.Helper.ResourceLink as ResourceLink
import Dict exposing (Dict)
import Html exposing (Html, text)
import Html.Attributes exposing (class, style)
import Html.Events
import Material.HelperText as HelperText
import Material.Icon as Icon
import Material.TextArea as TextArea
import Material.TextField as TextField
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
            [ TextField.filled
                (TextField.config
                    |> TextField.setLabel (Just "Standard")
                )
            ]
        , Html.div textFieldContainerHero
            [ TextField.outlined
                (TextField.config
                    |> TextField.setLabel (Just "Standard")
                )
            ]
        ]


filledTextFields : Model -> Html msg
filledTextFields model =
    Html.div textFieldRow
        [ Html.div textFieldContainer
            [ TextField.filled
                (TextField.config
                    |> TextField.setLabel (Just "Standard")
                )
            , demoHelperText
            ]
        , Html.div textFieldContainer
            [ TextField.filled
                (TextField.config
                    |> TextField.setLabel (Just "Standard")
                    |> TextField.setLeadingIcon (Just (TextField.icon [] "event"))
                )
            , demoHelperText
            ]
        , Html.div textFieldContainer
            [ TextField.filled
                (TextField.config
                    |> TextField.setLabel (Just "Standard")
                    |> TextField.setTrailingIcon (Just (TextField.icon [] "delete"))
                )
            , demoHelperText
            ]
        ]


shapedFilledTextFields : Model -> Html msg
shapedFilledTextFields model =
    Html.div textFieldRow
        [ Html.div textFieldContainer
            [ TextField.filled
                (TextField.config
                    |> TextField.setLabel (Just "Standard")
                    |> TextField.setAttributes [ style "border-radius" "16px 16px 0 0" ]
                )
            , demoHelperText
            ]
        , Html.div textFieldContainer
            [ TextField.filled
                (TextField.config
                    |> TextField.setLabel (Just "Standard")
                    |> TextField.setLeadingIcon (Just (TextField.icon [] "event"))
                    |> TextField.setAttributes [ style "border-radius" "16px 16px 0 0" ]
                )
            , demoHelperText
            ]
        , Html.div textFieldContainer
            [ TextField.filled
                (TextField.config
                    |> TextField.setLabel (Just "Standard")
                    |> TextField.setTrailingIcon (Just (TextField.icon [] "delete"))
                    |> TextField.setAttributes [ style "border-radius" "16px 16px 0 0" ]
                )
            , demoHelperText
            ]
        ]


outlinedTextFields : Model -> Html msg
outlinedTextFields model =
    Html.div textFieldRow
        [ Html.div textFieldContainer
            [ TextField.outlined
                (TextField.config
                    |> TextField.setLabel (Just "Standard")
                )
            , demoHelperText
            ]
        , Html.div textFieldContainer
            [ TextField.outlined
                (TextField.config
                    |> TextField.setLabel (Just "Standard")
                    |> TextField.setLeadingIcon (Just (TextField.icon [] "event"))
                )
            , demoHelperText
            ]
        , Html.div textFieldContainer
            [ TextField.outlined
                (TextField.config
                    |> TextField.setLabel (Just "Standard")
                    |> TextField.setTrailingIcon (Just (TextField.icon [] "delete"))
                )
            , demoHelperText
            ]
        ]


shapedOutlinedTextFields : Model -> Html msg
shapedOutlinedTextFields model =
    Html.div textFieldRow
        [ Html.div textFieldContainer
            [ TextField.outlined
                (TextField.config
                    |> TextField.setLabel (Just "Standard")
                )
            , demoHelperText
            ]
        , Html.div textFieldContainer
            [ TextField.outlined
                (TextField.config
                    |> TextField.setLabel (Just "Standard")
                    |> TextField.setLeadingIcon (Just (TextField.icon [] "event"))
                )
            , demoHelperText
            ]
        , Html.div textFieldContainer
            [ TextField.outlined
                (TextField.config
                    |> TextField.setLabel (Just "Standard")
                    |> TextField.setTrailingIcon (Just (TextField.icon [] "delete"))
                )
            , demoHelperText
            ]
        ]


textFieldsWithoutLabel : Model -> Html msg
textFieldsWithoutLabel model =
    Html.div textFieldRow
        [ Html.div textFieldContainer
            [ TextField.outlined TextField.config
            , demoHelperText
            ]
        , Html.div textFieldContainer
            [ TextField.outlined
                (TextField.config
                    |> TextField.setLeadingIcon (Just (TextField.icon [] "event"))
                )
            , demoHelperText
            ]
        , Html.div textFieldContainer
            [ TextField.outlined
                (TextField.config
                    |> TextField.setTrailingIcon (Just (TextField.icon [] "delete"))
                )
            , demoHelperText
            ]
        ]


textFieldsWithCharacterCounter : Model -> Html msg
textFieldsWithCharacterCounter model =
    Html.div textFieldRow
        [ Html.div textFieldContainer
            [ TextField.outlined
                (TextField.config |> TextField.setMaxLength (Just 18))
            , demoHelperTextWithCharacterCounter
            ]
        , Html.div textFieldContainer
            [ TextField.outlined
                (TextField.config
                    |> TextField.setLeadingIcon (Just (TextField.icon [] "event"))
                    |> TextField.setMaxLength (Just 18)
                )
            , demoHelperTextWithCharacterCounter
            ]
        , Html.div textFieldContainer
            [ TextField.outlined
                (TextField.config
                    |> TextField.setTrailingIcon (Just (TextField.icon [] "delete"))
                    |> TextField.setMaxLength (Just 18)
                )
            , demoHelperTextWithCharacterCounter
            ]
        ]


textareaTextField : Model -> Html msg
textareaTextField model =
    Html.div textFieldContainer
        [ TextArea.outlined
            (TextArea.config |> TextArea.setLabel (Just "Standard"))
        , demoHelperText
        ]


fullwidthTextField : Model -> Html msg
fullwidthTextField model =
    Html.div textFieldContainer
        [ TextField.filled
            (TextField.config
                |> TextField.setPlaceholder (Just "Standard")
                |> TextField.setFullwidth True
            )
        , demoHelperText
        ]


fullwidthTextareaTextField : Model -> Html msg
fullwidthTextareaTextField model =
    Html.div textFieldRowFullwidth
        [ Html.div textFieldContainer
            [ TextArea.outlined
                (TextArea.config
                    |> TextArea.setLabel (Just "Standard")
                    |> TextArea.setFullwidth True
                )
            , demoHelperText
            ]
        ]


heroTextFieldContainer : List (Html.Attribute msg)
heroTextFieldContainer =
    [ class "hero-text-field-container"
    , style "display" "-ms-flexbox"
    , style "display" "flex"
    , style "-ms-flex" "1 1 100%"
    , style "flex" "1 1 100%"
    , style "-ms-flex-pack" "distribute"
    , style "justify-content" "space-around"
    , style "-ms-flex-wrap" "wrap"
    , style "flex-wrap" "wrap"
    ]


textFieldContainerHero : List (Html.Attribute msg)
textFieldContainerHero =
    style "padding" "20px" :: textFieldContainer


textFieldContainer : List (Html.Attribute msg)
textFieldContainer =
    [ class "text-field-container"
    , style "min-width" "200px"
    ]


textFieldRow : List (Html.Attribute msg)
textFieldRow =
    [ class "text-field-row"
    , style "display" "flex"
    , style "align-items" "flex-start"
    , style "justify-content" "space-between"
    , style "flex-wrap" "wrap"
    ]


textFieldRowFullwidth : List (Html.Attribute msg)
textFieldRowFullwidth =
    [ class "text-field-row text-field-row--fullwidth"
    , style "display" "block"
    ]


demoHelperText : Html msg
demoHelperText =
    HelperText.helperLine []
        [ HelperText.helperText
            (HelperText.config |> HelperText.setPersistent True)
            "Helper Text"
        ]


demoHelperTextWithCharacterCounter : Html msg
demoHelperTextWithCharacterCounter =
    HelperText.helperLine []
        [ HelperText.helperText
            (HelperText.config |> HelperText.setPersistent True)
            "Helper Text"
        , HelperText.characterCounter []
        ]
