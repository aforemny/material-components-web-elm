module Material.EnhancedSelect exposing
    ( filledEnhancedSelect, enhancedSelectConfig, EnhancedSelectConfig
    , selectItem, selectItemConfig, SelectItemConfig
    , outlinedEnhancedSelect
    )

{-| The enhanced select uses a menu component instance to contain the list
of options. The enhanced select provides a look and feel more consistent with
the rest of Material Design, but there are some trade-offs to consider when
choosing it over the native `<select>` element (see [Usability
Notes](https://github.com/material-components/material-components-web/tree/master/packages/mdc-select#usability-notes)).


# Table of Contents

  - [Resources](#resources)
  - [Basic Usage](#basic-usage)
  - [Filled Select](#filled-select)
  - [Outlined Select](#outlined-select)
  - [Disabled Select](#disabled-select)
  - [Disabled Items](#disabled-items)


# Resources

  - [Demo: Selects](https://aforemny.github.io/material-components-web-elm/#selects)
  - [Material Design Guidelines: Fields](https://material.io/go/design-text-fields)
  - [MDC Web: Select](https://github.com/material-components/material-components-web/tree/master/packages/mdc-select)
  - [Sass Mixins (MDC Web)](https://github.com/material-components/material-components-web/tree/master/packages/mdc-select#sass-mixins)


# Basic Usage

    import Material.List exposing (list, listConfig)
    import Material.Select.Enhanced
        exposing
            ( filledEnhancedSelect
            , selectItem
            , selectItemConfig
            )

    type Msg
        = ValueChanged String

    main =
        filledEnhancedSelect
            { enhancedSelectConfig | label = "Fruit" }
            [ list listConfig
                [ selectItem
                    { selectItemConfig
                        | onClick = Just (ValueChanged "")
                    }
                    [ text "" ]
                , selectItem
                    { selectItemConfig
                        | onClick =
                            Just (ValueChanged "Apple")
                    }
                    selectItemConfig
                    [ text "Apple" ]
                ]
            ]


# Filled Select

@docs filledEnhancedSelect, enhancedSelectConfig, EnhancedSelectConfig
@docs selectItem, selectItemConfig, SelectItemConfig


# Outlined Select

The enhanced select component can be used with a notched outline rather than
the default ine ripple to indicate focus.

    outlinedEnhancedSelect
        { enhancedSelectConfig | outlined = True }
        []

@docs outlinedEnhancedSelect


# Disabled Select

To disable the select component, set its `disabled` configuration field to
`True`. A disabled select cannot be interacted with and will have not visual
interaction indicator.

    filledEnhancedSelect
        { enhancedSelectConfig | disabled = True }
        []


# Disabled Items

To disable a select item, set its `disabled` configuration field to `True`. A
disabled select item cannot be selected.

    selectItem
        { selectItemConfig | disabled = True }
        [ text "" ]


# Selected Items

To mark a select item as selected, set its `selected` configuration field to
`True`.

    selectItem
        { selectItemConfig | selected = True }
        [ text "" ]


# Activated Items

To mark a select item as activated, set its `activated` configuration field to
`True`.

    selectItem
        { selectItemConfig | activated = True }
        [ text "" ]

-}

import Html exposing (Html, text)
import Html.Attributes exposing (class)
import Html.Events
import Json.Decode as Decode
import Material.List exposing (list, listConfig)


{-| Configuration of an enhanced select
-}
type alias EnhancedSelectConfig msg =
    { variant : Variant
    , label : String
    , disabled : Bool
    , additionalAttributes : List (Html.Attribute msg)
    , width : Maybe String
    }


{-| Default configuration of an enhanced select
-}
enhancedSelectConfig : EnhancedSelectConfig msg
enhancedSelectConfig =
    { variant = Filled
    , label = ""
    , disabled = False
    , additionalAttributes = []
    , width = Nothing
    }


type Variant
    = Filled
    | Outlined


enhancedSelect : EnhancedSelectConfig msg -> List (Html msg) -> Html msg
enhancedSelect config nodes =
    Html.node "mdc-enhanced-select"
        (List.filterMap identity
            [ rootCs
            , variantCs config
            , disabledCs config
            ]
            ++ config.additionalAttributes
        )
        (List.concat
            [ [ hiddenInputElt
              , dropdownIconElt
              , selectedTextElt
              , menuElt nodes
              ]
            , if config.variant == Outlined then
                [ notchedOutlineElt config ]

              else
                [ floatingLabelElt config
                , lineRippleElt
                ]
            ]
        )


{-| Filled enhanced select view function
-}
filledEnhancedSelect : EnhancedSelectConfig msg -> List (Html msg) -> Html msg
filledEnhancedSelect config nodes =
    enhancedSelect { config | variant = Filled } nodes


{-| Outlined enhanced select view function
-}
outlinedEnhancedSelect : EnhancedSelectConfig msg -> List (Html msg) -> Html msg
outlinedEnhancedSelect config nodes =
    enhancedSelect { config | variant = Outlined } nodes


{-| Configuration of a select item
-}
type alias SelectItemConfig msg =
    { disabled : Bool
    , selected : Bool
    , activated : Bool
    , additionalAttributes : List (Html.Attribute msg)
    , onClick : Maybe msg
    }


{-| Default configuration of a select item
-}
selectItemConfig : SelectItemConfig msg
selectItemConfig =
    { disabled = False
    , selected = False
    , activated = False
    , additionalAttributes = []
    , onClick = Nothing
    }


{-| Select item view function
-}
selectItem : SelectItemConfig msg -> List (Html msg) -> Html msg
selectItem config nodes =
    Html.li
        (List.filterMap identity
            [ listItemCs
            , listItemDisabledCs config
            , listItemSelectedCs config
            , listItemActivatedCs config
            , listItemClickHandler config
            ]
            ++ config.additionalAttributes
        )
        nodes


rootCs : Maybe (Html.Attribute msg)
rootCs =
    Just (class "mdc-select")


variantCs : EnhancedSelectConfig msg -> Maybe (Html.Attribute msg)
variantCs { variant } =
    if variant == Outlined then
        Just (class "mdc-select--outlined")

    else
        Nothing


disabledCs : EnhancedSelectConfig msg -> Maybe (Html.Attribute msg)
disabledCs { disabled } =
    if disabled then
        Just (class "mdc-select--disabled")

    else
        Nothing


listItemCs : Maybe (Html.Attribute msg)
listItemCs =
    Just (class "mdc-list-item")


listItemDisabledCs : SelectItemConfig msg -> Maybe (Html.Attribute msg)
listItemDisabledCs { disabled } =
    if disabled then
        Just (class "mdc-list-item--disabled")

    else
        Nothing


listItemSelectedCs : SelectItemConfig msg -> Maybe (Html.Attribute msg)
listItemSelectedCs { selected } =
    if selected then
        Just (class "mdc-list-item--selected")

    else
        Nothing


listItemActivatedCs : SelectItemConfig msg -> Maybe (Html.Attribute msg)
listItemActivatedCs { activated } =
    if activated then
        Just (class "mdc-list-item--activated")

    else
        Nothing


listItemClickHandler : SelectItemConfig msg -> Maybe (Html.Attribute msg)
listItemClickHandler { onClick } =
    Maybe.map Html.Events.onClick onClick


hiddenInputElt : Html msg
hiddenInputElt =
    Html.input [ Html.Attributes.type_ "hidden" ] []


dropdownIconElt : Html msg
dropdownIconElt =
    Html.i [ class "mdc-select__dropdown-icon" ] []


selectedTextElt : Html msg
selectedTextElt =
    Html.div [ class "mdc-select__selected-text" ] []


menuElt : List (Html msg) -> Html msg
menuElt nodes =
    Html.div [ class "mdc-select__menu mdc-menu mdc-menu-surface" ] [ listElt nodes ]


listElt : List (Html msg) -> Html msg
listElt nodes =
    list listConfig nodes


floatingLabelElt : EnhancedSelectConfig msg -> Html msg
floatingLabelElt { label } =
    Html.label [ class "mdc-floating-label" ] [ text label ]


lineRippleElt : Html msg
lineRippleElt =
    Html.label [ class "mdc-line-ripple" ] []


notchedOutlineElt : EnhancedSelectConfig msg -> Html msg
notchedOutlineElt { label } =
    Html.div [ class "mdc-notched-outline" ]
        [ Html.div [ class "mdc-notched-outline__leading" ] []
        , Html.div [ class "mdc-notched-outline__notch" ]
            [ Html.label [ class "mdc-floating-label" ] [ text label ]
            ]
        , Html.div [ class "mdc-notched-outline__trailing" ] []
        ]
