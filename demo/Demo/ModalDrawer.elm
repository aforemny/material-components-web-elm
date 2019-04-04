module Demo.ModalDrawer exposing
    ( Model
    , Msg(..)
    , defaultModel
    , update
    , view
    )

import Demo.Page exposing (Page)
import Demo.PermanentDrawer
import Html exposing (Html, text)
import Html.Attributes
import Html.Events
import Json.Decode as Decode
import Material.Button as Button
import Material.Drawer as Drawer exposing (drawerConfig, drawerScrim, modalDrawer)
import Material.Icon as Icon exposing (icon, iconConfig)
import Material.Theme as Theme
import Material.TopAppBar as TopAppBar exposing (topAppBar, topAppBarConfig)
import Material.Typography as Typography
import Platform.Cmd exposing (Cmd, none)


type alias Model =
    { drawerOpen : Bool
    , selectedIndex : Int
    }


defaultModel : Model
defaultModel =
    { drawerOpen = False
    , selectedIndex = 0
    }


type Msg
    = OpenDrawer
    | CloseDrawer
    | SetSelectedIndex Int


update : (Msg -> m) -> Msg -> Model -> ( Model, Cmd m )
update lift msg model =
    case msg of
        OpenDrawer ->
            ( { model | drawerOpen = True }, Cmd.none )

        CloseDrawer ->
            ( { model | drawerOpen = False }, Cmd.none )

        SetSelectedIndex index ->
            ( { model | selectedIndex = index }, Cmd.none )


view : (Msg -> m) -> Page m -> Model -> Html m
view lift page model =
    Html.div
        [ Html.Attributes.class "drawer-frame-root"
        , Html.Attributes.class "mdc-typography"
        , Html.Attributes.style "display" "flex"
        , Html.Attributes.style "height" "100vh"
        ]
        [ modalDrawer
            { drawerConfig
                | open = model.drawerOpen
                , onClose = Just (lift CloseDrawer)
            }
            (Demo.PermanentDrawer.drawerBody (lift << SetSelectedIndex)
                model.selectedIndex
            )
        , drawerScrim [] []
        , Html.div
            [ Html.Attributes.class "drawer-frame-app-content" ]
            [ topAppBar topAppBarConfig
                [ TopAppBar.row []
                    [ TopAppBar.section
                        [ TopAppBar.alignStart
                        ]
                        [ icon
                            { iconConfig
                                | additionalAttributes =
                                    [ TopAppBar.navigationIcon
                                    , Html.Events.onClick (lift OpenDrawer)
                                    ]
                            }
                            "menu"
                        , Html.span [ TopAppBar.title ] [ text "Modal Drawer" ]
                        ]
                    ]
                ]
            , Demo.PermanentDrawer.mainContent model lift
            ]
        ]
