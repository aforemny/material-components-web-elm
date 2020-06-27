module Demo.Menus exposing (Model, Msg(..), defaultModel, update, view)

import Demo.CatalogPage exposing (CatalogPage)
import Html exposing (Html, text)
import Html.Attributes exposing (class, style)
import Material.Button as Button
import Material.List as List
import Material.List.Divider as ListDivider
import Material.List.Item as ListItem exposing (ListItem)
import Material.Menu as Menu
import Material.Typography as Typography


type alias Model =
    { open : Bool }


defaultModel : Model
defaultModel =
    { open = False }


type Msg
    = Open
    | Close


update : Msg -> Model -> Model
update msg model =
    case msg of
        Open ->
            { model | open = True }

        Close ->
            { model | open = False }


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
        [ Html.h3 [ Typography.subtitle1 ] [ text "Anchored menu" ]
        , Html.div [ Menu.surfaceAnchor ]
            [ Button.text (Button.config |> Button.setOnClick Open) "Open menu"
            , Menu.menu
                (Menu.config
                    |> Menu.setOpen model.open
                    |> Menu.setOnClose Close
                )
                [ List.list (List.config |> List.setWrapFocus True)
                    (listItem "Passionfruit")
                    (List.concat
                        [ List.map listItem
                            [ "Orange"
                            , "Guava"
                            , "Pitaya"
                            ]
                        , [ ListDivider.listItem ListDivider.config ]
                        , List.map listItem
                            [ "Pineapple"
                            , "Mango"
                            , "Papaya"
                            , "Lychee"
                            ]
                        ]
                    )
                ]
            ]
        ]
    }


listItem : String -> ListItem Msg
listItem label =
    ListItem.listItem (ListItem.config |> ListItem.setOnClick Close) [ text label ]


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
