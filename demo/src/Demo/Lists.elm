module Demo.Lists exposing (Model, Msg, defaultModel, update, view)

import Browser.Dom
import Demo.CatalogPage exposing (CatalogPage)
import Html exposing (Html, text)
import Html.Attributes exposing (style)
import Material.Button as Button
import Material.Checkbox as Checkbox
import Material.Icon as Icon
import Material.List as List
import Material.List.Item as ListItem
import Material.Radio as Radio
import Material.Typography as Typography
import Set exposing (Set)
import Task


type alias Model =
    { checkboxes : Set String
    , radio : Maybe String
    , activated : String
    , shapedActivated : String
    }


defaultModel : Model
defaultModel =
    { checkboxes = Set.empty
    , radio = Nothing
    , activated = "Star"
    , shapedActivated = "Star"
    }


type Msg
    = ToggleCheckbox String
    | SetRadio String
    | SetActivated String
    | SetShapedActivated String
    | Focus String
    | Focused (Result Browser.Dom.Error ())


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        ToggleCheckbox id ->
            ( { model
                | checkboxes =
                    if Set.member id model.checkboxes then
                        Set.remove id model.checkboxes

                    else
                        Set.insert id model.checkboxes
              }
            , Cmd.none
            )

        SetRadio id ->
            ( { model | radio = Just id }, Cmd.none )

        SetActivated id ->
            ( { model | activated = id }, Cmd.none )

        SetShapedActivated id ->
            ( { model | shapedActivated = id }, Cmd.none )

        Focus id ->
            ( model, Task.attempt Focused (Browser.Dom.focus id) )

        Focused _ ->
            ( model, Cmd.none )


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
        , Html.h3 [ Typography.subtitle1 ] [ text "Focus List" ]
        , focusList
        ]
    }


demoList : List (Html.Attribute msg)
demoList =
    [ style "max-width" "600px"
    , style "border" "1px solid rgba(0,0,0,.1)"
    ]


heroList : List (Html msg)
heroList =
    [ List.list
        (List.config
            |> List.setAttributes (style "background" "#fff" :: demoList)
        )
        (List.repeat 3 <| ListItem.listItem ListItem.config [ text "Line item" ])
    ]


singleLineList : Html msg
singleLineList =
    List.list (List.config |> List.setAttributes demoList)
        (List.repeat 3 <| ListItem.listItem ListItem.config [ text "Line item" ])


twoLineList : Html msg
twoLineList =
    List.list
        (List.config
            |> List.setTwoLine True
            |> List.setAttributes demoList
        )
        (List.repeat 3 <|
            ListItem.listItem ListItem.config
                [ ListItem.text []
                    { primary = [ text "Line item" ]
                    , secondary = [ text "Secondary text" ]
                    }
                ]
        )


leadingIconList : Html msg
leadingIconList =
    List.list (List.config |> List.setAttributes demoList)
        (List.map
            (\icon ->
                ListItem.listItem ListItem.config
                    [ ListItem.graphic [] [ Icon.icon [] icon ]
                    , text "Line item"
                    ]
            )
            [ "wifi"
            , "bluetooth"
            , "data_usage"
            ]
        )


trailingIconList : Html msg
trailingIconList =
    List.list (List.config |> List.setAttributes demoList)
        (List.repeat 3 <|
            ListItem.listItem ListItem.config
                [ text "Line item"
                , ListItem.meta [] [ Icon.icon [] "info" ]
                ]
        )


activatedItemList : Model -> Html Msg
activatedItemList model =
    let
        listItem ( icon, label ) =
            ListItem.listItem
                (ListItem.config
                    |> ListItem.setSelected
                        (if model.activated == label then
                            Just ListItem.activated

                         else
                            Nothing
                        )
                    |> ListItem.setOnClick (SetActivated label)
                )
                [ ListItem.graphic [] [ Icon.icon [] icon ], text label ]
    in
    List.list (List.config |> List.setAttributes demoList)
        (List.map listItem
            [ ( "inbox", "Inbox" )
            , ( "star", "Star" )
            , ( "send", "Sent" )
            , ( "drafts", "Drafts" )
            ]
        )


