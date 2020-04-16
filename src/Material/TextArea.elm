module Material.TextArea exposing
    ( Config, config
    , setOnInput
    , setOnChange
    , setLabel
    , setOutlined
    , setFullwidth
    , setValue
    , setPlaceholder
    , setRows
    , setCols
    , setDisabled
    , setRequired
    , setValid
    , setMinLength
    , setMaxLength
    , setAdditionalAttributes
    , textArea
    )

{-| Text areas allow users to input, edit, and select multiline text.


# Table of Contents

  - [Resources](#resources)
  - [Basic Usage](#basic-usage)
  - [Full Width Text Area](#full-width-text-area)
  - [Disabled Text Area](#disabled-text-area)
  - [Required Text Area](#required-text-area)
  - [Invalid Text Area](#invalid-text-area)
  - [Outlined Text Area](#outlined-text-area)
  - [Text Area with Character Counter](#text-area-with-character-counter)


# Resources

  - [Demo: Text Areas](https://aforemny.github.io/material-components-web-elm/#text-field)
  - [Material Design Guidelines: Menus](https://material.io/go/design-menus)
  - [MDC Web: Menu](https://github.com/material-components/material-components-web/tree/master/packages/mdc-menu)
  - [Sass Mixins (MDC Web)](https://github.com/material-components/material-components-web/tree/master/packages/mdc-menu#sass-mixins)


# Basic Usage

    import Material.TextArea as TextArea

    type Msg
        = ValueChanged String

    main =
        TextArea.textArea
            (TextArea.config
                |> TextArea.setLabel "My text area"
                |> TextArea.setValue "hello world"
                |> TextArea.setOnInput ValueChanged
                |> TextArea.setRows 4
                |> TextArea.setCols 20
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
@docs setRows
@docs setCols
@docs setDisabled
@docs setRequired
@docs setValid
@docs setMinLength
@docs setMaxLength
@docs setAdditionalAttributes


# Text Area

@docs textArea


# Full Width Text Area

To make a text area span all of its available width, use its `setFullwidth`
configuration option.

    TextArea.textArea
        (TextArea.config
            |> TextArea.setFullWidth
        )

Full width text areas do not support `setLabel` and will ignore this
configuration option. You may use `setPlaceholder` or provide an extraneous
label for a full width text area.

Full width text areas do not support `setOutlined` and will ignore this
configuration option.


# Disabled Text Area

To disable a text area use its `setDisabled` configuration option.

    TextArea.textArea
        (TextArea.config
            |> TextArea.setDisabled
        )


# Required Text Area

To mark a text area as required, use its `setRequired` configuration option.

    TextArea.textArea
        (TextArea.config
            |> TextArea.setRequired
        )


# Invalid Text Area

To mark a text area as invalid, use its `setValid` configuration option.

    TextArea.textArea
        (TextArea.config
            |> TextArea.setValid
        )


# Outlined Text Area

Text areas may have a visible outlined around them by using their `setOutlined`
configuration option.

    TextArea.textArea
        (TextArea.config
            |> TextArea.setOutlined
        )

Note that this does not have any effect for fullwidth text areas.


# Text Area with Character Counter

To have a text area display a character counter, use its `setMaxLength`
configuration option, and also add a `HelperText.characterCounter` as a child
of `HelperText.helperLine`.

    [ TextArea.textArea
        (TextArea.config
            |> TextArea.setMaxLength 18
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


{-| Configuration of a text area
-}
type Config msg
    = Config
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


{-| Default configuration of a text area
-}
config : Config msg
config =
    Config
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


{-| Set a text area's label
-}
setLabel : String -> Config msg -> Config msg
setLabel label (Config config_) =
    Config { config_ | label = Just label }


{-| Set a text area to be outlined
-}
setOutlined : Config msg -> Config msg
setOutlined (Config config_) =
    Config { config_ | outlined = True }


{-| Set a text area to be fullwidth
-}
setFullwidth : Config msg -> Config msg
setFullwidth (Config config_) =
    Config { config_ | fullwidth = True }


{-| Set a text area's value
-}
setValue : String -> Config msg -> Config msg
setValue value (Config config_) =
    Config { config_ | value = value }


{-| Set a text area's placeholder
-}
setPlaceholder : String -> Config msg -> Config msg
setPlaceholder placeholder (Config config_) =
    Config { config_ | placeholder = Just placeholder }


{-| Set a text area's number of rows
-}
setRows : Int -> Config msg -> Config msg
setRows rows (Config config_) =
    Config { config_ | rows = Just rows }


{-| Set a text area's number of columns
-}
setCols : Int -> Config msg -> Config msg
setCols cols (Config config_) =
    Config { config_ | cols = Just cols }


{-| Set a text area to be disabled
-}
setDisabled : Config msg -> Config msg
setDisabled (Config config_) =
    Config { config_ | disabled = True }


{-| Set a text area to be required
-}
setRequired : Config msg -> Config msg
setRequired (Config config_) =
    Config { config_ | required = True }


{-| Set a text area to be valid
-}
setValid : Config msg -> Config msg
setValid (Config config_) =
    Config { config_ | valid = True }


{-| Set a text area's minimum length
-}
setMinLength : Int -> Config msg -> Config msg
setMinLength minLength (Config config_) =
    Config { config_ | minLength = Just minLength }


{-| Set a text area's maximum length
-}
setMaxLength : Int -> Config msg -> Config msg
setMaxLength maxLength (Config config_) =
    Config { config_ | maxLength = Just maxLength }


{-| Specify additional attributes
-}
setAdditionalAttributes : List (Html.Attribute msg) -> Config msg -> Config msg
setAdditionalAttributes additionalAttributes (Config config_) =
    Config { config_ | additionalAttributes = additionalAttributes }


{-| Specify a message when the user changes the value inside the text area
-}
setOnInput : (String -> msg) -> Config msg -> Config msg
setOnInput onInput (Config config_) =
    Config { config_ | onInput = Just onInput }


{-| Specify a message when the user confirms a changed value inside the text
area
-}
setOnChange : (String -> msg) -> Config msg -> Config msg
setOnChange onChange (Config config_) =
    Config { config_ | onChange = Just onChange }


{-| Text area view function
-}
textArea : Config msg -> Html msg
textArea ((Config { additionalAttributes, fullwidth }) as config_) =
    Html.node "mdc-text-field"
        (List.filterMap identity
            [ rootCs
            , noLabelCs config_
            , outlinedCs config_
            , fullwidthCs config_
            , disabledCs config_
            , valueProp config_
            , disabledProp config_
            , requiredProp config_
            , validProp config_
            , minLengthAttr config_
            , maxLengthAttr config_
            ]
            ++ additionalAttributes
        )
        (List.concat
            [ if fullwidth then
                [ inputElt config_
                , notchedOutlineElt config_
                ]

              else
                [ inputElt config_
                , notchedOutlineElt config_
                ]
            ]
        )


rootCs : Maybe (Html.Attribute msg)
rootCs =
    Just (class "mdc-text-field mdc-text-field--textarea")


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


valueProp : Config msg -> Maybe (Html.Attribute msg)
valueProp (Config { value }) =
    Just (Html.Attributes.property "value" (Encode.string value))


placeholderAttr : Config msg -> Maybe (Html.Attribute msg)
placeholderAttr (Config { placeholder }) =
    Maybe.map Html.Attributes.placeholder placeholder


inputHandler : Config msg -> Maybe (Html.Attribute msg)
inputHandler (Config { onInput }) =
    Maybe.map Html.Events.onInput onInput


changeHandler : Config msg -> Maybe (Html.Attribute msg)
changeHandler (Config { onChange }) =
    Maybe.map (\f -> Html.Events.on "change" (Decode.map f Html.Events.targetValue))
        onChange


inputElt : Config msg -> Html msg
inputElt config_ =
    Html.textarea
        (List.filterMap identity
            [ inputCs
            , ariaLabelAttr config_
            , rowsAttr config_
            , colsAttr config_
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


rowsAttr : Config msg -> Maybe (Html.Attribute msg)
rowsAttr (Config { rows }) =
    Maybe.map Html.Attributes.rows rows


colsAttr : Config msg -> Maybe (Html.Attribute msg)
colsAttr (Config { cols }) =
    Maybe.map Html.Attributes.cols cols


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
