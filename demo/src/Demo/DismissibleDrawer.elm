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
import Material.Drawer as Drawer exposing (dismissibleDrawer, dismissibleDrawerConfig)
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
    | CloseDrawer
    | SetSelectedIndex Int


update : Msg -> Model -> Model
update msg model =
    case msg of
        ToggleDrawer ->
            { model | drawerOpen = not model.drawerOpen }

        CloseDrawer ->
            { model | drawerOpen = False }

        SetSelectedIndex index ->
            { model | selectedIndex = index }


view : Model -> DrawerPage Msg
view model =
    { title = "Dismissible Drawer"
    , drawer =
        dismissibleDrawer
            { dismissibleDrawerConfig
                | open = model.drawerOpen
                , onClose = Just CloseDrawer
            }
            (DrawerPage.drawerBody SetSelectedIndex model.selectedIndex)
    , onMenuClick = Just ToggleDrawer
    , scrim = Nothing
    }
