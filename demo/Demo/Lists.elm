module Demo.Lists exposing (Model, Msg, defaultModel, update, view)

import Demo.Helper.Hero as Hero
import Demo.Helper.ResourceLink as ResourceLink
import Demo.Page as Page exposing (Page)
import Html exposing (Html, text)
import Html.Attributes
import Material.Checkbox as Checkbox
import Material.Icon as Icon
import Material.List as Lists
import Material.Radio as RadioButton
import Material.Ripple as Ripple
import Material.Typography as Typography


type alias Model =
    {}


defaultModel : Model
defaultModel =
    {}


type Msg
    = NoOp


update : (Msg -> m) -> Msg -> Model -> ( Model, Cmd m )
update lift msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )


demoList : List (Html.Attribute m)
demoList =
    [ Html.Attributes.style "max-width" "600px"
    , Html.Attributes.style "border" "1px solid rgba(0,0,0,.1)"
    ]


heroList : Html m
heroList =
    Lists.ul
        (Html.Attributes.style "background" "#fff" :: demoList)
        (List.repeat 3 <| Lists.li [] [ text "Line item" ])


singleLineList : Html m
singleLineList =
    Lists.ul demoList (List.repeat 3 <| Lists.li [] [ text "Line item" ])


twoLineList : Html m
twoLineList =
    Lists.ul (Lists.twoLine :: demoList)
        (List.repeat 3 <|
            Lists.li []
                [ Lists.text []
                    [ Lists.primaryText [] [ text "Line item" ]
                    , Lists.secondaryText [] [ text "Secondary text" ]
                    ]
                ]
        )


leadingIconList : Html m
leadingIconList =
    Lists.ul demoList
        [ Lists.li [] [ Lists.graphicIcon [] "wifi", text "Line item" ]
        , Lists.li [] [ Lists.graphicIcon [] "bluetooth", text "Line item" ]
        , Lists.li [] [ Lists.graphicIcon [] "data_usage", text "Line item" ]
        ]


trailingIconList : Html m
trailingIconList =
    Lists.ul demoList
        (List.repeat 3 <| Lists.li [] [ text "Line item", Lists.metaIcon [] "info" ])


activatedItemList : Html m
activatedItemList =
    Lists.ul demoList
        [ Lists.li [] [ Lists.graphicIcon [] "inbox", text "Inbox" ]
        , Lists.li [ Lists.activated ] [ Lists.graphicIcon [] "star", text "Star" ]
        , Lists.li [] [ Lists.graphicIcon [] "send", text "Sent" ]
        , Lists.li [] [ Lists.graphicIcon [] "drafts", text "Drafts" ]
        ]


shapedActivatedItemList : Html m
shapedActivatedItemList =
    Lists.ul demoList
        [ Lists.li [] [ Lists.graphicIcon [] "inbox", text "Inbox" ]
        , Lists.li
            [ Lists.activated, Html.Attributes.style "border-radius" "0 32px 32px 0" ]
            [ Lists.graphicIcon [] "star", text "Star" ]
        , Lists.li [] [ Lists.graphicIcon [] "send", text "Sent" ]
        , Lists.li [] [ Lists.graphicIcon [] "drafts", text "Drafts" ]
        ]


demoIcon : List (Html.Attribute m)
demoIcon =
    [ Html.Attributes.style "background" "rgba(0,0,0,.3)"
    , Html.Attributes.style "border-radius" "50%"
    , Html.Attributes.style "color" "#fff"
    ]


folderList : Html m
folderList =
    Lists.ul (Lists.twoLine :: Lists.avatarList :: demoList)
        [ Lists.li []
            [ Lists.graphicIcon demoIcon "folder"
            , Lists.text []
                [ Lists.primaryText [] [ text "Dog Photos" ]
                , Lists.secondaryText [] [ text "9 Jan 2018" ]
                ]
            , Lists.metaIcon [] "info"
            ]
        , Lists.li []
            [ Lists.graphicIcon demoIcon "folder"
            , Lists.text []
                [ Lists.primaryText [] [ text "Cat Photos" ]
                , Lists.secondaryText [] [ text "22 Dec 2017" ]
                ]
            , Lists.metaIcon [] "info"
            ]
        , Lists.divider [] []
        , Lists.li []
            [ Lists.graphicIcon demoIcon "folder"
            , Lists.text []
                [ Lists.primaryText [] [ text "Potatoes" ]
                , Lists.secondaryText [] [ text "30 Noc 2017" ]
                ]
            , Lists.metaIcon [] "info"
            ]
        , Lists.li []
            [ Lists.graphicIcon demoIcon "folder"
            , Lists.text []
                [ Lists.primaryText [] [ text "Carrots" ]
                , Lists.secondaryText [] [ text "17 Oct 2017" ]
                ]
            , Lists.metaIcon [] "info"
            ]
        ]


listWithTrailing : (Int -> Html m) -> Html m
listWithTrailing metaControl =
    Lists.ul demoList
        [ Lists.li []
            [ text "Dog Photos"
            , Lists.meta [] [ metaControl 0 ]
            ]
        , Lists.li []
            [ text "Cat Photos"
            , Lists.meta [] [ metaControl 1 ]
            ]
        , Lists.divider [] []
        , Lists.li []
            [ text "Potatoes"
            , Lists.meta [] [ metaControl 2 ]
            ]
        , Lists.li []
            [ text "Carrots"
            , Lists.meta [] [ metaControl 3 ]
            ]
        ]


listWithTrailingCheckbox : (Msg -> m) -> String -> Model -> Html m
listWithTrailingCheckbox lift index model =
    listWithTrailing
        (\n ->
            Checkbox.view lift
                (index ++ "-checkbox-" ++ String.fromInt n)
                model.mdc
                [ Checkbox.checked False ]
                []
        )


listWithTrailingRadioButton : (Msg -> m) -> String -> Model -> Html m
listWithTrailingRadioButton lift index model =
    listWithTrailing
        (\n ->
            RadioButton.view lift
                (index ++ "-radio-button-" ++ String.fromInt n)
                model.mdc
                []
                []
        )


view : (Msg -> m) -> Page m -> Model -> Html m
view lift page model =
    page.body "List"
        "Lists present multiple line items vertically as a single continuous element."
        [ Hero.view [] [ heroList ]
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
            , activatedItemList
            , Html.h3 [ Typography.subtitle1 ] [ text "List with shaped activated item" ]
            , shapedActivatedItemList
            , Html.h3 [ Typography.subtitle1 ] [ text "Trailing Icon" ]
            , trailingIconList
            , Html.h3 [ Typography.subtitle1 ] [ text "Two-Line with Leading and Trailing Icon and Divider" ]
            , folderList
            , Html.h3 [ Typography.subtitle1 ] [ text "List with Trailing Checkbox" ]
            , listWithTrailingCheckbox lift "lists-list-with-checkbox" model
            , Html.h3 [ Typography.subtitle1 ] [ text "List with Trailing Radio Buttons" ]
            , listWithTrailingRadioButton lift "lists-list-with-radio-buttons" model
            ]
        ]
