module Material.List exposing
    ( list, listConfig, ListConfig
    , listItem, listItemConfig, ListItemConfig
    , listItemText, listItemPrimaryText, listItemSecondaryText
    , listGroup
    , listGroupSubheader
    , listGroupDivider
    , listItemGraphic
    , listItemMeta
    , listItemDivider, listItemDividerConfig, ListItemDividerConfig
    )

{-| Lists are continuous, vertical indexes of text or images.


# Table of Contents

  - [Resources](#resources)
  - [Basic Usage](#basic-usage)
  - [List](#list)
  - [List Item](#list-item)
  - [List Variants](#list-variants)
      - [Two-Line List](#two-line-list)
      - [Non-interactive List](#non-interactive-list)
      - [Dense List](#dense-list)
      - [Avatar List](#avatar-list)
      - [List Group](#list-group)
          - [List Group Divider](#list-group-divider)
  - [List Item Variants](#list-item-variants)
      - [List Item with Graphic](#list-item-with-graphic)
      - [List Item with Meta](#list-item-with-meta)
      - [Disabled List Item](#disabled-list-item)
      - [Selected List Item](#selected-list-item)
      - [Activated List Item](#activated-list-item)
      - [List Item Divider](#list-item-divider)


# Resources

  - [Demo: Lists](https://aforemny.github.io/material-components-web-elm/#lists)
  - [Material Design Guidelines: Lists](https://material.io/design/components/lists.html)
  - [MDC Web: List](https://github.com/material-components/material-components-web/tree/master/packages/mdc-list)
  - [Sass Mixins (MDC Web)](https://github.com/material-components/material-components-web/tree/master/packages/mdc-list#sass-mixins)


# Basic Usage

    import Material.List
        exposing
            ( list
            , listConfig
            , listItem
            , listItemConfig
            )

    main =
        list listConfig
            [ listItem listItemConfig [ text "Line item" ]
            , listItem listItemConfig [ text "Line item" ]
            ]


# List

@docs list, listConfig, ListConfig


# List Item

@docs listItem, listItemConfig, ListItemConfig


# List Variants


## Two-Line List

Lists may be two-line lists by settings the `twoLine` configuration field to
`True`. In that case, list items should wrap their contents inside
`listItemText` and their first line in `listItemPrimaryText` and their second
line in `listItemSecondaryText`.

    list { listConfig | twoLine = True }
        [ listItem listItemConfig
            [ listItemText []
                [ listItemPrimaryText []
                    [ text "First line" ]
                , listItemSecondaryText []
                    [ text "Second line" ]
                ]
            ]
        ]

@docs listItemText, listItemPrimaryText, listItemSecondaryText


## Non-interactive List

Lists may be non-interactive by setting the `nonInteractive` configuration
field to `True`.

    list { listConfig | nonInteractive = True }
        [ listItem listItemConfig [ text "List item" ] ]


## Dense List

Lists may be styled more compact by setting the `dense` configuration field to
`True`.

    list { listConfig | dense = True }
        [ listItem listItemConfig [ text "List item" ] ]


## Avatar List

List item's graphics may be configured to appear larger by setting the
`avatarList` configuration field to `True`.

This is particularly useful when a list item's graphic includes an image rather
than an icon.

    list { listConfig | dense = True }
        [ listItem listItemConfig
            [ listItemGraphic [] [ Html.img [] [] ]
            , text "List item"
            ]
        ]


## List Group

Multiple related lists, such as folders and files in a file hierarchy, may be
grouped using `listGroup` and labeled by `listGroupSubheader`.

    listGroup []
        [ listGroupSubheader [] [ text "Folders" ]
        , list listConfig
            [ listItem [] [ text "Folder" ]
            , listItem [] [ text "Folder" ]
            ]
        , listGroupSubheader [] [ text "Files" ]
        , list listConfig
            [ listItem [] [ text "File" ]
            , listItem [] [ text "File" ]
            ]
        ]

@docs listGroup
@docs listGroupSubheader


### List Group Divider

Multiple lists within a group may be visually seperated by a list group divider.

    listGroup []
        [ list listConfig
            [ listItem [] [ text "Folder" ]
            , listItem [] [ text "Folder" ]
            ]
        , listGroupDivider []
        , list listConfig
            [ listItem [] [ text "File" ]
            , listItem [] [ text "File" ]
            ]
        ]

@docs listGroupDivider


## List Item Variants

In addition to their text child, lists may optionally contain a starting tile
referred to as _graphic_ and/ or a last tile referred to as _meta_.


### List Item with Graphic

Common examples for graphics are icons and images, avatar images and selection
controls such as checkboxes.

    listItem listItemConf
        [ listItemGraphic [] [ icon iconConf "star" ]
        , text "List item"
        ]

@docs listItemGraphic


### List Item with Meta

Common examples for metas are text, icons and images and selection controls.

    listItem listItemConf
        [ text "List item"
        , listItemMeta [] [ icon iconConf "star" ]
        ]

@docs listItemMeta


### Disabled List Item

List items may be disabled by setting their `disabled` configuration field to
`True`.

    listItem { listItemConf | disabled = True }
        [ text "List item" ]


### Selected List Item

List items may be disabled by setting their `selected` configuration field to
`True`.

    listItem { listItemConf | selected = True }
        [ text "List item" ]


### Activated List Item

List items may be disabled by setting their `activated` configuration field to
`True`.

    listItem { listItemConf | activated = True }
        [ text "List item" ]


## List Item Divider

List items may be seperated by a divider. The divider may optionally be `inset`
so that it does not intersect the list item's graphic, or `padded` so that it
does not intersect the list item's meta.

    list listConfig
        [ listItem [] [ text "List item" ]
        , listItemDivider listItemDividerConfig
        , listItem [] [ text "List item" ]
        ]

@docs listItemDivider, listItemDividerConfig, ListItemDividerConfig

-}

import Html exposing (Html, text)
import Html.Attributes exposing (class)
import Html.Events
import Json.Decode as Decode
import Json.Encode as Encode


{-| Configuration of a list
-}
type alias ListConfig msg =
    { nonInteractive : Bool
    , dense : Bool
    , avatarList : Bool
    , twoLine : Bool
    , wrapFocus : Bool
    , additionalAttributes : List (Html.Attribute msg)
    }


{-| Default configuration of a list
-}
listConfig : ListConfig msg
listConfig =
    { nonInteractive = False
    , dense = False
    , avatarList = False
    , twoLine = False
    , wrapFocus = False
    , additionalAttributes = []
    }


{-| List view function
-}
list : ListConfig msg -> List (Html msg) -> Html msg
list config nodes =
    Html.node "mdc-list"
        (List.filterMap identity
            [ rootCs
            , nonInteractiveCs config
            , denseCs config
            , avatarListCs config
            , twoLineCs config
            , wrapFocusProp config
            ]
            ++ config.additionalAttributes
        )
        nodes


rootCs : Maybe (Html.Attribute msg)
rootCs =
    Just (class "mdc-list")


nonInteractiveCs : ListConfig msg -> Maybe (Html.Attribute msg)
nonInteractiveCs { nonInteractive } =
    if nonInteractive then
        Just (class "mdc-list--non-interactive")

    else
        Nothing


denseCs : ListConfig msg -> Maybe (Html.Attribute msg)
denseCs { dense } =
    if dense then
        Just (class "mdc-list--dense")

    else
        Nothing


avatarListCs : ListConfig msg -> Maybe (Html.Attribute msg)
avatarListCs { avatarList } =
    if avatarList then
        Just (class "mdc-list--avatar-list")

    else
        Nothing


twoLineCs : ListConfig msg -> Maybe (Html.Attribute msg)
twoLineCs { twoLine } =
    if twoLine then
        Just (class "mdc-list--two-line")

    else
        Nothing


{-| Configuration of a list item
-}
type alias ListItemConfig msg =
    { disabled : Bool
    , selected : Bool
    , activated : Bool
    , additionalAttributes : List (Html.Attribute msg)
    , onClick : Maybe msg
    }


{-| Default configuration of a list item
-}
listItemConfig : ListItemConfig msg
listItemConfig =
    { disabled = False
    , selected = False
    , activated = False
    , additionalAttributes = []
    , onClick = Nothing
    }


{-| List item view function
-}
listItem : ListItemConfig msg -> List (Html msg) -> Html msg
listItem config nodes =
    Html.node "mdc-list-item"
        (List.filterMap identity
            [ listItemCs
            , disabledCs config
            , selectedCs config
            , activatedCs config
            , ariaSelectedAttr config
            , clickHandler config
            ]
            ++ config.additionalAttributes
        )
        nodes


listItemCs : Maybe (Html.Attribute msg)
listItemCs =
    Just (class "mdc-list-item")


disabledCs : ListItemConfig msg -> Maybe (Html.Attribute msg)
disabledCs { disabled } =
    if disabled then
        Just (class "mdc-list-item--disabled")

    else
        Nothing


selectedCs : ListItemConfig msg -> Maybe (Html.Attribute msg)
selectedCs { selected } =
    if selected then
        Just (class "mdc-list-item--selected")

    else
        Nothing


activatedCs : ListItemConfig msg -> Maybe (Html.Attribute msg)
activatedCs { activated } =
    if activated then
        Just (class "mdc-list-item--activated")

    else
        Nothing


ariaSelectedAttr : ListItemConfig msg -> Maybe (Html.Attribute msg)
ariaSelectedAttr { selected, activated } =
    if selected || activated then
        Just (Html.Attributes.attribute "aria-selected" "true")

    else
        Nothing


clickHandler : ListItemConfig msg -> Maybe (Html.Attribute msg)
clickHandler { onClick } =
    Maybe.map (Html.Events.on "MDCList:action" << Decode.succeed) onClick


{-| List item's text for list items in a two-line list
-}
listItemText : List (Html.Attribute msg) -> List (Html msg) -> Html msg
listItemText additionalAttributes nodes =
    Html.div (class "mdc-list-item__text" :: additionalAttributes) nodes


{-| First line of a two-line list item's text
-}
listItemPrimaryText : List (Html.Attribute msg) -> List (Html msg) -> Html msg
listItemPrimaryText additionalAttributes nodes =
    Html.div (class "mdc-list-item__primary-text" :: additionalAttributes) nodes


{-| Second line of a two-line list item's text
-}
listItemSecondaryText : List (Html.Attribute msg) -> List (Html msg) -> Html msg
listItemSecondaryText additionalAttributes nodes =
    Html.div (class "mdc-list-item__secondary-text" :: additionalAttributes) nodes


{-| A list item's graphic tile
-}
listItemGraphic : List (Html.Attribute msg) -> List (Html msg) -> Html msg
listItemGraphic additionalAttributes nodes =
    Html.div (class "mdc-list-item__graphic" :: additionalAttributes) nodes


{-| A list item's meta tile
-}
listItemMeta : List (Html.Attribute msg) -> List (Html msg) -> Html msg
listItemMeta additionalAttributes nodes =
    Html.div (class "mdc-list-item__meta" :: additionalAttributes) nodes


{-| Configuration of a list item divider
-}
type alias ListItemDividerConfig msg =
    { inset : Bool
    , padded : Bool
    , additionalAttributes : List (Html.Attribute msg)
    }


{-| Default configuration of a list item divider
-}
listItemDividerConfig : ListItemDividerConfig msg
listItemDividerConfig =
    { inset = False
    , padded = False
    , additionalAttributes = []
    }


{-| List item divider view function
-}
listItemDivider : ListItemDividerConfig msg -> Html msg
listItemDivider config =
    Html.li
        (List.filterMap identity
            [ listDividerCs
            , separatorRoleAttr
            , insetCs config
            , paddedCs config
            ]
            ++ config.additionalAttributes
        )
        []


listDividerCs : Maybe (Html.Attribute msg)
listDividerCs =
    Just (class "mdc-list-divider")


separatorRoleAttr : Maybe (Html.Attribute msg)
separatorRoleAttr =
    Just (Html.Attributes.attribute "role" "separator")


insetCs : ListItemDividerConfig msg -> Maybe (Html.Attribute msg)
insetCs { inset } =
    if inset then
        Just (class "mdc-list-divider--inset")

    else
        Nothing


paddedCs : ListItemDividerConfig msg -> Maybe (Html.Attribute msg)
paddedCs { padded } =
    if padded then
        Just (class "mdc-list-divider--padded")

    else
        Nothing


{-| List group view function
-}
listGroup : List (Html.Attribute msg) -> List (Html msg) -> Html msg
listGroup additionalAttributes nodes =
    Html.div (listGroupCs :: additionalAttributes) nodes


listGroupCs : Html.Attribute msg
listGroupCs =
    class "mdc-list-group"


{-| List group divider view function
-}
listGroupDivider : List (Html.Attribute msg) -> Html msg
listGroupDivider additionalAttributes =
    Html.hr (List.filterMap identity [ listDividerCs ] ++ additionalAttributes) []


{-| List group subheader view function
-}
listGroupSubheader : List (Html.Attribute msg) -> List (Html msg) -> Html msg
listGroupSubheader additionalAttributes nodes =
    Html.div (listGroupSubheaderCs :: additionalAttributes) nodes


listGroupSubheaderCs : Html.Attribute msg
listGroupSubheaderCs =
    class "mdc-list-group__subheader"


wrapFocusProp : ListConfig msg -> Maybe (Html.Attribute msg)
wrapFocusProp { wrapFocus } =
    Just (Html.Attributes.property "wrapFocus" (Encode.bool wrapFocus))
