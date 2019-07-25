module Material.List exposing
    ( ListConfig, listConfig
    , list
    , ListItemConfig, listItemConfig
    , listItem
    , listItemText, listItemPrimaryText, listItemSecondaryText
    , listItemGraphic, listItemMeta
    , ListItemDividerConfig, listItemDividerConfig
    , listItemDivider
    , listGroup
    , listGroupSubheader
    , listGroupDivider
    )

{-|

@docs ListConfig, listConfig
@docs list

@docs ListItemConfig, listItemConfig
@docs listItem
@docs listItemText, listItemPrimaryText, listItemSecondaryText
@docs listItemGraphic, listItemMeta

@docs ListItemDividerConfig, listItemDividerConfig
@docs listItemDivider

@docs listGroup
@docs listGroupSubheader

@docs listGroupDivider

-}

import Html exposing (Html, text)
import Html.Attributes exposing (class)
import Html.Events
import Json.Decode as Decode


{-| TODO docs
-}
type alias ListConfig msg =
    { nonInteractive : Bool
    , dense : Bool
    , avatarList : Bool
    , twoLine : Bool
    , additionalAttributes : List (Html.Attribute msg)
    }


{-| TODO docs
-}
listConfig : ListConfig msg
listConfig =
    { nonInteractive = False
    , dense = False
    , avatarList = False
    , twoLine = False
    , additionalAttributes = []
    }


{-| TODO docs
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


{-| TODO docs
-}
type alias ListItemConfig msg =
    { disabled : Bool
    , selected : Bool
    , activated : Bool
    , additionalAttributes : List (Html.Attribute msg)
    , onClick : Maybe msg
    }


{-| TODO docs
-}
listItemConfig : ListItemConfig msg
listItemConfig =
    { disabled = False
    , selected = False
    , activated = False
    , additionalAttributes = []
    , onClick = Nothing
    }


{-| TODO docs
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
            , keydownHandler config
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
    Maybe.map Html.Events.onClick onClick


keydownHandler : ListItemConfig msg -> Maybe (Html.Attribute msg)
keydownHandler { onClick } =
    Maybe.map
        (\msg ->
            Html.Events.on "keydown"
                (Html.Events.keyCode
                    |> Decode.andThen
                        (\keyCode ->
                            if (keyCode == 32) || (keyCode == 13) then
                                Decode.succeed msg

                            else
                                Decode.fail ""
                        )
                )
        )
        onClick


{-| TODO docs
-}
listItemText : List (Html.Attribute msg) -> List (Html msg) -> Html msg
listItemText additionalAttributes nodes =
    Html.div (class "mdc-list-item__text" :: additionalAttributes) nodes


{-| TODO docs
-}
listItemPrimaryText : List (Html.Attribute msg) -> List (Html msg) -> Html msg
listItemPrimaryText additionalAttributes nodes =
    Html.div (class "mdc-list-item__primary-text" :: additionalAttributes) nodes


{-| TODO docs
-}
listItemSecondaryText : List (Html.Attribute msg) -> List (Html msg) -> Html msg
listItemSecondaryText additionalAttributes nodes =
    Html.div (class "mdc-list-item__secondary-text" :: additionalAttributes) nodes


{-| TODO docs
-}
listItemGraphic : List (Html.Attribute msg) -> List (Html msg) -> Html msg
listItemGraphic additionalAttributes nodes =
    Html.div (class "mdc-list-item__graphic" :: additionalAttributes) nodes


{-| TODO docs
-}
listItemMeta : List (Html.Attribute msg) -> List (Html msg) -> Html msg
listItemMeta additionalAttributes nodes =
    Html.div (class "mdc-list-item__meta" :: additionalAttributes) nodes


{-| TODO docs
-}
type alias ListItemDividerConfig msg =
    { inset : Bool
    , padded : Bool
    , additionalAttributes : List (Html.Attribute msg)
    }


{-| TODO docs
-}
listItemDividerConfig : ListItemDividerConfig msg
listItemDividerConfig =
    { inset = False
    , padded = False
    , additionalAttributes = []
    }


{-| TODO docs
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


{-| TODO docs
-}
listGroup : List (Html.Attribute msg) -> List (Html msg) -> Html msg
listGroup additionalAttributes nodes =
    Html.div (listGroupCs :: additionalAttributes) nodes


listGroupCs : Html.Attribute msg
listGroupCs =
    class "mdc-list-group"


{-| TODO docs
-}
listGroupDivider : List (Html.Attribute msg) -> Html msg
listGroupDivider additionalAttributes =
    Html.hr (List.filterMap identity [ listDividerCs ] ++ additionalAttributes) []


{-| TODO docs
-}
listGroupSubheader : List (Html.Attribute msg) -> List (Html msg) -> Html msg
listGroupSubheader additionalAttributes nodes =
    Html.div (listGroupSubheaderCs :: additionalAttributes) nodes


listGroupSubheaderCs : Html.Attribute msg
listGroupSubheaderCs =
    class "mdc-list-group__subheader"
