module Demo.Menus exposing (Model, Msg(..), defaultModel, update, view)

import Demo.CatalogPage exposing (CatalogPage)
import Html exposing (Html, text)
import Html.Attributes exposing (class, style)
import Material.Button as Button
import Material.IconButton as IconButton
import Material.List as List
import Material.List.Divider as ListDivider
import Material.List.Item as ListItem exposing (ListItem)
import Material.Menu as Menu
import Material.Typography as Typography


type alias Model =
    { open1 : Bool
    , open2 : Bool
    }


defaultModel : Model
defaultModel =
    { open1 = False
    , open2 = False
    }


type Msg
    = Open
    | Close
    | OpenChanged Bool


update : Msg -> Model -> Model
update msg model =
    case msg of
        Open ->
            { model | open1 = True }

        Close ->
            { model | open1 = False }

        OpenChanged open2 ->
            { model | open2 = open2 }


view : Model -> CatalogPage Msg
view model =
    { title = "Menu"
    , prelude = "Menus display a list of choices on a transient sheet of material."
    , resources =
        { materialDesignGuidelines = Just "https://material.io/go/design-menus"
        , documentation = Just "https://package.elm-lang.org/packages/aforemny/material-components-web-elm/latest/Material-Menu"
        , sourceCode = Just "https://github.com/material-components/material-components-web/tree/master/packages/mdc-menu"
        }
    , hero = [ heroMenu model ]
    , content =
        [ Html.h3 [ Typography.subtitle1 ] [ text "Button Menu" ]
        , buttonExample model
        , Html.h3 [ Typography.subtitle1 ] [ text "Icon Button Menu" ]
        , iconButtonExample model
        ]
    }


buttonExample : Model -> Html Msg
buttonExample model =
    Button.text
        (Button.config
            |> Button.setOnClick Open
            |> Button.setMenu
                (Just <|
                    Button.menu
                        (Menu.config
                            |> Menu.setOpen model.open1
                            |> Menu.setOnClose Close
                        )
                        (menuItems { onClick = Close })
                )
        )
        "Open menu"


iconButtonExample : Model -> Html Msg
iconButtonExample model =
    IconButton.iconButton
        (IconButton.config
            |> IconButton.setOnClick (OpenChanged True)
            |> IconButton.setMenu
                (Just <|
                    IconButton.menu
                        (Menu.config
                            |> Menu.setOpen model.open2
                            |> Menu.setOnClose (OpenChanged False)
                        )
                        (menuItems { onClick = OpenChanged False })
                )
        )
        (IconButton.icon "menu_vert")


menuItems : { onClick : msg } -> List (Html msg)
menuItems onClick =
    [ List.list (List.config |> List.setWrapFocus True)
        (listItem onClick "Passionfruit")
        (List.concat
            [ List.map (listItem onClick)
                [ "Orange"
                , "Guava"
                , "Pitaya"
                ]
            , [ ListDivider.listItem ListDivider.config ]
            , List.map (listItem onClick)
                [ "Pineapple"
                , "Mango"
                , "Papaya"
                , "Lychee"
                ]
            ]
        )
    ]


listItem : { onClick : msg } -> String -> ListItem msg
listItem { onClick } label =
    ListItem.listItem (ListItem.config |> ListItem.setOnClick onClick) [ text label ]


heroMenu : Model -> Html msg
heroMenu model =
    Html.div
        [ class "mdc-menu-surface mdc-menu-surface--open"
        , style "position" "relative"
        , style "transform-origin" "left top 0px"
        , style "left" "0px"
        , style "top" "0px"
        , style "z-index" "0"
        ]
        [ List.list List.config
            (ListItem.listItem ListItem.config [ text "A Menu Item" ])
            [ ListItem.listItem ListItem.config [ text "Another Menu Item" ]
            ]
        ]
