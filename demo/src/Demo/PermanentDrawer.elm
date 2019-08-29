module Demo.PermanentDrawer exposing (Model, Msg, defaultModel, update, view)

import Demo.DrawerPage as DrawerPage exposing (DrawerPage)
import Html exposing (Html, text)
import Html.Attributes
import Html.Events
import Json.Decode as Decode
import Material.Drawer as Drawer exposing (drawerContent, drawerHeader, permanentDrawer, permanentDrawerConfig)
import Material.Icon exposing (icon, iconConfig)
import Material.List exposing (list, listConfig, listGroupSubheader, listItem, listItemConfig, listItemDivider, listItemDividerConfig, listItemGraphic)
import Material.TopAppBar as TopAppBar exposing (topAppBar, topAppBarConfig)
import Material.Typography as Typography
import Platform.Cmd exposing (Cmd, none)


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
        permanentDrawer permanentDrawerConfig
            (DrawerPage.drawerBody SetSelectedIndex model.selectedIndex)
    , scrim = Nothing
    , onMenuClick = Nothing
    }
