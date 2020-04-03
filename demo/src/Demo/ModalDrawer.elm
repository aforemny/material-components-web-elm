module Demo.ModalDrawer exposing
    ( Model
    , Msg(..)
    , defaultModel
    , update
    , view
    )

import Demo.DrawerPage as DrawerPage exposing (DrawerPage)
import Demo.PermanentDrawer
import Html exposing (Html, text)
import Html.Attributes
import Html.Events
import Json.Decode as Decode
import Material.Drawer.Modal as ModalDrawer
import Material.Icon as Icon
import Material.Theme as Theme
import Material.TopAppBar as TopAppBar
import Material.Typography as Typography
import Platform.Cmd exposing (Cmd, none)


type alias Model =
    { open : Bool
    , selectedIndex : Int
    }


defaultModel : Model
defaultModel =
    { open = False
    , selectedIndex = 0
    }


type Msg
    = OpenDrawer
    | CloseDrawer
    | SetSelectedIndex Int


update : Msg -> Model -> Model
update msg model =
    case msg of
        OpenDrawer ->
            { model | open = True }

        CloseDrawer ->
            { model | open = False }

        SetSelectedIndex index ->
            { model | selectedIndex = index }


view : Model -> DrawerPage Msg
view model =
    { title = "Modal Drawer"
    , drawer =
        ModalDrawer.drawer
            (ModalDrawer.config
                |> ModalDrawer.setOpen model.open
                |> ModalDrawer.setOnClose CloseDrawer
            )
            (DrawerPage.drawerBody SetSelectedIndex model.selectedIndex)
    , scrim = Just (ModalDrawer.scrim [] [])
    , onMenuClick = Just OpenDrawer
    }
