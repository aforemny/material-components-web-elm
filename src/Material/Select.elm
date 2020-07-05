module Material.Select exposing
    ( Config, config
    , setOnChange
    , setLabel
    , setSelected
    , setDisabled
    , setRequired
    , setValid
    , setLeadingIcon
    , setAttributes
    , filled
    , outlined
    , Icon, icon
    )

{-| Select provides a single-option select menus.

This module concerns the container select. If you are looking for information
about select options, refer to [Material.Select.Item](Material-Select-Item).


# Table of Contents

  - [Resources](#resources)
  - [Basic Usage](#basic-usage)
  - [Configuration](#configuration)
      - [Configuration Options](#configuration-options)
  - [Outlined Select](#outlined-select)
  - [Disabled Select](#disabled-select)
  - [Required Select](#required-select)
  - [Disabled Option](#disabled-option)
  - [Select with Helper Text](#select-with-helper-text)
  - [Select with Leading Icon](#select-with-leading-icon)
  - [Focus a Select](#focus-a-select)


# Resources

  - [Demo: Selects](https://aforemny.github.io/material-components-web-elm/#select)
  - [Material Design Guidelines: Text Fields](https://material.io/go/design-text-fields)
  - [MDC Web: Select](https://github.com/material-components/material-components-web/tree/master/packages/mdc-select)
  - [Sass Mixins (MDC Web)](https://github.com/material-components/material-components-web/tree/master/packages/mdc-select#sass-mixins)


# Basic Usage

    import Material.Select as Select
    import Material.Select.Item as SelectItem

    type Msg
        = ValueChanged String

    main =
        Select.filled
            (Select.config
                |> Select.setLabel (Just "Fruit")
                |> Select.setSelected (Just "")
                |> Select.setOnChange ValueChanged
            )
            (SelectItem.selectItem
                (SelectItem.config { value = "" })
                [ text "" ]
            )
            [ SelectItem.selectItem
                (SelectItem.config { value = "Apple" })
                [ text "Apple" ]
            ]


# Configuration

@docs Config, config


## Configuration Options

@docs setOnChange
@docs setLabel
@docs setSelected
@docs setDisabled
@docs setRequired
@docs setValid
@docs setLeadingIcon
@docs setAttributes


# Filled Select

@docs filled


# Outlined Select

Instead of a filled select, you may choose a select with a outline by using the
`outlined` view function.

    Select.outlined Select.config
        (SelectItem.selectItem
            (SelectItem.config { value = "" })
            [ text "" ]
        )
        [ SelectItem.selectItem
            (SelectItem.config { value = "Apple" })
            [ text "Apple" ]
        ]

@docs outlined


# Disabled Select

To disable a select, set its `setDisabled` configuration option to `True`.

    Select.filled (Select.config |> Select.setDisabled True)
        (SelectItem.selectItem (SelectItem.config { value = "" })
            [ text "" ]
        )
        []


# Required Select

To mark a select as required, set its `setRequired` configuration option to
`True`.

    Select.filled (Select.config |> Select.setRequired True)
        (SelectItem.selectItem (SelectItem.config { value = "" })
            [ text "" ]
        )
        []


# Select with helper text

TODO(select-with-helper-text)

    -- import Select.HelperText as SelectHelperText
    main =
        --Html.div []
        --    [ Select.filled Select.config
        --        (SelectItem.item
        --            (SelectItem.config { value = "" })
        --            [ text "" ]
        --        )
        --        [ SelectItem.item
        --            (SelectItem.config { value = "Apple" })
        --            [ text "" ]
        --        ]
        --    , SelectHelperText.helperText
        --        (SelectHelperText.config
        --            |> SelectHelperText.setValid False
        --            |> SelectHelperText.setPersistent True
        --        )
        --        [ text "Helper text" ]
        --    ]
        text "TODO"


# Select with leading icon

To have a select display a leading icon, use its `setLeadingIcon` configuration
option to specify a value of `Icon`.

    Select.filled
        (Select.config
            |> Select.setLeadingIcon
                (Just (Select.icon [] "favorite"))
        )
        (SelectItem.selectItem
            (SelectItem.config { value = "" })
            [ text "" ]
        )
        [ SelectItem.selectItem
            (SelectItem.config { value = "Apple" })
            [ text "Apple" ]
        ]

@docs Icon, icon


# Focus a Select

You may programatically focus a select by assigning an id attribute to it and
use `Browser.Dom.focus`.

    Select.filled
        (Select.config
            |> Select.setAttributes
                [ Html.Attributes.id "my-select" ]
        )
        (SelectItem.selectItem
            (SelectItem.config { value = "" })
            [ text "" ]
        )
        [ SelectItem.selectItem
            (SelectItem.config { value = "Apple" })
            [ text "Apple" ]
        ]

-}

import Html exposing (Html, text)
import Html.Attributes exposing (class, style)
import Json.Encode as Encode
import Material.Icon as Icon
import Material.List as List
import Material.List.Item as ListItem exposing (ListItem)
import Material.Menu as Menu
import Material.Select.Item exposing (SelectItem)
import Material.Select.Item.Internal as SelectItem


{-| Configuration of a select
-}
type Config a msg
    = Config
        { label : Maybe String
        , disabled : Bool
        , required : Bool
        , valid : Bool
        , selected : Maybe a
        , leadingIcon : Maybe (Icon msg)
        , additionalAttributes : List (Html.Attribute msg)
        , onChange : Maybe (a -> msg)
        }


{-| Default configuration of a select
-}
config : Config a msg
config =
    Config
        { label = Nothing
        , disabled = False
        , required = False
        , valid = True
        , selected = Nothing
        , leadingIcon = Nothing
        , additionalAttributes = []
        , onChange = Nothing
        }


{-| Specify a select's label
-}
setLabel : Maybe String -> Config a msg -> Config a msg
setLabel label (Config config_) =
    Config { config_ | label = label }


{-| Specify a select's selected value
-}
setSelected : Maybe a -> Config a msg -> Config a msg
setSelected selected (Config config_) =
    Config { config_ | selected = selected }


{-| Specify whether a select is disabled

Disabled selects cannot be interacted with an have no visual interaction
effect.

-}
setDisabled : Bool -> Config a msg -> Config a msg
setDisabled disabled (Config config_) =
    Config { config_ | disabled = disabled }


{-| Specify whether a select is required
-}
setRequired : Bool -> Config a msg -> Config a msg
setRequired required (Config config_) =
    Config { config_ | required = required }


{-| Specify whether a select is valid
-}
setValid : Bool -> Config a msg -> Config a msg
setValid valid (Config config_) =
    Config { config_ | valid = valid }


{-| Specify a select's leading icon
-}
setLeadingIcon : Maybe (Icon msg) -> Config a msg -> Config a msg
setLeadingIcon leadingIcon (Config config_) =
    Config { config_ | leadingIcon = leadingIcon }


{-| Specify additional attributes
-}
setAttributes : List (Html.Attribute msg) -> Config a msg -> Config a msg
setAttributes additionalAttributes (Config config_) =
    Config { config_ | additionalAttributes = additionalAttributes }


{-| Specify a message when the user changes the select
-}
setOnChange : (a -> msg) -> Config a msg -> Config a msg
setOnChange onChange (Config config_) =
    Config { config_ | onChange = Just onChange }


type Variant
    = Filled
    | Outlined


select : Variant -> Config a msg -> SelectItem a msg -> List (SelectItem a msg) -> Html msg
select variant ((Config { leadingIcon, selected, additionalAttributes, onChange }) as config_) firstSelectItem remainingSelectItems =
    let
        selectedIndex =
            List.indexedMap
                (\index (SelectItem.SelectItem (SelectItem.Config { value }) _) ->
                    if Just value == selected then
                        Just index

                    else
                        Nothing
                )
                (firstSelectItem :: remainingSelectItems)
                |> List.filterMap identity
                |> List.head
    in
    Html.node "mdc-select"
        (List.filterMap identity
            [ rootCs
            , outlinedCs variant
            , leadingIconCs config_
            , disabledProp config_
            , selectedIndexProp selectedIndex
            , validProp config_
            , requiredProp config_
            ]
            ++ additionalAttributes
        )
        [ anchorElt []
            (List.concat
                [ [ leadingIconElt config_
                  , dropdownIconElt
                  , selectedTextElt
                  ]
                , if variant == Outlined then
                    [ notchedOutlineElt config_ ]

                  else
                    [ floatingLabelElt config_
                    , lineRippleElt
                    ]
                ]
            )
        , menuElt leadingIcon selected onChange firstSelectItem remainingSelectItems
        ]


{-| Filled select view function
-}
filled : Config a msg -> SelectItem a msg -> List (SelectItem a msg) -> Html msg
filled config_ firstSelectItem remainingSelectItems =
    select Filled config_ firstSelectItem remainingSelectItems


{-| Outlined select view function
-}
outlined : Config a msg -> SelectItem a msg -> List (SelectItem a msg) -> Html msg
outlined config_ firstSelectItem remainingSelectItems =
    select Outlined config_ firstSelectItem remainingSelectItems


{-| Select leading icon type
-}
type Icon msg
    = Icon (Html msg)


{-| Select leading icon
-}
icon : List (Html.Attribute msg) -> String -> Icon msg
icon additionalAttributes iconName =
    Icon (Icon.icon (class "mdc-select__icon" :: additionalAttributes) iconName)


rootCs : Maybe (Html.Attribute msg)
rootCs =
    Just (class "mdc-select")


outlinedCs : Variant -> Maybe (Html.Attribute msg)
outlinedCs variant =
    if variant == Outlined then
        Just (class "mdc-select--outlined")

    else
        Nothing


leadingIconCs : Config a msg -> Maybe (Html.Attribute msg)
leadingIconCs (Config { leadingIcon }) =
    Maybe.map (\_ -> class "mdc-select--with-leading-icon") leadingIcon


disabledProp : Config a msg -> Maybe (Html.Attribute msg)
disabledProp (Config { disabled }) =
    Just (Html.Attributes.property "disabled" (Encode.bool disabled))


validProp : Config a msg -> Maybe (Html.Attribute msg)
validProp (Config { valid }) =
    Just (Html.Attributes.property "valid" (Encode.bool valid))


selectedIndexProp : Maybe Int -> Maybe (Html.Attribute msg)
selectedIndexProp selectedIndex =
    Just
        (Html.Attributes.property "selectedIndex"
            (Encode.int (Maybe.withDefault -1 selectedIndex))
        )


requiredProp : Config a msg -> Maybe (Html.Attribute msg)
requiredProp (Config { required }) =
    Just (Html.Attributes.property "required" (Encode.bool required))


anchorElt : List (Html.Attribute msg) -> List (Html msg) -> Html msg
anchorElt additionalAttributes nodes =
    Html.div (class "mdc-select__anchor" :: additionalAttributes) nodes


leadingIconElt : Config a msg -> Html msg
leadingIconElt (Config { leadingIcon }) =
    case leadingIcon of
        Just (Icon icon_) ->
            icon_

        Nothing ->
            text ""


dropdownIconElt : Html msg
dropdownIconElt =
    Html.i [ class "mdc-select__dropdown-icon" ] []


floatingLabelElt : Config a msg -> Html msg
floatingLabelElt (Config { label }) =
    Html.div [ class "mdc-floating-label" ] [ text (Maybe.withDefault "" label) ]


lineRippleElt : Html msg
lineRippleElt =
    Html.label [ class "mdc-line-ripple" ] []


notchedOutlineElt : Config a msg -> Html msg
notchedOutlineElt (Config { label }) =
    Html.div [ class "mdc-notched-outline" ]
        [ Html.div [ class "mdc-notched-outline__leading" ] []
        , Html.div [ class "mdc-notched-outline__notch" ]
            [ Html.label [ class "mdc-floating-label" ]
                [ text (Maybe.withDefault "" label) ]
            ]
        , Html.div [ class "mdc-notched-outline__trailing" ] []
        ]


menuElt : Maybe (Icon msg) -> Maybe a -> Maybe (a -> msg) -> SelectItem a msg -> List (SelectItem a msg) -> Html msg
menuElt leadingIcon selected onChange firstSelectItem remainingSelectItems =
    Menu.menu
        (Menu.config
            |> Menu.setAttributes
                [ class "mdc-select__menu"
                , style "width" "100%"
                ]
        )
        [ List.list (List.config |> List.setWrapFocus True)
            (listItem leadingIcon selected onChange firstSelectItem)
            (List.map (listItem leadingIcon selected onChange) remainingSelectItems)
        ]


listItem : Maybe (Icon msg) -> Maybe a -> Maybe (a -> msg) -> SelectItem a msg -> ListItem msg
listItem leadingIcon selected onChange (SelectItem.SelectItem config_ nodes) =
    ListItem.listItem (listItemConfig selected onChange config_)
        (if leadingIcon /= Nothing then
            ListItem.graphic [] [] :: nodes

         else
            nodes
        )


listItemConfig : Maybe a -> Maybe (a -> msg) -> SelectItem.Config a msg -> ListItem.Config msg
listItemConfig selectedValue onChange (SelectItem.Config { value, disabled, additionalAttributes }) =
    ListItem.config
        |> ListItem.setDisabled disabled
        |> ListItem.setAttributes additionalAttributes
        |> (case onChange of
                Just onChange_ ->
                    ListItem.setOnClick (onChange_ value)

                Nothing ->
                    identity
           )


selectedTextElt : Html msg
selectedTextElt =
    Html.div [ class "mdc-select__selected-text" ] []
