module Demo.PermanentDrawer exposing (Model, Msg, defaultModel, update, view)

import Demo.DrawerPage as DrawerPage exposing (DrawerPage)
import Material.Drawer.Permanent as PermanentDrawer


type alias Model =
    { selectedIndex : Int }


defaultModel : Model
defaultModel =
    { selectedIndex = 0 }


type Msg
    = SetSelectedIndex Int


update : Msg -> Model -> Model
update msg model =
    case msg of
        SetSelectedIndex index ->
            { model | selectedIndex = index }


view : Model -> DrawerPage Msg
view model =
    { title = "Permanent Drawer"
    , drawer =
        PermanentDrawer.drawer PermanentDrawer.config
            (DrawerPage.drawerBody SetSelectedIndex model.selectedIndex)
    , scrim = Nothing
    , onMenuClick = Nothing
    }