shapedActivatedItemList : Model -> Html Msg
shapedActivatedItemList model =
    let
        listItem ( icon, label ) =
            ListItem.listItem
                (ListItem.config
                    |> ListItem.setSelected
                        (if model.shapedActivated == label then
                            Just ListItem.activated

                         else
                            Nothing
                        )
                    |> ListItem.setOnClick (SetShapedActivated label)
                    |> ListItem.setAttributes [ style "border-radius" "0 32px 32px 0" ]
                )
                [ ListItem.graphic [] [ Icon.icon [] icon ], text label ]
    in
    List.list (List.config |> List.setAttributes demoList)
        (List.map listItem
            [ ( "inbox", "Inbox" )
            , ( "star", "Star" )
            , ( "send", "Sent" )
            , ( "drafts", "Drafts" )
            ]
        )


demoIcon : List (Html.Attribute msg)
demoIcon =
    [ style "background" "rgba(0,0,0,.3)"
    , style "border-radius" "50%"
    , style "color" "#fff"
    ]


folderList : Html msg
folderList =
    let
        listItem { primary, secondary } =
            ListItem.listItem ListItem.config
                [ ListItem.graphic demoIcon [ Icon.icon [] "folder" ]
                , ListItem.text []
                    { primary = [ text primary ]
                    , secondary = [ text secondary ]
                    }
                , ListItem.meta [] [ Icon.icon [] "info" ]
                ]
    in
    List.list
        (List.config
            |> List.setAvatarList True
            |> List.setTwoLine True
            |> List.setAttributes demoList
        )
        (List.map listItem
            [ { primary = "Dog Photos"
              , secondary = "9 Jan 2018"
              }
            , { primary = "Cat Photos"
              , secondary = "22 Dec 2017"
              }
            , { primary = "Potatoes"
              , secondary = "30 Noc 2017"
              }
            , { primary = "Carrots"
              , secondary = "17 Oct 2017"
              }
            ]
        )


listWithTrailingCheckbox : Model -> Html Msg
listWithTrailingCheckbox model =
    let
        listItem label =
            ListItem.listItem
                (ListItem.config
                    |> ListItem.setSelected
                        (if Set.member label model.checkboxes then
                            Just ListItem.selected

                         else
                            Nothing
                        )
                )
                [ text "Dog Photos"
                , ListItem.meta []
                    [ Checkbox.checkbox
                        (Checkbox.config
                            |> Checkbox.setOnChange (ToggleCheckbox label)
                            |> Checkbox.setState
                                (Just
                                    (if Set.member label model.checkboxes then
                                        Checkbox.checked

                                     else
                                        Checkbox.unchecked
                                    )
                                )
                        )
                    ]
                ]
    in
    List.list
        (List.config
            |> List.setAttributes
                (Html.Attributes.attribute "role" "group"
                    :: demoList
                )
        )
        (List.map listItem
            [ "Dog Photos"
            , "Cat Photos"
            , "Potatoes"
            , "Carrots"
            ]
        )


listWithTrailingRadioButton : Model -> Html Msg
listWithTrailingRadioButton model =
    let
        listItem label =
            ListItem.listItem
                (ListItem.config
                    |> ListItem.setSelected
                        (if model.radio == Just label then
                            Just ListItem.selected

                         else
                            Nothing
                        )
                )
                [ text label
                , ListItem.meta []
                    [ Radio.radio
                        (Radio.config
                            |> Radio.setChecked (model.radio == Just label)
                            |> Radio.setOnChange (SetRadio label)
                        )
                    ]
                ]
    in
    List.list (List.config |> List.setAttributes demoList)
        (List.map listItem
            [ "Dog Photos"
            , "Cat Photos"
            , "Potatoes"
            , "Carrots"
            ]
        )


focusList : Html Msg
focusList =
    Html.div []
        [ List.list
            (List.config
                |> List.setAttributes (demoList ++ [ Html.Attributes.id "my-list" ])
            )
            (List.repeat 3 <| ListItem.listItem ListItem.config [ text "Line item" ])
        , text "\u{00A0}"
        , Button.raised
            (Button.config |> Button.setOnClick (Focus "my-list"))
            "Focus"
        ]
