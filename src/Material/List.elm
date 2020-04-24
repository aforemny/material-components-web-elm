module Material.List exposing
    ( Config, config
    , setNonInteractive
    , setDense
    , setAvatarList
    , setTwoLine
    , setAttributes
    , setWrapFocus
    , list
    , group, subheader
    )

{-| Lists are continuous, vertical indexes of text or images.


# Table of Contents

  - [Resources](#resources)
  - [Basic Usage](#basic-usage)
  - [Configuration](#configuration)
      - [Configuration Options](#configuration-options)
  - [List](#list)
  - [Two-Line List](#two-line-list)
  - [Non-interactive List](#non-interactive-list)
  - [Dense List](#dense-list)
  - [Avatar List](#avatar-list)
  - [List Group](#list-group)
      - [List Group Divider](#list-group-divider)


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
            , ListItem.listItem ListItem.config
                [ text "Line item" ]
            ]


# Configuration

@docs Config, config


## Configuration Options

@docs setNonInteractive
@docs setDense
@docs setAvatarList
@docs setTwoLine
@docs setAttributes
@docs setWrapFocus


# List

@docs list


# Two-Line List

Lists may be two-line lists by settings the `twoLine` configuration field to
`True`. In that case, list items should wrap their contents inside
`listItemText` and their first line in `listItemPrimaryText` and their second
line in `listItemSecondaryText`.

    List.list
        (List.config
            |> List.setTwoLine True
        )
        [ ListItem.listItem ListItem.config
            [ ListItem.text []
                [ ListItem.primaryText []
                    [ text "First line" ]
                , ListItem.secondaryText []
                    [ text "Second line" ]
                ]
            ]
        ]


# Non-interactive List

Lists may be non-interactive by setting use `setNonInteractive` configuration
option.

    List.list
        (List.config
            |> List.setNonInteractive True
        )
        [ ListItem.listItem ListItem.config [ text "List item" ] ]


## Dense List

Lists may be styled more compact by using the `setDense` configuration option.

    List.list
        (List.config
            |> List.setDense True
        )
        [ ListItem.listItem ListItem.config [ text "List item" ] ]


## Avatar List

List item's graphics may be configured to appear larger by using the
`setAvatarList` configuration option.

This is particularly useful when a list item's graphic includes an image rather
than an icon.

    List.list
        (List.config
            |> List.setAvatarList True
        )
        [ ListItem.listItem ListItem.config
            [ ListItem.graphic [] [ Html.img [] [] ]
            , text "List item"
            ]
        ]


## List Group

Multiple related lists, such as folders and files in a file hierarchy, may be
grouped using `listGroup` and labeled by `listGroupSubheader`.

    List.group []
        [ List.subheader [] [ text "Folders" ]
        , List.list List.config
            [ ListItem.listItem ListItem.config
                [ text "Folder" ]
            , ListItem.listItem ListItem.config
                [ text "Folder" ]
            ]
        , List.subheader [] [ text "Files" ]
        , List.list List.config
            [ ListItem.listItem ListItem.config
                [ text "File" ]
            , ListItem.listItem ListItem.config
                [ text "File" ]
            ]
        ]

@docs group, subheader

-}

import Html exposing (Html, text)
import Html.Attributes exposing (class)
import Html.Events
import Json.Decode as Decode
import Json.Encode as Encode
import Material.List.Item exposing (Config, ListItem)
import Material.List.Item.Internal as ListItem


{-| Configuration of a list
-}
type Config msg
    = Config
        { nonInteractive : Bool
        , dense : Bool
        , avatarList : Bool
        , twoLine : Bool
        , vertical : Bool
        , wrapFocus : Bool
        , additionalAttributes : List (Html.Attribute msg)
        }


{-| Default configuration of a list
-}
config : Config msg
config =
    Config
        { nonInteractive = False
        , dense = False
        , avatarList = False
        , twoLine = False
        , vertical = False
        , wrapFocus = False
        , additionalAttributes = []
        }


{-| Set a list to be non-interactive
-}
setNonInteractive : Bool -> Config msg -> Config msg
setNonInteractive nonInteractive (Config config_) =
    Config { config_ | nonInteractive = nonInteractive }


{-| Set a list to be dense
-}
setDense : Bool -> Config msg -> Config msg
setDense dense (Config config_) =
    Config { config_ | dense = dense }


{-| Set a list to be an avatar list
-}
setAvatarList : Bool -> Config msg -> Config msg
setAvatarList avatarList (Config config_) =
    Config { config_ | avatarList = avatarList }


{-| Set a list to be a two line list
-}
setTwoLine : Bool -> Config msg -> Config msg
setTwoLine twoLine (Config config_) =
    Config { config_ | twoLine = twoLine }


{-| TODO: Document setVertical
-}
setVertical : Bool -> Config msg -> Config msg
setVertical vertical (Config config_) =
    Config { config_ | vertical = vertical }


{-| TODO: Document setWrapFocus
-}
setWrapFocus : Bool -> Config msg -> Config msg
setWrapFocus wrapFocus (Config config_) =
    Config { config_ | wrapFocus = wrapFocus }


{-| Specify additional attributes
-}
setAttributes : List (Html.Attribute msg) -> Config msg -> Config msg
setAttributes additionalAttributes (Config config_) =
    Config { config_ | additionalAttributes = additionalAttributes }


{-| List view function
-}
list : Config msg -> List (ListItem msg) -> Html msg
list ((Config { additionalAttributes }) as config_) listItems =
    Html.node "mdc-list"
        (List.filterMap identity
            [ rootCs
            , nonInteractiveCs config_
            , denseCs config_
            , avatarListCs config_
            , twoLineCs config_
            , wrapFocusProp config_
            , clickHandler listItems
            , selectedIndexProp listItems
            ]
            ++ additionalAttributes
        )
        (List.map
            (\listItem_ ->
                case listItem_ of
                    ListItem.ListItem (ListItem.Config { node }) ->
                        node

                    ListItem.ListItemDivider node ->
                        node

                    ListItem.ListGroupSubheader node ->
                        node
            )
            listItems
        )


rootCs : Maybe (Html.Attribute msg)
rootCs =
    Just (class "mdc-list")


nonInteractiveCs : Config msg -> Maybe (Html.Attribute msg)
nonInteractiveCs (Config { nonInteractive }) =
    if nonInteractive then
        Just (class "mdc-list--non-interactive")

    else
        Nothing


denseCs : Config msg -> Maybe (Html.Attribute msg)
denseCs (Config { dense }) =
    if dense then
        Just (class "mdc-list--dense")

    else
        Nothing


avatarListCs : Config msg -> Maybe (Html.Attribute msg)
avatarListCs (Config { avatarList }) =
    if avatarList then
        Just (class "mdc-list--avatar-list")

    else
        Nothing


twoLineCs : Config msg -> Maybe (Html.Attribute msg)
twoLineCs (Config { twoLine }) =
    if twoLine then
        Just (class "mdc-list--two-line")

    else
        Nothing


clickHandler : List (ListItem msg) -> Maybe (Html.Attribute msg)
clickHandler listItems =
    let
        getOnClick listItem_ =
            case listItem_ of
                ListItem.ListItem (ListItem.Config { onClick }) ->
                    Just onClick

                ListItem.ListItemDivider _ ->
                    Nothing

                ListItem.ListGroupSubheader _ ->
                    Nothing

        nthOnClick index =
            listItems
                |> List.map getOnClick
                |> List.filterMap identity
                |> List.drop index
                |> List.head
                |> Maybe.andThen identity

        mergedClickHandler =
            Decode.at [ "detail", "index" ] Decode.int
                |> Decode.andThen
                    (\index ->
                        case nthOnClick index of
                            Just msg_ ->
                                Decode.succeed msg_

                            Nothing ->
                                Decode.fail ""
                    )
    in
    Just (Html.Events.on "MDCList:action" mergedClickHandler)


selectedIndexProp : List (ListItem msg) -> Maybe (Html.Attribute msg)
selectedIndexProp listItems =
    let
        selectedIndex =
            listItems
                |> List.filter
                    (\listItem_ ->
                        case listItem_ of
                            ListItem.ListItem _ ->
                                True

                            ListItem.ListItemDivider _ ->
                                False

                            ListItem.ListGroupSubheader _ ->
                                False
                    )
                |> List.indexedMap
                    (\index listItem_ ->
                        case listItem_ of
                            ListItem.ListItem (ListItem.Config { selection }) ->
                                if selection /= Nothing then
                                    Just index

                                else
                                    Nothing

                            ListItem.ListItemDivider _ ->
                                Nothing

                            ListItem.ListGroupSubheader _ ->
                                Nothing
                    )
                |> List.filterMap identity
    in
    Just (Html.Attributes.property "selectedIndex" (Encode.list Encode.int selectedIndex))


{-| List group view function
-}
group : List (Html.Attribute msg) -> List (Html msg) -> Html msg
group additionalAttributes nodes =
    Html.div (listGroupCs :: additionalAttributes) nodes


listGroupCs : Html.Attribute msg
listGroupCs =
    class "mdc-list-group"


{-| List group subheader view function
-}
subheader : List (Html.Attribute msg) -> List (Html msg) -> ListItem msg
subheader additionalAttributes nodes =
    ListItem.ListGroupSubheader <|
        Html.div (listGroupSubheaderCs :: additionalAttributes) nodes


listGroupSubheaderCs : Html.Attribute msg
listGroupSubheaderCs =
    class "mdc-list-group__subheader"


wrapFocusProp : Config msg -> Maybe (Html.Attribute msg)
wrapFocusProp (Config { wrapFocus }) =
    Just (Html.Attributes.property "wrapFocus" (Encode.bool wrapFocus))
