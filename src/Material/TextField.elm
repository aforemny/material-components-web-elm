module Material.TextField exposing
    ( Config, config
    , setOnInput
    , setOnChange
    , setLabel
    , setOutlined
    , setFullwidth
    , setValue
    , setPlaceholder
    , setDisabled
    , setRequired
    , setValid
    , setMinLength
    , setMaxLength
    , setPattern
    , setType
    , setMin
    , setMax
    , setStep
    , setLeadingIcon
    , setTrailingIcon
    , setAdditionalAttributes
    , textField
    , Icon, icon
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

  - [Demo: Text Fields](https://aforemny.github.io/material-components-web-elm/#text-field)
  - [Material Design Guidelines: Menus](https://material.io/go/design-menus)
  - [MDC Web: Menu](https://github.com/material-components/material-components-web/tree/master/packages/mdc-menu)
  - [Sass Mixins (MDC Web)](https://github.com/material-components/material-components-web/tree/master/packages/mdc-menu#sass-mixins)


# Basic Usage

    import Material.TextField as TextField

    type Msg
        = ValueChanged String

    main =
        TextField.textField
            (TextField.config
                |> TextField.setLabel "My text field"
                |> TextField.setValue "hello world"
                |> TextField.setOnInput ValueChanged
            )


# Configuration

@docs Config, config


## Configuration Options

@docs setOnInput
@docs setOnChange
@docs setLabel
@docs setOutlined
@docs setFullwidth
@docs setValue
@docs setPlaceholder
@docs setDisabled
@docs setRequired
@docs setValid
@docs setMinLength
@docs setMaxLength
@docs setPattern
@docs setType
@docs setMin
@docs setMax
@docs setStep
@docs setLeadingIcon
@docs setTrailingIcon
@docs setAdditionalAttributes


# Text Field

@docs textField


# Full Width Text Field

To make a text field span all of its available width, use its `setFullwidth`
configuration option.

    TextField.textField
        (TextField.config
            |> TextField.setFullWidth
        )

Full width text fields do not support `label` and will ignore this
configuration option. You may use `setPlaceholder` or provide an extraneous
label for a full width text field.

Full width text fields do not support `setOutlined` and will ignore this
configuration field.


# Disabled Text Field

To disable a text field use its `setDisabled` configuration option.

    TextField.textField
        (TextField.config
            |> TextField.setDisabled
        )


# Password Text Field

To mark a text field as an input for entering a passwort, use its `setType`
configuration option to specify `"password"`.

    TextField.textField
        (TextField.config
            |> TextField.setType "password"
        )

Note: Other input types besides `"password"` may or may not be supported.


# Required Text Field

To mark a text field as required, use its `setRequired` configuration option.

    TextField.textField
        (TextField.config
            |> TextField.setRequired
        )


# Invalid Text Field

To mark a text field as invalid, use its `setValid` configuration option.

    TextField.textField
        (TextField.config
            |> TextField.setValid
        )


# Outlined Text Field

Text fields may have a visible outlined around them by using their
`setOutlined` configuration option.

    TextField.textField
        (TextField.config
            |> TextField.setOutlined
        )

Note that this does not have any effect for fullwidth text fields.


# Text Field with Leading Icon

To have a text field display a leading icon, use its `setLeadingIcon`
configuration option to specify a `TextFieldIcon`.

    TextField.textField
        (TextField.config
            |> TextField.setLeadingIcon
                (TextField.icon Icon.config "wifi")
        )

@docs Icon, icon


# Text Field with Trailing Icon

To have a text field display a trailing icon, use its `setTrailingIcon`
configuration option to specify a `TextFieldIcon`.

    TextField.textField
        (TextField.config
            |> TextField.setTrailingIcon
                (TextField.icon Icon.config "clear")
        )


# Text Field with Character Counter

To have a text field display a character counter, use its `setMaxLength`
configuration option, and also add a `HelperText.characterCounter` as a child
of `HelperText.helperLine`.

    [ TextField.textField
        (TextField.config
            |> TextField.setMaxLength 18
        )
    , HelperText.helperLine []
        [ HelperText.characterCounter [] ]
    ]

-}

import Html exposing (Html, text)
import Html.Attributes exposing (class)
import Html.Events
import Json.Decode as Decode
import Json.Encode as Encode
import Material.Icon as Icon


{-| Configuration of a text field
-}
type Config msg
    = Config
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
        , leadingIcon : Icon msg
        , trailingIcon : Icon msg
        , additionalAttributes : List (Html.Attribute msg)
        , onInput : Maybe (String -> msg)
        , onChange : Maybe (String -> msg)
        }


{-| Text field trailing or leading icon -
-}
type Icon msg
    = NoIcon
    | Icon (Html msg)


{-| Default configuration of a text field
-}
config : Config msg
config =
    Config
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


{-| Set a text field's label
-}
setLabel : String -> Config msg -> Config msg
setLabel label (Config config_) =
    Config { config_ | label = Just label }


{-| Set a text field to be outlined
-}
setOutlined : Config msg -> Config msg
setOutlined (Config config_) =
    Config { config_ | outlined = True }


{-| Set a text field to be fullwidth
-}
setFullwidth : Config msg -> Config msg
setFullwidth (Config config_) =
    Config { config_ | fullwidth = True }


{-| Set a text field's value
-}
setValue : String -> Config msg -> Config msg
setValue value (Config config_) =
    Config { config_ | value = value }


{-| Set a text field's placeholder
-}
setPlaceholder : String -> Config msg -> Config msg
setPlaceholder placeholder (Config config_) =
    Config { config_ | placeholder = Just placeholder }


{-| Set a text field to be disabled
-}
setDisabled : Config msg -> Config msg
setDisabled (Config config_) =
    Config { config_ | disabled = True }


{-| Set a text field to be required
-}
setRequired : Config msg -> Config msg
setRequired (Config config_) =
    Config { config_ | required = True }


{-| Set a text field to be valid
-}
setValid : Config msg -> Config msg
setValid (Config config_) =
    Config { config_ | valid = True }


{-| Set a text field's minimum length
-}
setMinLength : Int -> Config msg -> Config msg
setMinLength minLength (Config config_) =
    Config { config_ | minLength = Just minLength }


{-| Set a text field's maximum length
-}
setMaxLength : Int -> Config msg -> Config msg
setMaxLength maxLength (Config config_) =
    Config { config_ | maxLength = Just maxLength }


{-| Set a text field's pattern
-}
setPattern : String -> Config msg -> Config msg
setPattern pattern (Config config_) =
    Config { config_ | pattern = Just pattern }


{-| Set a text field's type
-}
setType : String -> Config msg -> Config msg
setType type_ (Config config_) =
    Config { config_ | type_ = type_ }


{-| Set a text field's minimum value
-}
setMin : Int -> Config msg -> Config msg
setMin min (Config config_) =
    Config { config_ | min = Just min }


{-| Set a text field's maximum value
-}
setMax : Int -> Config msg -> Config msg
setMax max (Config config_) =
    Config { config_ | max = Just max }


{-| Set a text field's step value
-}
setStep : Int -> Config msg -> Config msg
setStep step (Config config_) =
    Config { config_ | step = Just step }


{-| Set a text field's leading icon
-}
setLeadingIcon : Icon msg -> Config msg -> Config msg
setLeadingIcon leadingIcon (Config config_) =
    Config { config_ | leadingIcon = leadingIcon }


{-| Set a text field's trailing icon
-}
setTrailingIcon : Icon msg -> Config msg -> Config msg
setTrailingIcon trailingIcon (Config config_) =
    Config { config_ | trailingIcon = trailingIcon }


{-| Specify additional attributes
-}
setAdditionalAttributes : List (Html.Attribute msg) -> Config msg -> Config msg
setAdditionalAttributes additionalAttributes (Config config_) =
    Config { config_ | additionalAttributes = additionalAttributes }


{-| Specify a message when the user changes the value inside the text field
-}
setOnInput : (String -> msg) -> Config msg -> Config msg
setOnInput onInput (Config config_) =
    Config { config_ | onInput = Just onInput }


{-| Specify a message when the user confirms a changed value inside the text
field
-}
setOnChange : (String -> msg) -> Config msg -> Config msg
setOnChange onChange (Config config_) =
    Config { config_ | onChange = Just onChange }


{-| Text field view function
-}
textField : Config msg -> Html msg
textField ((Config { additionalAttributes, fullwidth, outlined }) as config_) =
    Html.node "mdc-text-field"
        (List.filterMap identity
            [ rootCs
            , noLabelCs config_
            , outlinedCs config_
            , fullwidthCs config_
            , disabledCs config_
            , withLeadingIconCs config_
            , withTrailingIconCs config_
            , valueProp config_
            , disabledProp config_
            , requiredProp config_
            , validProp config_
            , patternProp config_
            , minLengthProp config_
            , maxLengthProp config_
            , minProp config_
            , maxProp config_
            , stepProp config_
            ]
            ++ additionalAttributes
        )
        (List.concat
            [ leadingIconElt config_
            , if fullwidth then
                if outlined then
                    [ inputElt config_
                    , notchedOutlineElt config_
                    ]

                else
                    [ inputElt config_
                    , lineRippleElt
                    ]

              else if outlined then
                [ inputElt config_
                , notchedOutlineElt config_
                ]

              else
                [ inputElt config_
                , labelElt config_
                , lineRippleElt
                ]
            , trailingIconElt config_
            ]
        )


{-| A text field's icon, either leading or trailing
-}
icon : List (Html.Attribute msg) -> String -> Icon msg
icon additionalAttributes iconName =
    Icon (Icon.icon (class "mdc-text-field__icon" :: additionalAttributes) iconName)


rootCs : Maybe (Html.Attribute msg)
rootCs =
    Just (class "mdc-text-field")


outlinedCs : Config msg -> Maybe (Html.Attribute msg)
outlinedCs (Config { outlined }) =
    if outlined then
        Just (class "mdc-text-field--outlined")

    else
        Nothing


fullwidthCs : Config msg -> Maybe (Html.Attribute msg)
fullwidthCs (Config { fullwidth }) =
    if fullwidth then
        Just (class "mdc-text-field--fullwidth")

    else
        Nothing


disabledCs : Config msg -> Maybe (Html.Attribute msg)
disabledCs (Config { disabled }) =
    if disabled then
        Just (class "mdc-text-field--disabled")

    else
        Nothing


withLeadingIconCs : Config msg -> Maybe (Html.Attribute msg)
withLeadingIconCs (Config { leadingIcon }) =
    if leadingIcon /= NoIcon then
        Just (class "mdc-text-field--with-leading-icon")

    else
        Nothing


withTrailingIconCs : Config msg -> Maybe (Html.Attribute msg)
withTrailingIconCs (Config { trailingIcon }) =
    if trailingIcon /= NoIcon then
        Just (class "mdc-text-field--with-trailing-icon")

    else
        Nothing


requiredProp : Config msg -> Maybe (Html.Attribute msg)
requiredProp (Config { required }) =
    Just (Html.Attributes.property "required" (Encode.bool required))


validProp : Config msg -> Maybe (Html.Attribute msg)
validProp (Config { valid }) =
    Just (Html.Attributes.property "valid" (Encode.bool valid))


minLengthProp : Config msg -> Maybe (Html.Attribute msg)
minLengthProp (Config { minLength }) =
    Just
        (Html.Attributes.property "minLength"
            (Encode.int (Maybe.withDefault -1 minLength))
        )


maxLengthProp : Config msg -> Maybe (Html.Attribute msg)
maxLengthProp (Config { maxLength }) =
    Just
        (Html.Attributes.property "maxLength"
            (Encode.int (Maybe.withDefault -1 maxLength))
        )


minLengthAttr : Config msg -> Maybe (Html.Attribute msg)
minLengthAttr (Config { minLength }) =
    Maybe.map (Html.Attributes.attribute "minLength" << String.fromInt) minLength


maxLengthAttr : Config msg -> Maybe (Html.Attribute msg)
maxLengthAttr (Config { maxLength }) =
    Maybe.map (Html.Attributes.attribute "maxLength" << String.fromInt) maxLength


minProp : Config msg -> Maybe (Html.Attribute msg)
minProp (Config { min }) =
    Just
        (Html.Attributes.property "min"
            (Encode.string (Maybe.withDefault "" (Maybe.map String.fromInt min)))
        )


maxProp : Config msg -> Maybe (Html.Attribute msg)
maxProp (Config { max }) =
    Just
        (Html.Attributes.property "max"
            (Encode.string (Maybe.withDefault "" (Maybe.map String.fromInt max)))
        )


stepProp : Config msg -> Maybe (Html.Attribute msg)
stepProp (Config { step }) =
    Just
        (Html.Attributes.property "step"
            (Encode.string (Maybe.withDefault "" (Maybe.map String.fromInt step)))
        )


valueProp : Config msg -> Maybe (Html.Attribute msg)
valueProp (Config { value }) =
    Just (Html.Attributes.property "value" (Encode.string value))


placeholderAttr : Config msg -> Maybe (Html.Attribute msg)
placeholderAttr (Config { placeholder }) =
    Maybe.map Html.Attributes.placeholder placeholder


leadingIconElt : Config msg -> List (Html msg)
leadingIconElt (Config { leadingIcon }) =
    case leadingIcon of
        NoIcon ->
            []

        Icon html ->
            [ html ]


trailingIconElt : Config msg -> List (Html msg)
trailingIconElt (Config { trailingIcon }) =
    case trailingIcon of
        NoIcon ->
            []

        Icon html ->
            [ html ]


inputHandler : Config msg -> Maybe (Html.Attribute msg)
inputHandler (Config { onInput }) =
    Maybe.map Html.Events.onInput onInput


changeHandler : Config msg -> Maybe (Html.Attribute msg)
changeHandler (Config { onChange }) =
    Maybe.map (\f -> Html.Events.on "change" (Decode.map f Html.Events.targetValue))
        onChange


inputElt : Config msg -> Html msg
inputElt config_ =
    Html.input
        (List.filterMap identity
            [ inputCs
            , typeAttr config_
            , ariaLabelAttr config_
            , placeholderAttr config_
            , inputHandler config_
            , changeHandler config_
            , minLengthAttr config_
            , maxLengthAttr config_
            ]
        )
        []


inputCs : Maybe (Html.Attribute msg)
inputCs =
    Just (class "mdc-text-field__input")


patternProp : Config msg -> Maybe (Html.Attribute msg)
patternProp (Config { pattern }) =
    Just
        (Html.Attributes.property "pattern"
            (Encode.string (Maybe.withDefault "" pattern))
        )


typeAttr : Config msg -> Maybe (Html.Attribute msg)
typeAttr (Config { type_ }) =
    Just (Html.Attributes.type_ type_)


ariaLabelAttr : Config msg -> Maybe (Html.Attribute msg)
ariaLabelAttr (Config { fullwidth, placeholder, label }) =
    if fullwidth then
        Maybe.map (Html.Attributes.attribute "aria-label") label

    else
        Nothing


disabledProp : Config msg -> Maybe (Html.Attribute msg)
disabledProp (Config { disabled }) =
    Just (Html.Attributes.property "disabled" (Encode.bool disabled))


labelElt : Config msg -> Html msg
labelElt (Config { label, value }) =
    let
        floatingLabelCs =
            "mdc-floating-label"

        floatingLabelFloatAboveCs =
            "mdc-floating-label--float-above"
    in
    case label of
        Just str ->
            Html.div
                [ if value /= "" then
                    class (floatingLabelCs ++ " " ++ floatingLabelFloatAboveCs)

                  else
                    class floatingLabelCs
                , Html.Attributes.property "foucClassNames"
                    (Encode.list Encode.string [ floatingLabelFloatAboveCs ])
                ]
                [ text str ]

        Nothing ->
            text ""


noLabelCs : Config msg -> Maybe (Html.Attribute msg)
noLabelCs (Config { label }) =
    if label == Nothing then
        Just (class "mdc-text-field--no-label")

    else
        Nothing


lineRippleElt : Html msg
lineRippleElt =
    Html.div [ class "mdc-line-ripple" ] []


notchedOutlineElt : Config msg -> Html msg
notchedOutlineElt config_ =
    Html.div [ class "mdc-notched-outline" ]
        [ notchedOutlineLeadingElt
        , notchedOutlineNotchElt config_
        , notchedOutlineTrailingElt
        ]


notchedOutlineLeadingElt : Html msg
notchedOutlineLeadingElt =
    Html.div [ class "mdc-notched-outline__leading" ] []


notchedOutlineTrailingElt : Html msg
notchedOutlineTrailingElt =
    Html.div [ class "mdc-notched-outline__trailing" ] []


notchedOutlineNotchElt : Config msg -> Html msg
notchedOutlineNotchElt config_ =
    Html.div [ class "mdc-notched-outline__notch" ] [ labelElt config_ ]
