module Demo.Lists exposing (Model, Msg, defaultModel, update, view)

import Demo.CatalogPage exposing (CatalogPage)
import Demo.Helper.ResourceLink as ResourceLink
import Html exposing (Html, text)
import Html.Attributes
import Html.Events
import Json.Decode as Decode
import Material.Checkbox as Checkbox exposing (checkbox, checkboxConfig)
import Material.Icon exposing (icon, iconConfig)
import Material.List exposing (list, listConfig, listGroup, listGroupSubheader, listItem, listItemConfig, listItemDivider, listItemDividerConfig, listItemGraphic, listItemMeta, listItemPrimaryText, listItemSecondaryText, listItemText)
import Material.Radio exposing (radio, radioConfig)
import Material.Typography as Typography
import Set exposing (Set)


type alias Model =
    { checkboxIndices : Set Int
    , radioIndex : Maybe Int
    , activatedIndex : Int
    , shapedActivatedIndex : Int
    }


defaultModel : Model
defaultModel =
    { checkboxIndices = Set.empty
    , radioIndex = Nothing
    , activatedIndex = 1
    , shapedActivatedIndex = 1
    }


type Msg
    = ToggleCheckbox Int
    | SetRadio Int
    | SetActivated Int
    | SetShapedActivated Int


update : Msg -> Model -> Model
update msg model =
    case msg of
        ToggleCheckbox index ->
            { model
                | checkboxIndices =
                    if Set.member index model.checkboxIndices then
                        Set.remove index model.checkboxIndices

                    else
                        Set.insert index model.checkboxIndices
            }

        SetRadio index ->
            { model | radioIndex = Just index }

        SetActivated index ->
            { model | activatedIndex = index }

        SetShapedActivated index ->
            { model | shapedActivatedIndex = index }


view : Model -> CatalogPage Msg
view model =
    { title = "List"
    , prelude = "Lists present multiple line items vertically as a single continuous element."
    , resources =
        { materialDesignGuidelines = Just "https://material.io/go/design-lists"
        , documentation = Just "https://package.elm-lang.org/packages/aforemny/material-components-web-elm/latest/Material-List"
        , sourceCode = Just "https://github.com/material-components/material-components-web/tree/master/packages/mdc-list"
        }
    , hero = heroList
    , content =
        [ Html.h3 [ Typography.subtitle1 ] [ text "Single-Line" ]
        , singleLineList
        , Html.h3 [ Typography.subtitle1 ] [ text "Two-Line" ]
        , twoLineList
        , Html.h3 [ Typography.subtitle1 ] [ text "Leading Icon" ]
        , leadingIconList
        , Html.h3 [ Typography.subtitle1 ] [ text "List with activated item" ]
        , activatedItemList model
        , Html.h3 [ Typography.subtitle1 ] [ text "List with shaped activated item" ]
        , shapedActivatedItemList model
        , Html.h3 [ Typography.subtitle1 ] [ text "Trailing Icon" ]
        , trailingIconList
        , Html.h3 [ Typography.subtitle1 ]
            [ text "Two-Line with Leading and Trailing Icon and Divider" ]
        , folderList
        , Html.h3 [ Typography.subtitle1 ] [ text "List with Trailing Checkbox" ]
        , listWithTrailingCheckbox model
        , Html.h3 [ Typography.subtitle1 ] [ text "List with Trailing Radio Buttons" ]
        , listWithTrailingRadioButton model
        ]
    }


demoList : List (Html.Attribute msg)
demoList =
    [ Html.Attributes.style "max-width" "600px"
    , Html.Attributes.style "border" "1px solid rgba(0,0,0,.1)"
    ]


heroList : List (Html msg)
heroList =
    [ list
        { listConfig
            | additionalAttributes = Html.Attributes.style "background" "#fff" :: demoList
        }
        (List.repeat 3 <| listItem listItemConfig [ text "Line item" ])
    ]


singleLineList : Html msg
singleLineList =
    list { listConfig | additionalAttributes = demoList }
        (List.repeat 3 <| listItem listItemConfig [ text "Line item" ])


twoLineList : Html msg
twoLineList =
    list
        { listConfig
            | twoLine = True
            , additionalAttributes = demoList
        }
        (List.repeat 3 <|
            listItem listItemConfig
                [ listItemText []
                    [ listItemPrimaryText [] [ text "Line item" ]
                    , listItemSecondaryText [] [ text "Secondary text" ]
                    ]
                ]
        )


leadingIconList : Html msg
leadingIconList =
    list { listConfig | additionalAttributes = demoList }
        [ listItem listItemConfig
            [ listItemGraphic [] [ icon iconConfig "wifi" ]
            , text "Line item"
            ]
        , listItem listItemConfig
            [ listItemGraphic [] [ icon iconConfig "bluetooth" ]
            , text "Line item"
            ]
        , listItem listItemConfig
            [ listItemGraphic [] [ icon iconConfig "data_usage" ]
            , text "Line item"
            ]
        ]


trailingIconList : Html msg
trailingIconList =
    list { listConfig | additionalAttributes = demoList }
        (List.repeat 3 <|
            listItem listItemConfig
                [ text "Line item"
                , listItemMeta [] [ icon iconConfig "info" ]
                ]
        )


