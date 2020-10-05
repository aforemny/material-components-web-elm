module Demo.TextFields exposing (Model, Msg(..), defaultModel, update, view)

import Browser.Dom
import Demo.CatalogPage exposing (CatalogPage)
import Demo.ElmLogo exposing (elmLogo)
import Html exposing (Html, text)
import Html.Attributes exposing (class, style)
import Material.Button as Button
import Material.HelperText as HelperText
import Material.TextArea as TextArea
import Material.TextField as TextField
import Material.TextField.Icon as TextFieldIcon
import Material.Typography as Typography
import Svg.Attributes
import Task


type alias Model =
    { value : String }


defaultModel : Model
defaultModel =
    { value = "" }


type Msg
    = Interacted
    | Focus String
    | Focused (Result Browser.Dom.Error ())


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Interacted ->
            ( model, Cmd.none )

        Focus id ->
            ( model, Task.attempt Focused (Browser.Dom.focus id) )

        Focused _ ->
            ( model, Cmd.none )


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
        , Html.h3 [ Typography.subtitle1 ] [ text "Text Field with Affix" ]
        , affixedFilledTextFields model
        , Html.h3 [ Typography.subtitle1 ] [ text "Text Field without Label" ]
        , textFieldsWithoutLabel model
        , Html.h3 [ Typography.subtitle1 ] [ text "Text Field with Character Counter" ]
        , textFieldsWithCharacterCounter model
        , Html.h3 [ Typography.subtitle1 ] [ text "Text Field with Custom Icon" ]
        , textFieldsWithCustomIcon model
        , Html.h3 [ Typography.subtitle1 ] [ text "Textarea" ]
        , textareaTextField model
        , Html.h3 [ Typography.subtitle1 ] [ text "Full Width" ]
        , fullwidthTextField model
        , Html.h3 [ Typography.subtitle1 ] [ text "Full Width Textarea" ]
        , fullwidthTextareaTextField model
        , Html.h3 [ Typography.subtitle1 ] [ text "Focus Text Field" ]
        , focusTextField
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


filledTextFields : Model -> Html Msg
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
                    |> TextField.setLeadingIcon (Just (TextFieldIcon.icon "event"))
                )
            , demoHelperText
            ]
        , Html.div textFieldContainer
            [ TextField.filled
                (TextField.config
                    |> TextField.setLabel (Just "Standard")
                    |> TextField.setTrailingIcon
                        (Just
                            (TextFieldIcon.icon "delete"
                                |> TextFieldIcon.setOnInteraction Interacted
                            )
                        )
                )
            , demoHelperText
            ]
        ]


shapedFilledTextFields : Model -> Html Msg
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
                    |> TextField.setLeadingIcon (Just (TextFieldIcon.icon "event"))
                    |> TextField.setAttributes [ style "border-radius" "16px 16px 0 0" ]
                )
            , demoHelperText
            ]
        , Html.div textFieldContainer
            [ TextField.filled
                (TextField.config
                    |> TextField.setLabel (Just "Standard")
                    |> TextField.setTrailingIcon
                        (Just
                            (TextFieldIcon.icon "delete"
                                |> TextFieldIcon.setOnInteraction Interacted
                            )
                        )
                    |> TextField.setAttributes [ style "border-radius" "16px 16px 0 0" ]
                )
            , demoHelperText
            ]
        ]


outlinedTextFields : Model -> Html Msg
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
                    |> TextField.setLeadingIcon (Just (TextFieldIcon.icon "event"))
                )
            , demoHelperText
            ]
        , Html.div textFieldContainer
            [ TextField.outlined
                (TextField.config
                    |> TextField.setLabel (Just "Standard")
                    |> TextField.setTrailingIcon
                        (Just
                            (TextFieldIcon.icon "delete"
                                |> TextFieldIcon.setOnInteraction Interacted
                            )
                        )
                )
            , demoHelperText
            ]
        ]


shapedOutlinedTextFields : Model -> Html Msg
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
                    |> TextField.setLeadingIcon (Just (TextFieldIcon.icon "event"))
                )
            , demoHelperText
            ]
        , Html.div textFieldContainer
            [ TextField.outlined
                (TextField.config
                    |> TextField.setLabel (Just "Standard")
                    |> TextField.setTrailingIcon
                        (Just
                            (TextFieldIcon.icon "delete"
                                |> TextFieldIcon.setOnInteraction Interacted
                            )
                        )
                )
            , demoHelperText
            ]
        ]


