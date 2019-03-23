module Demo.TextFields exposing (Model, Msg(..), defaultModel, update, view)

import Demo.Helper.Hero as Hero
import Demo.Helper.ResourceLink as ResourceLink
import Demo.Page as Page exposing (Page)
import Dict exposing (Dict)
import Html exposing (Html, text)
import Html.Attributes
import Html.Events
import Material.TextField as TextField
import Material.TextField.HelperText as TextField
import Material.Typography as Typography


type alias Model =
    {}


defaultModel : Model
defaultModel =
    {}


type Msg
    = NoOp


update : (Msg -> m) -> Msg -> Model -> ( Model, Cmd m )
update lift msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )


heroTextFieldsContainer : List (Html.Attribute m) -> List (Html m) -> Html m
heroTextFieldsContainer options =
    Html.div
        (Html.Attributes.class "hero-text-field-container"
            :: Html.Attributes.style "display" "flex"
            :: Html.Attributes.style "flex" "1 1 100%"
            :: Html.Attributes.style "justify-content" "space-around"
            :: Html.Attributes.style "flex-wrap" "wrap"
            :: options
        )


heroTextFieldContainer : List (Html.Attribute m) -> List (Html m) -> Html m
heroTextFieldContainer options =
    Html.div
        (Html.Attributes.class "text-field-container"
            :: Html.Attributes.style "min-width" "200px"
            :: Html.Attributes.style "padding" "20px"
            :: options
        )


heroTextFields : (Msg -> m) -> Model -> Html m
heroTextFields lift model =
    heroTextFieldContainer []
        [ textFieldContainer []
            [ TextField.view lift
                "text-fields-hero-text-field-1"
                model.mdc
                [ TextField.label "Standard" ]
                []
            , TextField.view lift
                "text-fields-hero-text-field-2"
                model.mdc
                [ TextField.label "Standard", TextField.outlined ]
                []
            ]
        ]


textFieldRow : List (Html.Attribute m) -> List (Html m) -> Html m
textFieldRow options =
    Html.div
        (Html.Attributes.class "text-field-row"
            :: Html.Attributes.style "display" "flex"
            :: Html.Attributes.style "align-items" "flex-start"
            :: Html.Attributes.style "justify-content" "space-between"
            :: Html.Attributes.style "flex-wrap" "wrap"
            :: options
        )


textFieldContainer : List (Html.Attribute m) -> List (Html m) -> Html m
textFieldContainer options =
    Html.div
        (Html.Attributes.class "text-field-container"
            :: Html.Attributes.style "min-width" "200px"
            :: options
        )


helperText : Html m
helperText =
    TextField.helperText
        [ TextField.persistent ]
        [ text "Helper Text"
        ]


filledTextFields : (Msg -> m) -> Model -> Html m
filledTextFields lift model =
    let
        textField index options =
            [ TextField.view lift
                index
                model.mdc
                (TextField.label "Standard" :: options)
                []
            , helperText
            ]
    in
    textFieldRow []
        [ textFieldContainer []
            (textField "text-fields-filled-1" [])
        , textFieldContainer []
            (textField "text-fields-filled-2" [ TextField.leadingIcon "event" ])
        , textFieldContainer []
            (textField "text-fields-filled-3" [ TextField.trailingIcon "trash" ])
        ]


outlinedTextFields : (Msg -> m) -> Model -> Html m
outlinedTextFields lift model =
    let
        textField index options =
            [ TextField.view lift
                index
                model.mdc
                (TextField.label "Standard" :: TextField.outlined :: options)
                []
            , helperText
            ]
    in
    textFieldRow []
        [ textFieldContainer []
            (textField "text-fields-outlined-1" [])
        , textFieldContainer []
            (textField "text-fields-outlined-2" [ TextField.leadingIcon "event" ])
        , textFieldContainer []
            (textField "text-fields-outlined-3" [ TextField.trailingIcon "trash" ])
        ]


shapedFilledTextFields : (Msg -> m) -> Model -> Html m
shapedFilledTextFields lift model =
    let
        textField index options =
            [ TextField.view lift
                index
                model.mdc
                (TextField.label "Standard"
                    :: Html.Attributes.style "border-radius" "16px 16px 0 0"
                    :: options
                )
                []
            , helperText
            ]
    in
    textFieldRow []
        [ textFieldContainer []
            (textField "text-fields-shaped-filled-1" [])
        , textFieldContainer []
            (textField "text-fields-shaped-filled-2" [ TextField.leadingIcon "event" ])
        , textFieldContainer []
            (textField "text-fields-shaped-filled-3" [ TextField.trailingIcon "trash" ])
        ]


shapedOutlinedTextFields : (Msg -> m) -> Model -> Html m
shapedOutlinedTextFields lift model =
    let
        textField index options =
            [ TextField.view lift
                index
                model.mdc
                (TextField.label "Standard" :: TextField.outlined :: options)
                []
            , helperText
            ]
    in
    textFieldRow []
        [ textFieldContainer []
            (textField "text-fields-shaped-outlined-1" [])
        , textFieldContainer []
            (textField "text-fields-shaped-outlined-2" [ TextField.leadingIcon "event" ])
        , textFieldContainer []
            (textField "text-fields-shaped-outlined-3" [ TextField.trailingIcon "trash" ])
        ]


fullwidthTextField : (Msg -> m) -> Model -> Html m
fullwidthTextField lift model =
    textFieldContainer []
        [ TextField.view lift
            "text-field-fullwidth-text-field"
            model.mdc
            [ TextField.placeholder "Standard"
            , TextField.fullwidth
            ]
            []
        , helperText
        ]


textareaTextField : (Msg -> m) -> Model -> Html m
textareaTextField lift model =
    textFieldContainer []
        [ TextField.view lift
            "text-fields-textarea-text-field"
            model.mdc
            [ TextField.label "Standard"
            , TextField.textarea
            , TextField.outlined
            ]
            []
        , helperText
        ]


textFieldRowFullwidth : List (Html.Attribute m) -> List (Html m) -> Html m
textFieldRowFullwidth options =
    Html.div
        (Html.Attributes.class "text-field-row text-field-row--fullwidth"
            :: Html.Attributes.style "display" "block"
            :: options
        )


fullwidthTextareaTextField : (Msg -> m) -> Model -> Html m
fullwidthTextareaTextField lift model =
    textFieldRowFullwidth []
        [ textFieldContainer []
            [ TextField.view lift
                "text-fields-fullwidth-textarea-text-field"
                model.mdc
                [ TextField.label "Standard"
                , TextField.textarea
                , TextField.fullwidth
                , TextField.outlined
                ]
                []
            , helperText
            ]
        ]


view : (Msg -> m) -> Page m -> Model -> Html m
view lift page model =
    page.body "Text Field"
        "Text fields allow users to input, edit, and select text. Text fields typically reside in forms but can appear in other places, like dialog boxes and search."
        [ Hero.view [] [ heroTextFields lift model ]
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
