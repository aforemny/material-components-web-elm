module Material.TextField exposing
    ( textField, textFieldConfig, TextFieldConfig
    , textFieldIcon
    )

{-| Text fields allow users to input, edit, and select text.


# Table of Contents

  - [Resources](#resources)
  - [Basic Usage](#basic-usage)
  - [Full Width Text Field](#full-width-text-field)
  - [Multiline Text Field](#multiline-text-field)
  - [Disabled Text Field](#disabled-text-field)
  - [Password Text Field](#password-text-field)
  - [Required Text Field](#disabled-text-field)
  - [Invalid Text Field](#disabled-text-field)
  - [Outlined Text Field](#outlined-text-field)
  - [Text Field with Leading Icon](#text-field-with-leading-icon)
  - [Text Field with Trailing Icon](#text-field-with-trailing-icon)
  - [Text Field with Character Counter](#text-field-with-character-counter)


# Resources

  - [Demo: Text Fields](https://aforemny.github.io/material-components-web-elm/#text-fields)
  - [Material Design Guidelines: Menus](https://material.io/go/design-menus)
  - [MDC Web: Menu](https://github.com/material-components/material-components-web/tree/master/packages/mdc-menu)
  - [Sass Mixins (MDC Web)](https://github.com/material-components/material-components-web/tree/master/packages/mdc-menu#sass-mixins)


# Basic Usage

    import Material.TextField
        exposing
            ( textField
            , textFieldConfig
            )

    type Msg
        = ValueChanged String

    main =
        textField
            { textFieldConfig
                | label = "My text field"
                , value = Just "hello world"
                , onInput = Just ValueChanged
            }

@docs textField, textFieldConfig, TextFieldConfig


# Full Width Text Field

To make a text field span all of its available width, set its `fullwidth`
configuration field to `True`.

    textField { textFieldConfig | fullWidth = True }

Full width text fields do not support `label` and will ignore this
configuration field. You may set `placeholder` or provide an extraneous label
for a full width text field.

Full width text fields do not support `outlined` and will ignore this
configuration field.


# Disabled Text Field

To disable a text field set its `disabled` configuration field to `True`.

    textField { textFieldConfig | disabled = True }


# Password Text Field

To mark a text field as an input for entering a passwort, set its `type_`
configuration field to the String `"password"`.

    textField { textFieldConfig | type_ = "password" }

Note: Other input types besides password may or may not be supported.


# Required Text Field

To mark a text field as required, set its `required` configuration field to
`True`.

    textField { textFieldConfig | required = True }


# Invalid Text Field

To mark a text field as invalid, set its `valid` configuration field to
`False`.

    textField { textFieldConfig | valid = False }


# Outlined Text Field

Text fields may have a visible outlined around them by setting their `outlined`
configuration field to `True`.

    textField { textFieldConfig | outlined = True }

Note that this does not have any effect for fullwidth text fields.


# Text Field with Leading Icon

To have a text field display a leading icon, set its `leadingIcon`
configuration field to a `TextFieldIcon`.

    textField
        { textFieldConfig
            | leadingIcon = textFieldIcon iconConfig "wifi"
        }

@docs textFieldIcon


# Text Field with Trailing Icon

To have a text field display a trailing icon, set its `trailingIcon`
configuration field to a `TextFieldIcon`.

    textField
        { textFieldConfig
            | trailingIcon = textFieldIcon iconConfig "clear"
        }


# Text Field with Character Counter

To have a text field display a character counter, set its `maxLength`
configuration field, and also add a `characterCounter` as a child of
`helperLine`.

    [ textField
        { textFieldConfig
            | maxLength = Just 18
        }
    , helperLine [] [ characterCounter [] ]
    ]

-}

import Html exposing (Html, text)
import Html.Attributes exposing (class)
import Html.Events
import Json.Decode as Decode
import Json.Encode as Encode
import Material.Icon exposing (IconConfig, icon, iconConfig)


{-| Configuration of a text field
-}
type alias TextFieldConfig msg =
    { label : Maybe String
    , outlined : Bool
    , fullwidth : Bool
    , value : String
    , placeholder : Maybe String
    , disabled : Bool
    , required : Bool
    , valid : Bool
    , minLength : Maybe Int
    , maxLength : Maybe Int
    , pattern : Maybe String
    , type_ : String
    , min : Maybe Int
    , max : Maybe Int
    , step : Maybe Int
    , leadingIcon : TextFieldIcon msg
    , trailingIcon : TextFieldIcon msg
    , additionalAttributes : List (Html.Attribute msg)
    , onInput : Maybe (String -> msg)
    , onChange : Maybe (String -> msg)
    }


type TextFieldIcon msg
    = NoIcon
    | Icon (Html msg)


{-| Default configuration of a text field
-}
textFieldConfig : TextFieldConfig msg
textFieldConfig =
    { label = Nothing
    , outlined = False
    , fullwidth = False
    , value = ""
    , placeholder = Nothing
    , disabled = False
    , required = False
    , valid = True
    , minLength = Nothing
    , maxLength = Nothing
    , pattern = Nothing
    , type_ = "text"
    , min = Nothing
    , max = Nothing
    , step = Nothing
    , leadingIcon = NoIcon
    , trailingIcon = NoIcon
    , additionalAttributes = []
    , onInput = Nothing
    , onChange = Nothing
    }


{-| Text field view function
-}
textField : TextFieldConfig msg -> Html msg
textField config =
    Html.node "mdc-text-field"
        (List.filterMap identity
            [ rootCs
            , noLabelCs config
            , outlinedCs config
            , fullwidthCs config
            , disabledCs config
            , withLeadingIconCs config
            , withTrailingIconCs config
            , valueProp config
            , disabledProp config
            , requiredProp config
            , validProp config
            , patternProp config
            , minLengthProp config
            , maxLengthProp config
            , minProp config
            , maxProp config
            , stepProp config
            ]
            ++ config.additionalAttributes
        )
        (List.concat
            [ leadingIconElt config
            , if config.fullwidth then
                if config.outlined then
                    [ inputElt config
                    , notchedOutlineElt config
                    ]

                else
                    [ inputElt config
                    , lineRippleElt
                    ]

              else if config.outlined then
                [ inputElt config
                , notchedOutlineElt config
                ]

              else
                [ inputElt config
                , labelElt config
                , lineRippleElt
                ]
            , trailingIconElt config
            ]
        )


{-| A text field's icon, either leading or trailing
-}
textFieldIcon : IconConfig msg -> String -> TextFieldIcon msg
textFieldIcon iconConfig iconName =
    Icon
        (icon
            { iconConfig
                | additionalAttributes =
                    class "mdc-text-field__icon" :: iconConfig.additionalAttributes
            }
            iconName
        )


rootCs : Maybe (Html.Attribute msg)
rootCs =
    Just (class "mdc-text-field")


outlinedCs : TextFieldConfig msg -> Maybe (Html.Attribute msg)
outlinedCs { outlined } =
    if outlined then
        Just (class "mdc-text-field--outlined")

    else
        Nothing


fullwidthCs : TextFieldConfig msg -> Maybe (Html.Attribute msg)
fullwidthCs { fullwidth } =
    if fullwidth then
        Just (class "mdc-text-field--fullwidth")

    else
        Nothing


disabledCs : TextFieldConfig msg -> Maybe (Html.Attribute msg)
disabledCs { disabled } =
    if disabled then
        Just (class "mdc-text-field--disabled")

    else
        Nothing


withLeadingIconCs : TextFieldConfig msg -> Maybe (Html.Attribute msg)
withLeadingIconCs { leadingIcon } =
    if leadingIcon /= NoIcon then
        Just (class "mdc-text-field--with-leading-icon")

    else
        Nothing


withTrailingIconCs : TextFieldConfig msg -> Maybe (Html.Attribute msg)
withTrailingIconCs { trailingIcon } =
    if trailingIcon /= NoIcon then
        Just (class "mdc-text-field--with-trailing-icon")

    else
        Nothing


requiredProp : TextFieldConfig msg -> Maybe (Html.Attribute msg)
requiredProp { required } =
    Just (Html.Attributes.property "required" (Encode.bool required))


validProp : TextFieldConfig msg -> Maybe (Html.Attribute msg)
validProp { valid } =
    Just (Html.Attributes.property "valid" (Encode.bool valid))


minLengthProp : TextFieldConfig msg -> Maybe (Html.Attribute msg)
minLengthProp { minLength } =
    Just
        (Html.Attributes.property "minLength"
            (Encode.int (Maybe.withDefault -1 minLength))
        )


maxLengthProp : TextFieldConfig msg -> Maybe (Html.Attribute msg)
maxLengthProp { maxLength } =
    Just
        (Html.Attributes.property "maxLength"
            (Encode.int (Maybe.withDefault -1 maxLength))
        )


minLengthAttr : TextFieldConfig msg -> Maybe (Html.Attribute msg)
minLengthAttr { minLength } =
    Maybe.map (Html.Attributes.attribute "minLength" << String.fromInt) minLength


maxLengthAttr : TextFieldConfig msg -> Maybe (Html.Attribute msg)
maxLengthAttr { maxLength } =
    Maybe.map (Html.Attributes.attribute "maxLength" << String.fromInt) maxLength


minProp : TextFieldConfig msg -> Maybe (Html.Attribute msg)
minProp { min } =
    Just
        (Html.Attributes.property "min"
            (Encode.string (Maybe.withDefault "" (Maybe.map String.fromInt min)))
        )


maxProp : TextFieldConfig msg -> Maybe (Html.Attribute msg)
maxProp { max } =
    Just
        (Html.Attributes.property "max"
            (Encode.string (Maybe.withDefault "" (Maybe.map String.fromInt max)))
        )


stepProp : TextFieldConfig msg -> Maybe (Html.Attribute msg)
stepProp { step } =
    Just
        (Html.Attributes.property "step"
            (Encode.string (Maybe.withDefault "" (Maybe.map String.fromInt step)))
        )


valueProp : TextFieldConfig msg -> Maybe (Html.Attribute msg)
valueProp { value } =
    Just (Html.Attributes.property "value" (Encode.string value))


placeholderAttr : TextFieldConfig msg -> Maybe (Html.Attribute msg)
placeholderAttr { placeholder } =
    Maybe.map Html.Attributes.placeholder placeholder


leadingIconElt : TextFieldConfig msg -> List (Html msg)
leadingIconElt { leadingIcon } =
    case leadingIcon of
        NoIcon ->
            []

        Icon html ->
            [ html ]


trailingIconElt : TextFieldConfig msg -> List (Html msg)
trailingIconElt { trailingIcon } =
    case trailingIcon of
        NoIcon ->
            []

        Icon html ->
            [ html ]


inputHandler : TextFieldConfig msg -> Maybe (Html.Attribute msg)
inputHandler { onInput } =
    Maybe.map Html.Events.onInput onInput


changeHandler : TextFieldConfig msg -> Maybe (Html.Attribute msg)
changeHandler { onChange } =
    Maybe.map (\f -> Html.Events.on "change" (Decode.map f Html.Events.targetValue))
        onChange


inputElt : TextFieldConfig msg -> Html msg
inputElt config =
    Html.input
        (List.filterMap identity
            [ inputCs
            , typeAttr config
            , ariaLabelAttr config
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


patternProp : TextFieldConfig msg -> Maybe (Html.Attribute msg)
patternProp { pattern } =
    Just
        (Html.Attributes.property "pattern"
            (Encode.string (Maybe.withDefault "" pattern))
        )


typeAttr : TextFieldConfig msg -> Maybe (Html.Attribute msg)
typeAttr { type_ } =
    Just (Html.Attributes.type_ type_)


ariaLabelAttr : TextFieldConfig msg -> Maybe (Html.Attribute msg)
ariaLabelAttr { fullwidth, placeholder, label } =
    if fullwidth then
        Maybe.map (Html.Attributes.attribute "aria-label") label

    else
        Nothing


disabledProp : TextFieldConfig msg -> Maybe (Html.Attribute msg)
disabledProp { disabled } =
    Just (Html.Attributes.property "disabled" (Encode.bool disabled))


labelElt : TextFieldConfig msg -> Html msg
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


noLabelCs : TextFieldConfig msg -> Maybe (Html.Attribute msg)
noLabelCs { label } =
    if label == Nothing then
        Just (class "mdc-text-field--no-label")

    else
        Nothing


lineRippleElt : Html msg
lineRippleElt =
    Html.div [ class "mdc-line-ripple" ] []


notchedOutlineElt : TextFieldConfig msg -> Html msg
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


notchedOutlineNotchElt : TextFieldConfig msg -> Html msg
notchedOutlineNotchElt config =
    Html.div [ class "mdc-notched-outline__notch" ] [ labelElt config ]
