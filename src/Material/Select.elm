module Material.Select exposing
    ( filledSelect, selectConfig, SelectConfig
    , selectOption, selectOptionConfig, SelectOptionConfig, SelectOption
    , outlinedSelect
    )

{-| MDC Select provides Material Design single-option select menus. It supports
using the browser's native `<select>` element, or a MDC Menu. It is fully
accessible, and fully RTL-aware.


# Table of Contents

  - [Resources](#resources)
  - [Basic Usage](#basic-usage)
  - [Outlined Select](#outlined-select)
  - [Disabled Select](#disabled-select)
  - [Required Select](#required-select)
  - [Disabled Option](#disabled-option)
  - [Select with helper text](#select-with-helper-text)
  - [Select with leading icon](#select-with-leading-icon)


# Resources

  - [Demo: Selects](https://aforemny.github.io/material-components-web-elm/#selects)
  - [Material Design Guidelines: Text Fields](https://material.io/go/design-text-fields)
  - [MDC Web: Select](https://github.com/material-components/material-components-web/tree/master/packages/mdc-select)
  - [Sass Mixins (MDC Web)](https://github.com/material-components/material-components-web/tree/master/packages/mdc-select#sass-mixins)


# Basic Usage

    import Material.Select
        exposing
            ( select
            , selectConfig
            , selectOption
            , selectOptionConfig
            )

    type Msg
        = ValueChanged String

    main =
        filledSelect
            { selectConfig
                | label = "Fruit"
                , value = Just ""
                , onChange = Just ValueChanged
            }
            [ selectOption
                { selectOptionConfig | value = "" }
                [ text "" ]
            , selectOption
                { selectOptionConfig | value = "Apple" }
                [ text "Apple" ]
            ]

@docs filledSelect, selectConfig, SelectConfig
@docs selectOption, selectOptionConfig, SelectOptionConfig, SelectOption


# Outlined Select

Instead of a filled select, you may choose a select with a outline by using the
`outlinedSelect` view function.

    outlinedSelect selectConf
        [ selectOption selectOptionConf "" ]

@docs outlinedSelect


# Disabled Select

To disable a select, set its `disabled` configuration field to `True`.

    filledSelect
        { selectConfig | disabled = True }
        [ selectOption { selectOptionConfig | value = "" }
            [ text "" ]
        ]


# Required Select

To mark a select as required, set its `required` configuration field to `True`.

    filledSelect
        { selectConfig | required = True }
        [ selectOption { selectOptionConfig | value = "" }
            [ text "" ]
        ]


# Disabled Option

To disable one select's option, set its `disabled` configuration field to `True`.

    selectOption { selectOptionConfig | disabled = True }
        [ text "" ]

This is particularly useful on the first emply option if you have a select that
must be filled but is not initially filled.


# Select with helper text

TODO


# Select with leading icon

TODO

-}

import Html exposing (Html, text)
import Html.Attributes exposing (class)
import Html.Events
import Json.Decode as Decode
import Json.Encode as Encode


{-| Configuration of a select
-}
type alias SelectConfig msg =
    { label : String
    , value : Maybe String
    , disabled : Bool
    , required : Bool
    , valid : Bool
    , additionalAttributes : List (Html.Attribute msg)
    , onChange : Maybe (String -> msg)
    }


{-| Default configuration of a select
-}
selectConfig : SelectConfig msg
selectConfig =
    { label = ""
    , value = Nothing
    , disabled = False
    , required = False
    , valid = False
    , additionalAttributes = []
    , onChange = Nothing
    }


type Variant
    = Filled
    | Outlined


select : Variant -> SelectConfig msg -> List (SelectOption msg) -> Html msg
select variant config nodes =
    Html.node "mdc-select"
        (List.filterMap identity
            [ rootCs
            , variantCs variant
            , valueProp config
            , disabledProp config
            , validProp config
            , requiredProp config
            ]
            ++ config.additionalAttributes
        )
        (List.concat
            [ [ dropdownIconElt
              , nativeControlElt config nodes
              ]
            , if variant == Outlined then
                [ notchedOutlineElt config ]

              else
                [ floatingLabelElt config
                , lineRippleElt
                ]
            ]
        )


{-| Filled select view function
-}
filledSelect : SelectConfig msg -> List (SelectOption msg) -> Html msg
filledSelect config nodes =
    select Filled config nodes


{-| Outlined select view function
-}
outlinedSelect : SelectConfig msg -> List (SelectOption msg) -> Html msg
outlinedSelect config nodes =
    select Outlined config nodes


rootCs : Maybe (Html.Attribute msg)
rootCs =
    Just (class "mdc-select")


variantCs : Variant -> Maybe (Html.Attribute msg)
variantCs variant =
    if variant == Outlined then
        Just (class "mdc-select--outlined")

    else
        Nothing


valueProp : SelectConfig msg -> Maybe (Html.Attribute msg)
valueProp { value } =
    Just (Html.Attributes.property "value" (Encode.string (Maybe.withDefault "" value)))


disabledProp : SelectConfig msg -> Maybe (Html.Attribute msg)
disabledProp { disabled } =
    Just (Html.Attributes.property "disabled" (Encode.bool disabled))


validProp : SelectConfig msg -> Maybe (Html.Attribute msg)
validProp { valid } =
    Just (Html.Attributes.property "valid" (Encode.bool valid))


requiredProp : SelectConfig msg -> Maybe (Html.Attribute msg)
requiredProp { required } =
    Just (Html.Attributes.property "required" (Encode.bool required))


dropdownIconElt : Html msg
dropdownIconElt =
    Html.i [ class "mdc-select__dropdown-icon" ] []


nativeControlElt : SelectConfig msg -> List (SelectOption msg) -> Html msg
nativeControlElt config nodes =
    Html.select
        (List.filterMap identity
            [ nativeControlCs
            , changeHandler config
            ]
        )
        (List.map (\(SelectOption f) -> f config) nodes)


nativeControlCs : Maybe (Html.Attribute msg)
nativeControlCs =
    Just (class "mdc-select__native-control")


{-| Configuration of a select option
-}
type alias SelectOptionConfig msg =
    { disabled : Bool
    , value : String
    , additionalAttributes : List (Html.Attribute msg)
    }


{-| Default configuration of a select option
-}
selectOptionConfig : SelectOptionConfig msg
selectOptionConfig =
    { disabled = False
    , value = ""
    , additionalAttributes = []
    }


{-| Select option type
-}
type SelectOption msg
    = SelectOption (SelectConfig msg -> Html msg)


{-| Select option view function
-}
selectOption : SelectOptionConfig msg -> List (Html msg) -> SelectOption msg
selectOption config nodes =
    SelectOption
        (\topConfig ->
            Html.option
                ([ selectedAttr topConfig config
                 , disabledAttr config
                 , optionValueAttr config
                 ]
                    ++ config.additionalAttributes
                )
                nodes
        )


selectedAttr : SelectConfig msg -> SelectOptionConfig msg -> Html.Attribute msg
selectedAttr topConfig config =
    Html.Attributes.selected (Maybe.withDefault "" topConfig.value == config.value)


disabledAttr : SelectOptionConfig msg -> Html.Attribute msg
disabledAttr { disabled } =
    Html.Attributes.disabled disabled


optionValueAttr : SelectOptionConfig msg -> Html.Attribute msg
optionValueAttr { value } =
    Html.Attributes.value value


changeHandler : SelectConfig msg -> Maybe (Html.Attribute msg)
changeHandler { onChange } =
    Maybe.map (\msg -> Html.Events.on "change" (Decode.map msg Html.Events.targetValue))
        onChange


floatingLabelElt : SelectConfig msg -> Html msg
floatingLabelElt { label, value } =
    Html.label
        [ if Maybe.withDefault "" value /= "" then
            class "mdc-floating-label mdc-floating-label--float-above"

          else
            class "mdc-floating-label"
        ]
        [ text label ]


lineRippleElt : Html msg
lineRippleElt =
    Html.label [ class "mdc-line-ripple" ] []


notchedOutlineElt : SelectConfig msg -> Html msg
notchedOutlineElt { label } =
    Html.div [ class "mdc-notched-outline" ]
        [ Html.div [ class "mdc-notched-outline__leading" ] []
        , Html.div [ class "mdc-notched-outline__notch" ]
            [ Html.label [ class "mdc-floating-label" ] [ text label ]
            ]
        , Html.div [ class "mdc-notched-outline__trailing" ] []
        ]
