module Demo.DismissibleDrawer exposing
    ( Model
    , Msg(..)
    , defaultModel
    , update
    , view
    )

import Demo.DrawerPage as DrawerPage exposing (DrawerPage)
import Material.Drawer.Dismissible as DismissibleDrawer


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
    = ToggleDrawer
    | CloseDrawer
    | SetSelectedIndex Int


update : Msg -> Model -> Model
update msg model =
    case msg of
        ToggleDrawer ->
            { model | open = not model.open }

        CloseDrawer ->
            { model | open = False }

        SetSelectedIndex index ->
            { model | selectedIndex = index }


view : Model -> DrawerPage Msg
view model =
    { title = "Dismissible Drawer"
    , drawer =
        DismissibleDrawer.drawer
            (DismissibleDrawer.config
                |> DismissibleDrawer.setOpen model.open
                |> DismissibleDrawer.setOnClose CloseDrawer
            )
            (DrawerPage.drawerBody SetSelectedIndex model.selectedIndex)
    , onMenuClick = Just ToggleDrawer
    , scrim = Nothing
    }
