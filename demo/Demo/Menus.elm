module Demo.Menus exposing (Model, Msg(..), defaultModel, subscriptions, update, view)

import Demo.Helper.ResourceLink as ResourceLink
import Demo.Page as Page exposing (Page)
import Html exposing (Html, text)
import Html.Attributes
import Html.Events
import Json.Decode as Json
import Material.Button as Button exposing (button, buttonConfig)
import Material.List as Lists exposing (list, listConfig, listItem, listItemConfig, listItemDivider, listItemDividerConfig)
import Material.Menu as Menu exposing (menu, menuConfig)
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


subscriptions : (Msg -> m) -> Model -> Sub m
subscriptions lift model =
    Sub.none


heroMenu : (Msg -> m) -> Model -> Html m
heroMenu lift model =
    menu { menuConfig | open = True }
        [ list listConfig
            [ listItem listItemConfig [ text "A Menu Item" ]
            , listItem listItemConfig [ text "Another Menu Item" ]
            ]
        ]


view : (Msg -> m) -> Page m -> Model -> Html m
view lift page model =
    page.body "Menu"
        "Menus display a list of choices on a transient sheet of material."
        [ Page.hero [] [ heroMenu lift model ]
        , Html.h2
            [ Typography.headline6
            , Html.Attributes.style "border-bottom" "1px solid rgba(0,0,0,.87)"
            ]
            [ text "Resources"
            ]
        , ResourceLink.view
            { link = "https://material.io/go/design-menus"
            , title = "Material Design Guidelines"
            , icon = "images/material.svg"
            , altText = "Material Design Guidelines icon"
            }
        , ResourceLink.view
            { link = "https://material.io/components/web/catalog/menus/"
            , title = "Documentation"
            , icon = "images/ic_drive_document_24px.svg"
            , altText = "Documentation icon"
            }
        , ResourceLink.view
            { link = "https://github.com/material-components/material-components-web/tree/master/packages/mdc-menu"
            , title = "Source Code (Material Components Web)"
            , icon = "images/ic_code_24px.svg"
            , altText = "Source Code"
            }
        , Page.demos
            [ Html.h3 [ Typography.subtitle1 ] [ text "Anchored menu" ]
            , button buttonConfig "Open menu"
            , menu menuConfig
                [ list listConfig
                    [ listItem listItemConfig [ text "Passionfruit" ]
                    , listItem listItemConfig [ text "Orange" ]
                    , listItem listItemConfig [ text "Guava" ]
                    , listItem listItemConfig [ text "Pitaya" ]
                    , listItemDivider listItemDividerConfig
                    , listItem listItemConfig [ text "Pineapple" ]
                    , listItem listItemConfig [ text "Mango" ]
                    , listItem listItemConfig [ text "Papaya" ]
                    , listItem listItemConfig [ text "Lychee" ]
                    ]
                ]
            ]
        ]