activatedItemList : Model -> Html Msg
activatedItemList model =
    let
        listItemConfig_ index =
            { listItemConfig
                | activated = model.activatedIndex == index
                , onClick = Just (SetActivated index)
            }
    in
    list { listConfig | additionalAttributes = demoList }
        [ listItem (listItemConfig_ 0)
            [ listItemGraphic [] [ icon iconConfig "inbox" ], text "Inbox" ]
        , listItem (listItemConfig_ 1)
            [ listItemGraphic [] [ icon iconConfig "star" ], text "Star" ]
        , listItem (listItemConfig_ 2)
            [ listItemGraphic [] [ icon iconConfig "send" ], text "Sent" ]
        , listItem (listItemConfig_ 3)
            [ listItemGraphic [] [ icon iconConfig "drafts" ], text "Drafts" ]
        ]


shapedActivatedItemList : Model -> Html Msg
shapedActivatedItemList model =
    let
        listItemConfig_ index =
            { listItemConfig
                | activated = model.shapedActivatedIndex == index
                , onClick = Just (SetShapedActivated index)
                , additionalAttributes =
                    [ Html.Attributes.style "border-radius" "0 32px 32px 0" ]
            }
    in
    list { listConfig | additionalAttributes = demoList }
        [ listItem (listItemConfig_ 0)
            [ listItemGraphic [] [ icon iconConfig "inbox" ], text "Inbox" ]
        , listItem (listItemConfig_ 1)
            [ listItemGraphic [] [ icon iconConfig "star" ], text "Star" ]
        , listItem (listItemConfig_ 2)
            [ listItemGraphic [] [ icon iconConfig "send" ], text "Sent" ]
        , listItem (listItemConfig_ 3)
            [ listItemGraphic [] [ icon iconConfig "drafts" ], text "Drafts" ]
        ]


demoIcon : List (Html.Attribute msg)
demoIcon =
    [ Html.Attributes.style "background" "rgba(0,0,0,.3)"
    , Html.Attributes.style "border-radius" "50%"
    , Html.Attributes.style "color" "#fff"
    ]


folderList : Html msg
folderList =
    list
        { listConfig
            | avatarList = True
            , twoLine = True
            , additionalAttributes = demoList
        }
        [ listItem listItemConfig
            [ listItemGraphic demoIcon [ icon iconConfig "folder" ]
            , listItemText []
                [ listItemPrimaryText [] [ text "Dog Photos" ]
                , listItemSecondaryText [] [ text "9 Jan 2018" ]
                ]
            , listItemMeta [] [ icon iconConfig "info" ]
            ]
        , listItem listItemConfig
            [ listItemGraphic demoIcon [ icon iconConfig "folder" ]
            , listItemText []
                [ listItemPrimaryText [] [ text "Cat Photos" ]
                , listItemSecondaryText [] [ text "22 Dec 2017" ]
                ]
            , listItemMeta [] [ icon iconConfig "info" ]
            ]
        , listItemDivider listItemDividerConfig
        , listItem listItemConfig
            [ listItemGraphic demoIcon [ icon iconConfig "folder" ]
            , listItemText []
                [ listItemPrimaryText [] [ text "Potatoes" ]
                , listItemSecondaryText [] [ text "30 Noc 2017" ]
                ]
            , listItemMeta [] [ icon iconConfig "info" ]
            ]
        , listItem listItemConfig
            [ listItemGraphic demoIcon [ icon iconConfig "folder" ]
            , listItemText []
                [ listItemPrimaryText [] [ text "Carrots" ]
                , listItemSecondaryText [] [ text "17 Oct 2017" ]
                ]
            , listItemMeta [] [ icon iconConfig "info" ]
            ]
        ]


listWithTrailingCheckbox : Model -> Html Msg
listWithTrailingCheckbox model =
    let
        listItemConfig_ index =
            { listItemConfig | selected = Set.member index model.checkboxIndices }

        checkbox_ index =
            checkbox
                { checkboxConfig
                    | onChange = Just (ToggleCheckbox index)
                    , state =
                        if Set.member index model.checkboxIndices then
                            Checkbox.Checked

                        else
                            Checkbox.Unchecked
                }
    in
    list
        { listConfig
            | additionalAttributes =
                [ Html.Attributes.attribute "role" "group"
                ]
                    ++ demoList
        }
        [ listItem (listItemConfig_ 0)
            [ text "Dog Photos"
            , listItemMeta [] [ checkbox_ 0 ]
            ]
        , listItem (listItemConfig_ 1)
            [ text "Cat Photos"
            , listItemMeta [] [ checkbox_ 1 ]
            ]
        , listItem (listItemConfig_ 2)
            [ text "Potatoes"
            , listItemMeta [] [ checkbox_ 2 ]
            ]
        , listItem (listItemConfig_ 3)
            [ text "Carrots"
            , listItemMeta [] [ checkbox_ 3 ]
            ]
        ]


listWithTrailingRadioButton : Model -> Html Msg
listWithTrailingRadioButton model =
    let
        listItemConfig_ index =
            { listItemConfig | selected = model.radioIndex == Just index }

        radio_ index =
            radio
                { radioConfig
                    | checked = model.radioIndex == Just index
                    , onChange = Just (SetRadio index)
                }
    in
    list { listConfig | additionalAttributes = demoList }
        [ listItem (listItemConfig_ 0)
            [ text "Dog Photos"
            , listItemMeta [] [ radio_ 0 ]
            ]
        , listItem (listItemConfig_ 1)
            [ text "Cat Photos"
            , listItemMeta [] [ radio_ 1 ]
            ]
        , listItem (listItemConfig_ 2)
            [ text "Potatoes"
            , listItemMeta [] [ radio_ 2 ]
            ]
        , listItem (listItemConfig_ 3)
            [ text "Carrots"
            , listItemMeta [] [ radio_ 3 ]
            ]
        ]
