module Demo.ModalDrawer exposing
    ( Model
    , Msg(..)
    , defaultModel
    , subscriptions
    , update
    , view
    )

import Demo.Page exposing (Page)
import Demo.PermanentDrawer
import Html exposing (Html, text)
import Html.Attributes
import Html.Events
import Json.Decode as Json
import Material.Button as Button
import Material.Drawer as Drawer
import Material.Icon as Icon
import Material.Theme as Theme
import Material.TopAppBar as TopAppBar
import Material.Typography as Typography
import Platform.Cmd exposing (Cmd, none)


type alias Model =
    { drawerOpen : Bool
    }


defaultModel : Model
defaultModel =
    { drawerOpen = False
    }


type Msg
    = OpenDrawer
    | CloseDrawer


update : (Msg -> m) -> Msg -> Model -> ( Model, Cmd m )
update lift msg model =
    case msg of
        OpenDrawer ->
            ( { model | drawerOpen = True }, Cmd.none )

        CloseDrawer ->
            ( { model | drawerOpen = False }, Cmd.none )


view : (Msg -> m) -> Page m -> Model -> Html m
view lift page model =
    Html.div
        [ Html.Attributes.class "drawer-frame-root"
        , Html.Attributes.class "mdc-typography"
        , Html.Attributes.style "display" "flex"
        , Html.Attributes.style "height" "100vh"
        ]
        [ Drawer.view lift
            "modal-drawer-drawer"
            model.mdc
            [ Drawer.open |> when model.drawerOpen
            , Drawer.onClose (lift CloseDrawer)
            ]
            [ Demo.PermanentDrawer.drawerHeader
            , Demo.PermanentDrawer.drawerItems
            ]
        , Drawer.scrim [ Html.Events.onClick (lift CloseDrawer) ] []
        , Html.div
            [ Html.Attributes.class "drawer-frame-app-content" ]
            [ TopAppBar.view lift
                "modal-drawer-top-app-bar"
                model.mdc
                []
                [ TopAppBar.section
                    [ TopAppBar.alignStart
                    ]
                    [ TopAppBar.navigationIcon [ Html.Events.onClick (lift OpenDrawer) ]
                        "menu"
                    , TopAppBar.title [] [ text "Modal Drawer" ]
                    ]
                ]
            , Demo.PermanentDrawer.mainContent model lift
            ]
        ]


subscriptions : (Msg -> m) -> Model -> Sub m
subscriptions lift model =
    Sub.none
