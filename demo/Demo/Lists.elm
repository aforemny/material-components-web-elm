module Demo.Lists exposing (Model, Msg, defaultModel, update, view)

import Demo.Helper.ResourceLink as ResourceLink
import Demo.Page as Page exposing (Page)
import Html exposing (Html, text)
import Html.Attributes
import Html.Events
import Json.Decode as Decode
import Material.Checkbox as Checkbox exposing (checkbox, checkboxConfig)
import Material.Icon as Icon exposing (icon, iconConfig)
import Material.List as Lists exposing (list, listConfig, listGroup, listGroupSubheader, listItem, listItemConfig, listItemDivider, listItemDividerConfig, listItemGraphic, listItemMeta, listItemPrimaryText, listItemSecondaryText, listItemText)
import Material.Radio as Radio exposing (radio, radioConfig)
import Material.Ripple as Ripple
import Material.Typography as Typography
import Set exposing (Set)


type alias Model =
    { checkboxIndices : Set Int
    , radioIndex : Int
    , activatedIndex : Int
    , shapedActivatedIndex : Int
    }


defaultModel : Model
defaultModel =
    { checkboxIndices = Set.empty
    , radioIndex = 3
    , activatedIndex = 1
    , shapedActivatedIndex = 1
    }


type Msg
    = NoOp
    | ToggleCheckbox Int
    | SetRadio Int
    | SetActivated Int
    | SetShapedActivated Int


update : (Msg -> m) -> Msg -> Model -> ( Model, Cmd m )
update lift msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )

        ToggleCheckbox index ->
            ( { model
                | checkboxIndices =
                    if Set.member index model.checkboxIndices then
                        Set.remove index model.checkboxIndices

                    else
                        Set.insert index model.checkboxIndices
              }
            , Cmd.none
            )

        SetRadio index ->
            ( { model | radioIndex = index }, Cmd.none )

        SetActivated index ->
            ( { model | activatedIndex = index }, Cmd.none )

        SetShapedActivated index ->
            ( { model | shapedActivatedIndex = index }, Cmd.none )


demoList : List (Html.Attribute m)
demoList =
    [ Html.Attributes.style "max-width" "600px"
    , Html.Attributes.style "border" "1px solid rgba(0,0,0,.1)"
    ]


heroList : Html m
heroList =
    list
        { listConfig
            | additionalAttributes = Html.Attributes.style "background" "#fff" :: demoList
        }
        (List.repeat 3 <| listItem listItemConfig [ text "Line item" ])


singleLineList : Html m
singleLineList =
    list { listConfig | additionalAttributes = demoList }
        (List.repeat 3 <| listItem listItemConfig [ text "Line item" ])


twoLineList : Html m
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


leadingIconList : Html m
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


trailingIconList : Html m
trailingIconList =
    list { listConfig | additionalAttributes = demoList }
        (List.repeat 3 <|
            listItem listItemConfig
                [ text "Line item"
                , listItemMeta [] [ icon iconConfig "info" ]
                ]
        )


activatedItemList : (Msg -> m) -> Model -> Html m
activatedItemList lift model =
    let
        listItemConfig_ index =
            { listItemConfig
                | activated = model.activatedIndex == index
                , onClick = Just (lift (SetActivated index))
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


shapedActivatedItemList : (Msg -> m) -> Model -> Html m
shapedActivatedItemList lift model =
    let
        listItemConfig_ index =
            { listItemConfig
                | activated = model.shapedActivatedIndex == index
                , onClick = Just (lift (SetShapedActivated index))
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


demoIcon : List (Html.Attribute m)
demoIcon =
    [ Html.Attributes.style "background" "rgba(0,0,0,.3)"
    , Html.Attributes.style "border-radius" "50%"
    , Html.Attributes.style "color" "#fff"
    ]


folderList : Html m
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


listWithTrailingCheckbox : (Msg -> m) -> Model -> Html m
listWithTrailingCheckbox lift model =
    let
        listItemConfig_ index =
            { listItemConfig
                | onClick = Just (lift (ToggleCheckbox 0))
                , additionalAttributes =
                    [ Html.Attributes.attribute "aria-checked"
                        (if Set.member index model.checkboxIndices then
                            "true"

                         else
                            "false"
                        )
                    , Html.Events.on "keydown"
                        (Html.Events.keyCode
                            |> Decode.andThen
                                (\keyCode ->
                                    if keyCode == 32 || keyCode == 13 then
                                        Decode.succeed (lift (ToggleCheckbox index))

                                    else
                                        Decode.fail ""
                                )
                        )
                    ]
            }

        checkbox_ index =
            checkbox
                { checkboxConfig
                    | onClick = Just (lift (ToggleCheckbox index))
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


listWithTrailingRadioButton : (Msg -> m) -> Model -> Html m
listWithTrailingRadioButton lift model =
    let
        listItemConfig_ index =
            { listItemConfig
                | onClick = Just (lift (SetRadio index))
                , additionalAttributes =
                    [ Html.Events.on "keydown"
                        (Html.Events.keyCode
                            |> Decode.andThen
                                (\keyCode ->
                                    if keyCode == 32 || keyCode == 13 then
                                        Decode.succeed (lift (SetRadio index))

                                    else
                                        Decode.fail ""
                                )
                        )
                    ]
            }

        radio_ index =
            radio
                { radioConfig
                    | checked = model.radioIndex == index
                    , onClick = Just (lift (SetRadio index))
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


view : (Msg -> m) -> Page m -> Model -> Html m
view lift page model =
    page.body "List"
        "Lists present multiple line items vertically as a single continuous element."
        [ Page.hero [] [ heroList ]
        , Html.h2
            [ Typography.headline6
            , Html.Attributes.style "border-bottom" "1px solid rgba(0,0,0,.87)"
            ]
            [ text "Resources"
            ]
        , ResourceLink.view
            { link = "https://material.io/go/design-lists"
            , title = "Material Design Guidelines"
            , icon = "images/material.svg"
            , altText = "Material Design Guidelines icon"
            }
        , ResourceLink.view
            { link = "https://material.io/components/web/catalog/lists/"
            , title = "Documentation"
            , icon = "images/ic_drive_document_24px.svg"
            , altText = "Documentation icon"
            }
        , ResourceLink.view
            { link = "https://github.com/material-components/material-components-web/tree/master/packages/mdc-list"
            , title = "Source Code (Material Components Web)"
            , icon = "images/ic_code_24px.svg"
            , altText = "Source Code"
            }
        , Page.demos
            [ Html.h3 [ Typography.subtitle1 ] [ text "Single-Line" ]
            , singleLineList
            , Html.h3 [ Typography.subtitle1 ] [ text "Two-Line" ]
            , twoLineList
            , Html.h3 [ Typography.subtitle1 ] [ text "Leading Icon" ]
            , leadingIconList
            , Html.h3 [ Typography.subtitle1 ] [ text "List with activated item" ]
            , activatedItemList lift model
            , Html.h3 [ Typography.subtitle1 ] [ text "List with shaped activated item" ]
            , shapedActivatedItemList lift model
            , Html.h3 [ Typography.subtitle1 ] [ text "Trailing Icon" ]
            , trailingIconList
            , Html.h3 [ Typography.subtitle1 ]
                [ text "Two-Line with Leading and Trailing Icon and Divider" ]
            , folderList
            , Html.h3 [ Typography.subtitle1 ] [ text "List with Trailing Checkbox" ]
            , listWithTrailingCheckbox lift model
            , Html.h3 [ Typography.subtitle1 ] [ text "List with Trailing Radio Buttons" ]
            , listWithTrailingRadioButton lift model
            ]
        ]
