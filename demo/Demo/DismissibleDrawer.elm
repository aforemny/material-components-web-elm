module Demo.DismissibleDrawer exposing
    ( Model
    , Msg(..)
    , defaultModel
    , update
    , view
    )

import Demo.DrawerPage as DrawerPage exposing (DrawerPage)
import Html exposing (Html, text)
import Html.Attributes
import Html.Events
import Json.Decode as Json
import Material.Drawer as Drawer exposing (dismissibleDrawer, drawerConfig)
import Material.Icon exposing (icon, iconConfig)
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
    = ToggleDrawer
    | SetSelectedIndex Int


update : (Msg -> msg) -> Msg -> Model -> ( Model, Cmd msg )
update lift msg model =
    case msg of
        ToggleDrawer ->
            ( { model | drawerOpen = not model.drawerOpen }, Cmd.none )

        SetSelectedIndex index ->
            ( { model | selectedIndex = index }, Cmd.none )


view : Model -> DrawerPage Msg
view model =
    { title = "Dismissible Drawer"
    , drawer =
        dismissibleDrawer { drawerConfig | open = model.drawerOpen }
            (DrawerPage.drawerBody SetSelectedIndex model.selectedIndex)
    , onMenuClick = Just ToggleDrawer
    , scrim = Nothing
    }
