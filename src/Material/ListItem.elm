module Material.ListItem exposing
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
    import Material.ListItem as ListItem

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

In addition to their text child, lists may optionally contain a starting tile
referred to as _graphic_ and/ or a last tile referred to as _meta_.

Common examples for graphics are icons and images, avatar images and selection
controls such as checkboxes.

    ListItem.listItem ListItem.config
        [ ListItem.graphic [] [ Icon.icon Icon.config "star" ]
        , text "List item"
        ]

@docs graphic


# List Item with Meta

In addition to their text child, lists may optionally contain a starting tile
referred to as _graphic_ and/ or a last tile referred to as _meta_.

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

List items may be disabled by using their `setDisabled` configuration option.

    ListItem.listItem
        (ListItem.config
            |> ListItem.setDisabled True
        )
        [ text "List item" ]


### Selected List Item

List items may be selected by using their `setSelected` configuration option.

    ListItem.listItem
        (ListItem.config
            |> ListItem.setSelected (Just ListItem.selected)
        )
        [ text "List item" ]

@docs Selection, selected


### Activated List Item

List items may be activated by using their `setSelected` configuration option.

    ListItem.listItem
        (ListItem.config
            |> ListItem.setSelected (Just ListItem.activated)
        )
        [ text "List item" ]

@docs activated


## Link List Item

List items may using the `setHref` configuration option in which case the list
item essentially behaves like a HTML `a` element. You may specify the
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
import Material.ListItem.Internal


{-| Configuration of a list item
-}
type alias Config msg =
    Material.ListItem.Internal.Config msg


{-| Default configuration of a list item
-}
config : Config msg
config =
    Material.ListItem.Internal.Config
        { disabled = False
        , selection = Nothing
        , href = Nothing
        , target = Nothing
        , additionalAttributes = []
        , onClick = Nothing
        , node = Html.text ""
        }


{-| Set a list item to be disabled
-}
setDisabled : Bool -> Config msg -> Config msg
setDisabled disabled (Material.ListItem.Internal.Config config_) =
    Material.ListItem.Internal.Config { config_ | disabled = disabled }


{-| Selection state of a list item.

A list item may be either in selected or in activated selection state.

-}
type alias Selection =
    Material.ListItem.Internal.Selection


{-| Selection state that sets a list item to be selected
-}
selected : Selection
selected =
    Material.ListItem.Internal.Selected


{-| Selection state that sets a list item to be activated
-}
activated : Selection
activated =
    Material.ListItem.Internal.Activated


{-| Set a list item to be activated
-}
setSelected : Maybe Selection -> Config msg -> Config msg
setSelected selection (Material.ListItem.Internal.Config config_) =
    Material.ListItem.Internal.Config { config_ | selection = selection }


{-| Set a link list item's HTML5 href attribute
-}
setHref : Maybe String -> Config msg -> Config msg
setHref href (Material.ListItem.Internal.Config config_) =
    Material.ListItem.Internal.Config { config_ | href = href }


{-| Set a link list item's HTML5 target attribute
-}
setTarget : Maybe String -> Config msg -> Config msg
setTarget target (Material.ListItem.Internal.Config config_) =
    Material.ListItem.Internal.Config { config_ | target = target }


{-| Specify additional attributes
-}
setAttributes : List (Html.Attribute msg) -> Config msg -> Config msg
setAttributes additionalAttributes (Material.ListItem.Internal.Config config_) =
    Material.ListItem.Internal.Config
        { config_ | additionalAttributes = additionalAttributes }


{-| Specify a message when the user interacts with the list item
-}
setOnClick : msg -> Config msg -> Config msg
setOnClick onClick (Material.ListItem.Internal.Config config_) =
    Material.ListItem.Internal.Config
        { config_ | onClick = Just onClick }


{-| Type of a list item
-}
type alias ListItem msg =
    Material.ListItem.Internal.ListItem msg


{-| List item view function
-}
listItem : Config msg -> List (Html msg) -> ListItem msg
listItem (Material.ListItem.Internal.Config ({ additionalAttributes, href } as config_)) nodes =
    Material.ListItem.Internal.ListItem
        (Material.ListItem.Internal.Config
            { config_
                | node = listItemView (Material.ListItem.Internal.Config config_) nodes
            }
        )


listItemView : Config msg -> List (Html msg) -> Html msg
listItemView ((Material.ListItem.Internal.Config { additionalAttributes, href }) as config_) nodes =
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
disabledCs (Material.ListItem.Internal.Config { disabled }) =
    if disabled then
        Just (class "mdc-list-item--disabled")

    else
        Nothing


selectedCs : Config msg -> Maybe (Html.Attribute msg)
selectedCs (Material.ListItem.Internal.Config { selection }) =
    if selection == Just Material.ListItem.Internal.Selected then
        Just (class "mdc-list-item--selected")

    else
        Nothing


activatedCs : Config msg -> Maybe (Html.Attribute msg)
activatedCs (Material.ListItem.Internal.Config { selection }) =
    if selection == Just Material.ListItem.Internal.Activated then
        Just (class "mdc-list-item--activated")

    else
        Nothing


ariaSelectedAttr : Config msg -> Maybe (Html.Attribute msg)
ariaSelectedAttr (Material.ListItem.Internal.Config { selection }) =
    if selection /= Nothing then
        Just (Html.Attributes.attribute "aria-selected" "true")

    else
        Nothing


hrefAttr : Config msg -> Maybe (Html.Attribute msg)
hrefAttr (Material.ListItem.Internal.Config { href }) =
    Maybe.map Html.Attributes.href href


targetAttr : Config msg -> Maybe (Html.Attribute msg)
targetAttr (Material.ListItem.Internal.Config { href, target }) =
    if href /= Nothing then
        Maybe.map Html.Attributes.target target

    else
        Nothing


{-| List item's text for list items in a two-line list
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