affixedFilledTextFields : Model -> Html Msg
affixedFilledTextFields model =
    Html.div textFieldRow
        [ Html.div textFieldContainer
            [ TextField.filled
                (TextField.config
                    |> TextField.setLabel (Just "Standard")
                    |> TextField.setPrefix (Just "$")
                )
            , demoHelperText
            ]
        , Html.div textFieldContainer
            [ TextField.filled
                (TextField.config
                    |> TextField.setLabel (Just "Standard")
                    |> TextField.setSuffix (Just "kg")
                )
            , demoHelperText
            ]
        , Html.div textFieldContainer
            [ TextField.filled
                (TextField.config
                    |> TextField.setLabel (Just "Standard")
                    |> TextField.setPrefix (Just "$")
                    |> TextField.setSuffix (Just ".00")
                )
            , demoHelperText
            ]
        ]


textFieldsWithoutLabel : Model -> Html Msg
textFieldsWithoutLabel model =
    Html.div textFieldRow
        [ Html.div textFieldContainer
            [ TextField.outlined TextField.config
            , demoHelperText
            ]
        , Html.div textFieldContainer
            [ TextField.outlined
                (TextField.config
                    |> TextField.setLeadingIcon (Just (TextFieldIcon.icon "event"))
                )
            , demoHelperText
            ]
        , Html.div textFieldContainer
            [ TextField.outlined
                (TextField.config
                    |> TextField.setTrailingIcon
                        (Just
                            (TextFieldIcon.icon "delete"
                                |> TextFieldIcon.setOnInteraction Interacted
                            )
                        )
                )
            , demoHelperText
            ]
        ]


textFieldsWithCharacterCounter : Model -> Html Msg
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
                    |> TextField.setLeadingIcon (Just (TextFieldIcon.icon "event"))
                    |> TextField.setMaxLength (Just 18)
                )
            , demoHelperTextWithCharacterCounter
            ]
        , Html.div textFieldContainer
            [ TextField.outlined
                (TextField.config
                    |> TextField.setTrailingIcon
                        (Just
                            (TextFieldIcon.icon "delete"
                                |> TextFieldIcon.setOnInteraction Interacted
                            )
                        )
                    |> TextField.setMaxLength (Just 18)
                )
            , demoHelperTextWithCharacterCounter
            ]
        ]


textFieldsWithCustomIcon : Model -> Html Msg
textFieldsWithCustomIcon model =
    Html.div textFieldRow
        [ Html.div textFieldContainer
            [ TextField.filled
                (TextField.config
                    |> TextField.setLabel (Just "Material Icons")
                    |> TextField.setLeadingIcon
                        (Just (TextFieldIcon.icon "favorite"))
                    |> TextField.setTrailingIcon
                        (Just
                            (TextFieldIcon.icon "delete"
                                |> TextFieldIcon.setOnInteraction Interacted
                            )
                        )
                )
            ]
        , Html.div textFieldContainer
            [ TextField.filled
                (TextField.config
                    |> TextField.setLabel (Just "Font Awesome")
                    |> TextField.setLeadingIcon
                        (Just
                            (TextFieldIcon.customIcon Html.i
                                [ class "fab fa-font-awesome"
                                , style "font-size" "24px"
                                ]
                                []
                            )
                        )
                    |> TextField.setTrailingIcon
                        (Just
                            (TextFieldIcon.customIcon Html.i
                                [ class "fab fa-font-awesome"
                                , style "font-size" "24px"
                                ]
                                []
                                |> TextFieldIcon.setOnInteraction Interacted
                            )
                        )
                )
            ]
        , Html.div textFieldContainer
            [ TextField.filled
                (TextField.config
                    |> TextField.setLabel (Just "SVG")
                    |> TextField.setLeadingIcon
                        (Just
                            (TextFieldIcon.svgIcon
                                [ Svg.Attributes.viewBox "0 0 100 100"
                                , style "width" "24px"
                                , style "height" "24px"
                                ]
                                elmLogo
                            )
                        )
                    |> TextField.setTrailingIcon
                        (Just
                            (TextFieldIcon.svgIcon
                                [ Svg.Attributes.viewBox "0 0 100 100"
                                , style "width" "24px"
                                , style "height" "24px"
                                ]
                                elmLogo
                                |> TextFieldIcon.setOnInteraction Interacted
                            )
                        )
                )
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


focusTextField : Html Msg
focusTextField =
    Html.div []
        [ TextField.filled
            (TextField.config
                |> TextField.setAttributes [ Html.Attributes.id "my-text-field" ]
            )
        , text "\u{00A0}"
        , Button.raised
            (Button.config |> Button.setOnClick (Focus "my-text-field"))
            "Focus"
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
