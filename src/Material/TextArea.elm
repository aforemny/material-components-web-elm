module Material.TextArea exposing
    ( textArea, textAreaConfig, TextAreaConfig
    , characterCounter
    )

{-| Text areas allow users to input, edit, and select text.


# Table of Contents

  - [Resources](#resources)
  - [Basic Usage](#basic-usage)
  - [Full Width Text Area](#full-width-text-field)
  - [Disabled Text Area](#disabled-text-field)
  - [Required Text Area](#disabled-text-field)
  - [Invalid Text Area](#disabled-text-field)
  - [Text Area with Character Counter](#text-field-with-character-counter)


# Resources

  - [Demo: Text Areas](https://aforemny.github.io/material-components-web-elm/#text-fields)
  - [Material Design Guidelines: Menus](https://material.io/go/design-menus)
  - [MDC Web: Menu](https://github.com/material-components/material-components-web/tree/master/packages/mdc-menu)
  - [Sass Mixins (MDC Web)](https://github.com/material-components/material-components-web/tree/master/packages/mdc-menu#sass-mixins)


# Basic Usage

    import Material.TextArea
        exposing
            ( textArea
            , textAreaConfig
            )

    type Msg
        = ValueChanged String

    main =
        textArea
            { textAreaConfig
                | label = "My text area"
                , value = Just "hello world"
                , onInput = Just ValueChanged
                , rows = Just 4
                , columns = Just 20
            }

@docs textArea, textAreaConfig, TextAreaConfig


# Full Width Text Area

To make a text area span all of its available width, set its `fullwidth`
configuration field to `True`.

    textArea { textAreaConfig | fullWidth = True }

Full width text areas do not support `label` and will ignore this
configuration field. You may set `placeholder` or provide an extraneous label
for a full width text area.

Full width text areas do not support `outlined` and will ignore this
configuration field.


# Disabled Text Area

To disable a text area set its `disabled` configuration field to `True`.

    textArea { textAreaConfig | disabled = True }


# Required Text Area

To mark a text area as required, set its `required` configuration field to
`True`.

    textArea { textAreaConfig | required = True }


# Invalid Text Area

To mark a text area as invalid, set its `valid` configuration field to
`False`.

    textArea { textAreaConfig | valid = False }


# Outlined Text Area

Text areas may have a visible outlined around them by setting their `outlined`
configuration field to `True`.

    textArea { textAreaConfig | outlined = True }

Note that this does not have any effect for fullwidth text areas.


# Text Area with Character Counter

To have a text area display a character counter, set its `maxLength`
configuration field, and also add a `characterCounter` as a child of
`helperLine`.

    [ textArea
        { textAreaConfig
            | maxLength = Just 18
        }
    , helperLine [] [ characterCounter [] ]
    ]

@docs characterCounter

-}

import Html exposing (Html, text)
import Html.Attributes exposing (class)
import Html.Events
import Json.Decode as Decode
import Json.Encode as Encode


{-| Configuration of a text area
-}
type alias TextAreaConfig msg =
    { label : Maybe String
    , outlined : Bool
    , fullwidth : Bool
    , value : String
    , placeholder : Maybe String
    , rows : Maybe Int
    , cols : Maybe Int
    , disabled : Bool
    , required : Bool
    , valid : Bool
    , minLength : Maybe Int
    , maxLength : Maybe Int
    , additionalAttributes : List (Html.Attribute msg)
    , onInput : Maybe (String -> msg)
    , onChange : Maybe (String -> msg)
    }


type TextAreaIcon msg
    = NoIcon
    | Icon (Html msg)


{-| Default configuration of a text area
-}
textAreaConfig : TextAreaConfig msg
textAreaConfig =
    { label = Nothing
    , outlined = False
    , fullwidth = False
    , value = ""
    , placeholder = Nothing
    , rows = Nothing
    , cols = Nothing
    , disabled = False
    , required = False
    , valid = True
    , minLength = Nothing
    , maxLength = Nothing
    , additionalAttributes = []
    , onInput = Nothing
    , onChange = Nothing
    }


{-| Text area view function
-}
textArea : TextAreaConfig msg -> Html msg
textArea config =
    Html.node "mdc-text-field"
        (List.filterMap identity
            [ rootCs
            , noLabelCs config
            , outlinedCs config
            , fullwidthCs config
            , disabledCs config
            , valueProp config
            , disabledProp config
            , requiredProp config
            , validProp config
            , minLengthAttr config
            , maxLengthAttr config
            ]
            ++ config.additionalAttributes
        )
        (List.concat
            [ if config.fullwidth then
                [ inputElt config
                , notchedOutlineElt config
                ]

              else
                [ inputElt config
                , notchedOutlineElt config
                ]
            ]
        )


rootCs : Maybe (Html.Attribute msg)
rootCs =
    Just (class "mdc-text-field mdc-text-field--textarea")


outlinedCs : TextAreaConfig msg -> Maybe (Html.Attribute msg)
outlinedCs { outlined } =
    if outlined then
        Just (class "mdc-text-field--outlined")

    else
        Nothing


fullwidthCs : TextAreaConfig msg -> Maybe (Html.Attribute msg)
fullwidthCs { fullwidth } =
    if fullwidth then
        Just (class "mdc-text-field--fullwidth")

    else
        Nothing


disabledCs : TextAreaConfig msg -> Maybe (Html.Attribute msg)
disabledCs { disabled } =
    if disabled then
        Just (class "mdc-text-field--disabled")

    else
        Nothing


requiredProp : TextAreaConfig msg -> Maybe (Html.Attribute msg)
requiredProp { required } =
    Just (Html.Attributes.property "required" (Encode.bool required))


validProp : TextAreaConfig msg -> Maybe (Html.Attribute msg)
validProp { valid } =
    Just (Html.Attributes.property "valid" (Encode.bool valid))


minLengthProp : TextAreaConfig msg -> Maybe (Html.Attribute msg)
minLengthProp { minLength } =
    Just
        (Html.Attributes.property "minLength"
            (Encode.int (Maybe.withDefault -1 minLength))
        )


maxLengthProp : TextAreaConfig msg -> Maybe (Html.Attribute msg)
maxLengthProp { maxLength } =
    Just
        (Html.Attributes.property "maxLength"
            (Encode.int (Maybe.withDefault -1 maxLength))
        )


minLengthAttr : TextAreaConfig msg -> Maybe (Html.Attribute msg)
minLengthAttr { minLength } =
    Maybe.map (Html.Attributes.attribute "minLength" << String.fromInt) minLength


maxLengthAttr : TextAreaConfig msg -> Maybe (Html.Attribute msg)
maxLengthAttr { maxLength } =
    Maybe.map (Html.Attributes.attribute "maxLength" << String.fromInt) maxLength


valueProp : TextAreaConfig msg -> Maybe (Html.Attribute msg)
valueProp { value } =
    Just (Html.Attributes.property "value" (Encode.string value))


placeholderAttr : TextAreaConfig msg -> Maybe (Html.Attribute msg)
placeholderAttr { placeholder } =
    Maybe.map Html.Attributes.placeholder placeholder


inputHandler : TextAreaConfig msg -> Maybe (Html.Attribute msg)
inputHandler { onInput } =
    Maybe.map Html.Events.onInput onInput


changeHandler : TextAreaConfig msg -> Maybe (Html.Attribute msg)
changeHandler { onChange } =
    Maybe.map (\f -> Html.Events.on "change" (Decode.map f Html.Events.targetValue))
        onChange


inputElt : TextAreaConfig msg -> Html msg
inputElt config =
    Html.textarea
        (List.filterMap identity
            [ inputCs
            , ariaLabelAttr config
            , rowsAttr config
            , colsAttr config
            , placeholderAttr config
            , inputHandler config
            , changeHandler config
            , minLengthAttr config
            , maxLengthAttr config
            ]
        )
        []


inputCs : Maybe (Html.Attribute msg)
inputCs =
    Just (class "mdc-text-field__input")


rowsAttr : TextAreaConfig msg -> Maybe (Html.Attribute msg)
rowsAttr { rows } =
    Maybe.map Html.Attributes.rows rows


colsAttr : TextAreaConfig msg -> Maybe (Html.Attribute msg)
colsAttr { cols } =
    Maybe.map Html.Attributes.cols cols


ariaLabelAttr : TextAreaConfig msg -> Maybe (Html.Attribute msg)
ariaLabelAttr { fullwidth, placeholder, label } =
    if fullwidth then
        Maybe.map (Html.Attributes.attribute "aria-label") label

    else
        Nothing


disabledProp : TextAreaConfig msg -> Maybe (Html.Attribute msg)
disabledProp { disabled } =
    Just (Html.Attributes.property "disabled" (Encode.bool disabled))


labelElt : TextAreaConfig msg -> Html msg
labelElt { label, value } =
    case label of
        Just str ->
            Html.div
                (if value /= "" then
                    [ class "mdc-floating-label mdc-floating-label--float-above" ]

                 else
                    [ class "mdc-floating-label" ]
                )
                [ text str ]

        Nothing ->
            text ""


noLabelCs : TextAreaConfig msg -> Maybe (Html.Attribute msg)
noLabelCs { label } =
    if label == Nothing then
        Just (class "mdc-text-field--no-label")

    else
        Nothing


lineRippleElt : Html msg
lineRippleElt =
    Html.div [ class "mdc-line-ripple" ] []


notchedOutlineElt : TextAreaConfig msg -> Html msg
notchedOutlineElt config =
    Html.div [ class "mdc-notched-outline" ]
        [ notchedOutlineLeadingElt
        , notchedOutlineNotchElt config
        , notchedOutlineTrailingElt
        ]


notchedOutlineLeadingElt : Html msg
notchedOutlineLeadingElt =
    Html.div [ class "mdc-notched-outline__leading" ] []


notchedOutlineTrailingElt : Html msg
notchedOutlineTrailingElt =
    Html.div [ class "mdc-notched-outline__trailing" ] []


notchedOutlineNotchElt : TextAreaConfig msg -> Html msg
notchedOutlineNotchElt config =
    Html.div [ class "mdc-notched-outline__notch" ] [ labelElt config ]


{-| Character counter view function
-}
characterCounter : List (Html.Attribute msg) -> Html msg
characterCounter additionalAttributes =
    Html.div (characterCounterCs :: additionalAttributes) []


characterCounterCs : Html.Attribute msg
characterCounterCs =
    class "mdc-text-field-character-counter"
