module Material.List exposing
    ( Config
    , DividerConfig
    , divider
    , dividerConfig
    , graphic
    , group
    , groupDivider
    , groupSubheader
    , list
    , listConfig
    , listItem
    , listItemConfig
    , meta
    , primaryText
    , secondaryText
    , text
    )

import Html exposing (Html, text)
import Html.Attributes exposing (class)



-- TODO: Rename divider to listDivider, and dividerConfig to listDividerConfig
-- TODO: Rename groupDivider to listGroupDivider


type alias Config msg =
    { nonInteractive : Bool
    , dense : Bool
    , avatarList : Bool
    , twoLine : Bool
    , additionalAttributes : List (Html.Attribute msg)
    }


listConfig : Config msg
listConfig =
    { nonInteractive = False
    , dense = False
    , avatarList = False
    , twoLine = False
    , additionalAttributes = []
    }


list : Config msg -> List (Html msg) -> Html msg
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


nonInteractiveCs : Config msg -> Maybe (Html.Attribute msg)
nonInteractiveCs { nonInteractive } =
    if nonInteractive then
        Just (class "mdc-list--non-interactive")

    else
        Nothing


denseCs : Config msg -> Maybe (Html.Attribute msg)
denseCs { dense } =
    if dense then
        Just (class "mdc-list--dense")

    else
        Nothing


avatarListCs : Config msg -> Maybe (Html.Attribute msg)
avatarListCs { avatarList } =
    if avatarList then
        Just (class "mdc-list--avatar-list")

    else
        Nothing


twoLineCs : Config msg -> Maybe (Html.Attribute msg)
twoLineCs { twoLine } =
    if twoLine then
        Just (class "mdc-list--two-line")

    else
        Nothing


type alias ListItemConfig msg =
    { disabled : Bool
    , selected : Bool
    , activated : Bool
    , additionalAttributes : List (Html.Attribute msg)
    }


listItemConfig : ListItemConfig msg
listItemConfig =
    { disabled = False
    , selected = False
    , activated = False
    , additionalAttributes = []
    }


listItem : ListItemConfig msg -> List (Html msg) -> Html msg
listItem config nodes =
    Html.li
        (List.filterMap identity
            [ listItemCs
            , disabledCs config
            , selectedCs config
            , activatedCs config
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


text : List (Html.Attribute msg) -> List (Html msg) -> Html msg
text attributes nodes =
    Html.div (class "mdc-list-item__text" :: attributes) nodes


primaryText : List (Html.Attribute msg) -> List (Html msg) -> Html msg
primaryText attributes nodes =
    Html.div (class "mdc-list-item__primary-text" :: attributes) nodes


secondaryText : List (Html.Attribute msg) -> List (Html msg) -> Html msg
secondaryText attributes nodes =
    Html.div (class "mdc-list-item__secondary-text" :: attributes) nodes


graphic : List (Html.Attribute msg) -> List (Html msg) -> Html msg
graphic attributes nodes =
    Html.div (class "mdc-list-item__graphic" :: attributes) nodes


meta : List (Html.Attribute msg) -> List (Html msg) -> Html msg
meta attributes nodes =
    Html.div (class "mdc-list-item__meta" :: attributes) nodes


type alias DividerConfig msg =
    { inset : Bool
    , padded : Bool
    , additionalAttributes : List (Html.Attribute msg)
    }


dividerConfig : DividerConfig msg
dividerConfig =
    { inset = False
    , padded = False
    , additionalAttributes = []
    }


divider : DividerConfig msg -> Html msg
divider config =
    Html.li
        (List.filterMap identity
            [ dividerCs
            , separatorRoleAttr
            , insetCs config
            , paddedCs config
            ]
            ++ config.additionalAttributes
        )
        []


dividerCs : Maybe (Html.Attribute msg)
dividerCs =
    Just (class "mdc-list-divider")


separatorRoleAttr : Maybe (Html.Attribute msg)
separatorRoleAttr =
    Just (Html.Attributes.attribute "role" "separator")


insetCs : DividerConfig msg -> Maybe (Html.Attribute msg)
insetCs { inset } =
    if inset then
        Just (class "mdc-list-divider--inset")

    else
        Nothing


paddedCs : DividerConfig msg -> Maybe (Html.Attribute msg)
paddedCs { padded } =
    if padded then
        Just (class "mdc-list-divider--padded")

    else
        Nothing


group : List (Html.Attribute msg) -> List (Html msg) -> Html msg
group attributes nodes =
    Html.div (groupCs :: attributes) nodes


groupCs : Html.Attribute msg
groupCs =
    class "mdc-list-group"


groupDivider : List (Html.Attribute msg) -> Html msg
groupDivider additionalAttributes =
    Html.hr (List.filterMap identity [ dividerCs ] ++ additionalAttributes) []


groupSubheader : List (Html.Attribute msg) -> List (Html msg) -> Html msg
groupSubheader attributes nodes =
    Html.div attributes nodes


subHeaderCs : Html.Attribute msg
subHeaderCs =
    class "mdc-list-group__subheader"
