module Demo.Drawer exposing
    ( Model
    , Msg(..)
    , defaultModel
    , update
    , view
    )

import Demo.CatalogPage exposing (CatalogPage)
import Html exposing (Html, text)
import Html.Attributes exposing (style)
import Material.Drawer.Permanent as PermanentDrawer
import Material.Icon as Icon
import Material.List as List
import Material.List.Item as ListItem
import Material.Typography as Typography


type alias Model =
    {}


defaultModel : Model
defaultModel =
    {}


type Msg
    = NoOp


update : Msg -> Model -> Model
update msg model =
    model


view : Model -> CatalogPage Msg
view model =
    { title = "Drawer"
    , prelude = "The navigation drawer slides in from the left and contains the navigation destinations for your app."
    , resources =
        { materialDesignGuidelines = Just "https://material.io/go/design-navigation-drawer"
        , documentation = Just "https://package.elm-lang.org/packages/aforemny/material-components-web-elm/latest/Material-Drawer"
        , sourceCode = Just "https://github.com/material-components/material-components-web/tree/master/packages/mdc-drawer"
        }
    , hero = heroDrawer
    , content =
        [ iframe "Permanent" "#permanent-drawer"
        , iframe "Dismissible" "#dismissible-drawer"
        , iframe "Modal" "#modal-drawer"
        ]
    }


heroDrawer : List (Html msg)
heroDrawer =
    let
        listItem ( activated, icon, label ) =
            ListItem.listItem
                (ListItem.config
                    |> ListItem.setSelected
                        (if activated then
                            Just ListItem.activated

                         else
                            Nothing
                        )
                    |> ListItem.setAttributes [ Html.Attributes.href "#drawer" ]
                )
                [ ListItem.graphic [] [ Icon.icon [] icon ]
                , text label
                ]
    in
    [ PermanentDrawer.drawer PermanentDrawer.config
        [ PermanentDrawer.header []
            [ Html.h3 [ PermanentDrawer.title ] [ text "Title" ]
            , Html.h6 [ PermanentDrawer.subtitle ] [ text "Subtitle" ]
            ]
        , PermanentDrawer.content []
            [ List.list List.config
                (List.map listItem
                    [ ( True, "inbox", "Inbox" )
                    , ( False, "star", "Star" )
                    , ( False, "send", "Sent Mail" )
                    , ( False, "drafts", "Drafts" )
                    ]
                )
            ]
        ]
    ]


iframe : String -> String -> Html msg
iframe label url =
    Html.div
        [ style "display" "inline-block"
        , style "-ms-flex" "1 1 80%"
        , style "flex" "1 1 80%"
        , style "-ms-flex-pack" "distribute"
        , style "justify-content" "space-around"
        , style "min-height" "400px"
        , style "min-width" "400px"
        , style "padding" "15px"
        ]
        [ Html.div []
            [ Html.a
                [ Html.Attributes.href url
                , Html.Attributes.target "_blank"
                ]
                [ Html.h3 [ Typography.subtitle1 ] [ text label ] ]
            ]
        , Html.iframe
            [ Html.Attributes.src url
            , style "height" "400px"
            , style "width" "100vw"
            , style "max-width" "780px"
            ]
            []
        ]
