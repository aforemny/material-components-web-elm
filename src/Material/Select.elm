module Material.Select exposing
    ( Config, config
    , setOnChange
    , setLabel
    , setValue
    , setDisabled
    , setRequired
    , setValid
    , setAttributes
    , filled
    , outlined
    )

{-| Select provides a single-option select menus.

This module concerns the container select. If you are looking for information
about select options, refer to
[Material.Select.Option](Material-Select-Option).


# Table of Contents

  - [Resources](#resources)
  - [Basic Usage](#basic-usage)
  - [Configuration](#configuration)
      - [Configuration Options](#configuration-options)
  - [Outlined Select](#outlined-select)
  - [Disabled Select](#disabled-select)
  - [Required Select](#required-select)
  - [Disabled Option](#disabled-option)
  - [Select with helper text](#select-with-helper-text)
  - [Select with leading icon](#select-with-leading-icon)


# Resources

  - [Demo: Selects](https://aforemny.github.io/material-components-web-elm/#select)
  - [Material Design Guidelines: Text Fields](https://material.io/go/design-text-fields)
  - [MDC Web: Select](https://github.com/material-components/material-components-web/tree/master/packages/mdc-select)
  - [Sass Mixins (MDC Web)](https://github.com/material-components/material-components-web/tree/master/packages/mdc-select#sass-mixins)


# Basic Usage

    import Material.Select as Select
    import Material.Select.Option as SelectOption

    type Msg
        = ValueChanged String

    main =
        Select.filled
            (Select.config
                |> Select.setLabel (Just "Fruit")
                |> Select.setValue (Just "")
                |> Select.setOnChange ValueChanged
            )
            [ SelectOption.selectOption
                (SelectOption.config |> SelectOption.setValue (Just ""))
                [ text "" ]
            , SelectOption.selectOption
                (SelectOption.config
                    |> SelectOption.setValue (Just "Apple")
                )
                [ text "Apple" ]
            ]


# Configuration

@docs Config, config


## Configuration Options

@docs setOnChange
@docs setLabel
@docs setValue
@docs setDisabled
@docs setRequired
@docs setValid
@docs setAttributes


# Filled Select

@docs filled


# Outlined Select

Instead of a filled select, you may choose a select with a outline by using the
`outlined` view function.

    Select.outlined Select.config
        [ SelectOption.selectOption
            (SelectOption.config
                |> SelectOption.setValue (Just "")
            )
            [ text "" ]
        ]

@docs outlined


# Disabled Select

To disable a select, set its `setDisabled` configuration option to `True`.

    Select.filled (Select.config |> Select.setDisabled True) []


# Required Select

To mark a select as required, set its `setRequired` configuration option to
`True`.

    Select.filled (Select.config |> Select.setRequired True) []


# Select with helper text

TODO(select-with-helper-text)


# Select with leading icon

TODO(select-with-leading-icon)

-}

import Html exposing (Html, text)
import Html.Attributes exposing (class)
import Html.Events
import Json.Decode as Decode
import Json.Encode as Encode
import Material.Select.Option exposing (SelectOption)
import Material.Select.Option.Internal as SelectOption


{-| Configuration of a select
-}
type Config msg
    = Config
        { label : Maybe String
        , value : Maybe String
        , disabled : Bool
        , required : Bool
        , valid : Bool
        , additionalAttributes : List (Html.Attribute msg)
        , onChange : Maybe (String -> msg)
        }


{-| Default configuration of a select
-}
config : Config msg
config =
    Config
        { label = Nothing
        , value = Nothing
        , disabled = False
        , required = False
        , valid = False
        , additionalAttributes = []
        , onChange = Nothing
        }


{-| Specify a select's label
-}
setLabel : Maybe String -> Config msg -> Config msg
setLabel label (Config config_) =
    Config { config_ | label = label }


{-| Specify a select's value
-}
setValue : Maybe String -> Config msg -> Config msg
setValue value (Config config_) =
    Config { config_ | value = value }


{-| Specify a select to be disabled

Disabled selects cannot be interacted with an have no visual interaction
effect.

-}
setDisabled : Bool -> Config msg -> Config msg
setDisabled disabled (Config config_) =
    Config { config_ | disabled = disabled }


{-| Specify whether a select is required
-}
setRequired : Bool -> Config msg -> Config msg
setRequired required (Config config_) =
    Config { config_ | required = required }


{-| Specify whether a select is valid
-}
setValid : Bool -> Config msg -> Config msg
setValid valid (Config config_) =
    Config { config_ | valid = valid }


{-| Specify additional attributes
-}
setAttributes : List (Html.Attribute msg) -> Config msg -> Config msg
setAttributes additionalAttributes (Config config_) =
    Config { config_ | additionalAttributes = additionalAttributes }


{-| Specify a message when the user changes the select
-}
setOnChange : (String -> msg) -> Config msg -> Config msg
setOnChange onChange (Config config_) =
    Config { config_ | onChange = Just onChange }


type Variant
    = Filled
    | Outlined


select : Variant -> Config msg -> List (SelectOption msg) -> Html msg
select variant ((Config { additionalAttributes }) as config_) nodes =
    Html.node "mdc-select"
        (List.filterMap identity
            [ rootCs
            , variantCs variant
            , valueProp config_
            , disabledProp config_
            , validProp config_
            , requiredProp config_
            ]
            ++ additionalAttributes
        )
        (List.concat
            [ [ dropdownIconElt
              , nativeControlElt config_ nodes
              ]
            , if variant == Outlined then
                [ notchedOutlineElt config_ ]

              else
                [ floatingLabelElt config_
                , lineRippleElt
                ]
            ]
        )


{-| Filled select view function
-}
filled : Config msg -> List (SelectOption msg) -> Html msg
filled config_ nodes =
    select Filled config_ nodes


{-| Outlined select view function
-}
outlined : Config msg -> List (SelectOption msg) -> Html msg
outlined config_ nodes =
    select Outlined config_ nodes


rootCs : Maybe (Html.Attribute msg)
rootCs =
    Just (class "mdc-select")


variantCs : Variant -> Maybe (Html.Attribute msg)
variantCs variant =
    if variant == Outlined then
        Just (class "mdc-select--outlined")

    else
        Nothing


valueProp : Config msg -> Maybe (Html.Attribute msg)
valueProp (Config { value }) =
    Just (Html.Attributes.property "value" (Encode.string (Maybe.withDefault "" value)))


disabledProp : Config msg -> Maybe (Html.Attribute msg)
disabledProp (Config { disabled }) =
    Just (Html.Attributes.property "disabled" (Encode.bool disabled))


validProp : Config msg -> Maybe (Html.Attribute msg)
validProp (Config { valid }) =
    Just (Html.Attributes.property "valid" (Encode.bool valid))


requiredProp : Config msg -> Maybe (Html.Attribute msg)
requiredProp (Config { required }) =
    Just (Html.Attributes.property "required" (Encode.bool required))


dropdownIconElt : Html msg
dropdownIconElt =
    Html.i [ class "mdc-select__dropdown-icon" ] []


nativeControlElt : Config msg -> List (SelectOption msg) -> Html msg
nativeControlElt config_ nodes =
    Html.select
        (List.filterMap identity
            [ nativeControlCs
            , changeHandler config_
            ]
        )
        (List.map (selectOptionView config_) nodes)


nativeControlCs : Maybe (Html.Attribute msg)
nativeControlCs =
    Just (class "mdc-select__native-control")


selectOptionView : Config msg -> SelectOption msg -> Html msg
selectOptionView topConfig (SelectOption.SelectOption ((SelectOption.Config { additionalAttributes, nodes }) as config_)) =
    Html.option
        (List.filterMap identity
            [ selectedAttr topConfig config_
            , disabledAttr config_
            , optionValueAttr config_
            ]
            ++ additionalAttributes
        )
        nodes


selectedAttr : Config msg -> SelectOption.Config msg -> Maybe (Html.Attribute msg)
selectedAttr (Config topConfig) (SelectOption.Config config_) =
    Just
        (Html.Attributes.selected
            ((topConfig.value /= Nothing)
                && (topConfig.value == config_.value)
            )
        )


disabledAttr : SelectOption.Config msg -> Maybe (Html.Attribute msg)
disabledAttr (SelectOption.Config { disabled }) =
    Just (Html.Attributes.disabled disabled)


optionValueAttr : SelectOption.Config msg -> Maybe (Html.Attribute msg)
optionValueAttr (SelectOption.Config { value }) =
    Maybe.map Html.Attributes.value value


changeHandler : Config msg -> Maybe (Html.Attribute msg)
changeHandler (Config { onChange }) =
    Maybe.map (\msg -> Html.Events.on "change" (Decode.map msg Html.Events.targetValue))
        onChange


floatingLabelElt : Config msg -> Html msg
floatingLabelElt (Config { label, value }) =
    let
        floatingLabelCs =
            "mdc-floating-label"

        floatingLabelFloatAboveCs =
            "mdc-floating-label--float-above"
    in
    Html.div
        [ if Maybe.withDefault "" value /= "" then
            class (floatingLabelCs ++ " " ++ floatingLabelFloatAboveCs)

          else
            class floatingLabelCs
        , Html.Attributes.property "foucClassNames"
            (Encode.list Encode.string [ floatingLabelFloatAboveCs ])
        ]
        [ text (Maybe.withDefault "" label) ]


lineRippleElt : Html msg
lineRippleElt =
    Html.label [ class "mdc-line-ripple" ] []


notchedOutlineElt : Config msg -> Html msg
notchedOutlineElt (Config { label }) =
    Html.div [ class "mdc-notched-outline" ]
        [ Html.div [ class "mdc-notched-outline__leading" ] []
        , Html.div [ class "mdc-notched-outline__notch" ]
            [ Html.label [ class "mdc-floating-label" ]
                [ text (Maybe.withDefault "" label) ]
            ]
        , Html.div [ class "mdc-notched-outline__trailing" ] []
        ]
