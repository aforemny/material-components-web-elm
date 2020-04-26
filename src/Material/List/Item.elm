module Material.List.Item exposing
    ( Config, config
    , setOnClick
    , setDisabled
    , setSelected
    , setHref
    , setTarget
    , setAttributes
    , ListItem, listItem
    , graphic
    , meta
    , text
    , Selection, selected
    , activated
    )

{-| Lists are continuous, vertical indexes of text or images.

This module concerns the list items. If you are looking for the list container,
refer to [Material.List](Material-List).


# Table of Contents

  - [Resources](#resources)
  - [Basic Usage](#basic-usage)
  - [Configuration](#configuration)
      - [Configuration Options](#configuration-options)
  - [List Item](#list-item)
  - [List Item with Graphic](#list-item-with-graphic)
  - [List Item with Meta](#list-item-with-meta)
  - [Two-Line List Item](#two-line-list-item)
  - [Disabled List Item](#disabled-list-item)
  - [Selected List Item](#selected-list-item)
  - [Activated List Item](#activated-list-item)
  - [Link List Item](#link-list-item)
  - [List Item Divider](#list-item-divider)


# Resources

  - [Demo: Lists](https://aforemny.github.io/material-components-web-elm/#lists)
  - [Material Design Guidelines: Lists](https://material.io/design/components/lists.html)
  - [MDC Web: List](https://github.com/material-components/material-components-web/tree/master/packages/mdc-list)
  - [Sass Mixins (MDC Web)](https://github.com/material-components/material-components-web/tree/master/packages/mdc-list#sass-mixins)


# Basic Usage

    import Material.List as List
    import Material.List.Item as ListItem

    main =
        List.list List.config
            [ ListItem.listItem ListItem.config
                [ text "Line item" ]
            ]


# Configuration

@docs Config, config


## Configuration Options

@docs setOnClick
@docs setDisabled
@docs setSelected
@docs setHref
@docs setTarget
@docs setAttributes


# List Item

@docs ListItem, listItem


# List Item with Graphic

In addition to their text, list itemss may optionally contain a starting tile
referred to as _graphic_.

Common examples for graphics are icons and images, avatar images and selection
controls such as checkboxes.

    ListItem.listItem ListItem.config
        [ ListItem.graphic [] [ Icon.icon Icon.config "star" ]
        , text "List item"
        ]

@docs graphic


# List Item with Meta

In addition to their text child, list items may optionally contain a starting
tile referred to as _meta_.

Common examples for metas are text, icons and images and selection controls.

    ListItem.listItem ListItem.config
        [ text "List item"
        , ListItem.meta [] [ Icon.icon Icon.config "star" ]
        ]

@docs meta


# Two-Line List Item

List items may be two-line list items by using `text`.

    ListItem.listItem ListItem.config
        [ ListItem.text []
            { primary = [ text "First line" ]
            , secondary = [ text "Second line" ]
            }
        ]

@docs text


# Disabled List Item

List items may be disabled by setting their `setDisabled` configuration option
to `True`.

    ListItem.listItem
        (ListItem.config |> ListItem.setDisabled True)
        [ text "List item" ]


### Selected List Item

List items may be selected by setting their `setSelected` configuration option
to a value of `Selection`.

A list item that may change its selection state within the current page, should
be selected rather than activated.

As a rule of thumb, a navigation list item should be activated, while any other
list item should be selected.

    ListItem.listItem
        (ListItem.config
            |> ListItem.setSelected (Just ListItem.selected)
        )
        [ text "List item" ]

@docs Selection, selected


### Activated List Item

List items may be activated by setting their `setSelected` configuration option
to a value of `Selection`.

A list item that may not change its state within the current page should be
activated rather than selected.

As a rule of thumb, a navigation list item should be activated, while any other
list item should be selected.

    ListItem.listItem
        (ListItem.config
            |> ListItem.setSelected (Just ListItem.activated)
        )
        [ text "List item" ]

@docs activated


## Link List Item

List items may using the `setHref` configuration option in which case the list
item essentially behaves like a HTML anchor element. You may specify the
configuration option `setTarget` as well.

    ListItem.listItem
        (ListItem.config
            |> ListItem.setHref (Just "https://elm-lang.org")
        )
        [ text "Elm programming language" ]

Note that link list items cannot be disabled.

-}

import Html exposing (Html)
import Html.Attributes exposing (class)
import Html.Events
import Json.Decode as Decode
import Json.Encode as Encode
import Material.List.Item.Internal exposing (Config(..), ListItem(..), Selection(..))


{-| Configuration of a list item
-}
type alias Config msg =
    Material.List.Item.Internal.Config msg


{-| Default configuration of a list item
-}
config : Config msg
config =
    Config
        { disabled = False
        , selection = Nothing
        , href = Nothing
        , target = Nothing
        , additionalAttributes = []
        , onClick = Nothing
        , node = Html.text ""
        }


{-| Specify whtehr a list item should be disabled

Disabled list items cannot be interacted with and have not visual interaction
effect.

-}
setDisabled : Bool -> Config msg -> Config msg
setDisabled disabled (Config config_) =
    Config { config_ | disabled = disabled }


{-| Selection of a list item

A list item may be either in selected or in activated selection state.

-}
type alias Selection =
    Material.List.Item.Internal.Selection


{-| Selected selection state
-}
selected : Selection
selected =
    Selected


{-| Activated selection state
-}
activated : Selection
activated =
    Activated


{-| Specify whether a list item is selected

A selected list item may be either _selected_ or _activated_. A list item that
may change its selection state within the current page, should be selected. A
list item that may not change its state within the current page should be
activated.

As a rule of thumb, a navigation list item should be activated, while any other
list item should be selected.

-}
setSelected : Maybe Selection -> Config msg -> Config msg
setSelected selection (Config config_) =
    Config { config_ | selection = selection }


{-| Specify whether a list item is a _link list item_

Link list items essentially behave like a HTML5 anchor element.

-}
setHref : Maybe String -> Config msg -> Config msg
setHref href (Config config_) =
    Config { config_ | href = href }


{-| Specify a link list item's HTML5 target attribute

Note that non-link list items ignore this configuration option.

-}
setTarget : Maybe String -> Config msg -> Config msg
setTarget target (Config config_) =
    Config { config_ | target = target }


{-| Specify additional attributes
-}
setAttributes : List (Html.Attribute msg) -> Config msg -> Config msg
setAttributes additionalAttributes (Config config_) =
    Config
        { config_ | additionalAttributes = additionalAttributes }


{-| Specify a message when the user interacts with the list item
-}
setOnClick : msg -> Config msg -> Config msg
setOnClick onClick (Config config_) =
    Config
        { config_ | onClick = Just onClick }


{-| List item type

List items can only be rendered within a [list container](Material-List).

-}
type alias ListItem msg =
    Material.List.Item.Internal.ListItem msg


{-| List item constructor
-}
listItem : Config msg -> List (Html msg) -> ListItem msg
listItem (Config ({ additionalAttributes, href } as config_)) nodes =
    ListItem (Config { config_ | node = listItemView (Config config_) nodes })


listItemView : Config msg -> List (Html msg) -> Html msg
listItemView ((Config { additionalAttributes, href }) as config_) nodes =
    (\attributes ->
        if href /= Nothing then
            Html.node "mdc-list-item" [] [ Html.a attributes nodes ]

        else
            Html.node "mdc-list-item" attributes nodes
    )
        (List.filterMap identity
            [ listItemCs
            , hrefAttr config_
            , targetAttr config_
            , disabledCs config_
            , selectedCs config_
            , activatedCs config_
            , ariaSelectedAttr config_
            ]
            ++ additionalAttributes
        )


listItemCs : Maybe (Html.Attribute msg)
listItemCs =
    Just (class "mdc-list-item")


disabledCs : Config msg -> Maybe (Html.Attribute msg)
disabledCs (Config { disabled }) =
    if disabled then
        Just (class "mdc-list-item--disabled")

    else
        Nothing


selectedCs : Config msg -> Maybe (Html.Attribute msg)
selectedCs (Config { selection }) =
    if selection == Just Selected then
        Just (class "mdc-list-item--selected")

    else
        Nothing


activatedCs : Config msg -> Maybe (Html.Attribute msg)
activatedCs (Config { selection }) =
    if selection == Just Activated then
        Just (class "mdc-list-item--activated")

    else
        Nothing


ariaSelectedAttr : Config msg -> Maybe (Html.Attribute msg)
ariaSelectedAttr (Config { selection }) =
    if selection /= Nothing then
        Just (Html.Attributes.attribute "aria-selected" "true")

    else
        Nothing


hrefAttr : Config msg -> Maybe (Html.Attribute msg)
hrefAttr (Config { href }) =
    Maybe.map Html.Attributes.href href


targetAttr : Config msg -> Maybe (Html.Attribute msg)
targetAttr (Config { href, target }) =
    if href /= Nothing then
        Maybe.map Html.Attributes.target target

    else
        Nothing


{-| Two-line list item's text
-}
text :
    List (Html.Attribute msg)
    ->
        { primary : List (Html msg)
        , secondary : List (Html msg)
        }
    -> Html msg
text additionalAttributes { primary, secondary } =
    Html.div (class "mdc-list-item__text" :: additionalAttributes)
        [ primaryText [] primary
        , secondaryText [] secondary
        ]


primaryText : List (Html.Attribute msg) -> List (Html msg) -> Html msg
primaryText additionalAttributes nodes =
    Html.div (class "mdc-list-item__primary-text" :: additionalAttributes) nodes


secondaryText : List (Html.Attribute msg) -> List (Html msg) -> Html msg
secondaryText additionalAttributes nodes =
    Html.div (class "mdc-list-item__secondary-text" :: additionalAttributes) nodes


{-| A list item's graphic tile
-}
graphic : List (Html.Attribute msg) -> List (Html msg) -> Html msg
graphic additionalAttributes nodes =
    Html.div (class "mdc-list-item__graphic" :: additionalAttributes) nodes


{-| A list item's meta tile
-}
meta : List (Html.Attribute msg) -> List (Html msg) -> Html msg
meta additionalAttributes nodes =
    Html.div (class "mdc-list-item__meta" :: additionalAttributes) nodes
