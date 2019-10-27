module Main exposing (main)

import Browser
import Browser.Dom
import Browser.Navigation
import Demo.Buttons
import Demo.Cards
import Demo.CatalogPage as CatalogPage
import Demo.Checkbox
import Demo.Chips
import Demo.DenseTopAppBar
import Demo.Dialog
import Demo.DismissibleDrawer
import Demo.Drawer
import Demo.DrawerPage as DrawerPage
import Demo.Elevation
import Demo.Fabs
import Demo.FixedTopAppBar
import Demo.IconButton
import Demo.ImageList
import Demo.LayoutGrid
import Demo.LinearProgress
import Demo.Lists
import Demo.Menus
import Demo.ModalDrawer
import Demo.PermanentDrawer
import Demo.ProminentTopAppBar
import Demo.RadioButtons
import Demo.Ripple
import Demo.Selects
import Demo.ShortCollapsedTopAppBar
import Demo.ShortTopAppBar
import Demo.Slider
import Demo.Snackbar
import Demo.StandardTopAppBar
import Demo.Startpage
import Demo.Switch
import Demo.TabBar
import Demo.TextFields
import Demo.Theme
import Demo.TopAppBar
import Demo.TopAppBarPage as TopAppBarPage
import Demo.Typography
import Demo.Url
import Html exposing (Html, text)
import Html.Attributes
import Material.TopAppBar as TopAppBar exposing (topAppBarConfig)
import Material.Typography as Typography
import Platform.Cmd exposing (..)
import Task
import Url


type alias Model =
    { key : Browser.Navigation.Key
    , url : Demo.Url.Url
    , catalogDrawerOpen : Bool
    , buttons : Demo.Buttons.Model
    , cards : Demo.Cards.Model
    , checkbox : Demo.Checkbox.Model
    , chips : Demo.Chips.Model
    , denseTopAppBar : Demo.DenseTopAppBar.Model
    , dialog : Demo.Dialog.Model
    , dismissibleDrawer : Demo.DismissibleDrawer.Model
    , drawer : Demo.Drawer.Model
    , elevation : Demo.Elevation.Model
    , fabs : Demo.Fabs.Model
    , fixedTopAppBar : Demo.FixedTopAppBar.Model
    , iconButton : Demo.IconButton.Model
    , imageList : Demo.ImageList.Model
    , layoutGrid : Demo.LayoutGrid.Model
    , linearProgress : Demo.LinearProgress.Model
    , lists : Demo.Lists.Model
    , menus : Demo.Menus.Model
    , modalDrawer : Demo.ModalDrawer.Model
    , permanentDrawer : Demo.PermanentDrawer.Model
    , prominentTopAppBar : Demo.ProminentTopAppBar.Model
    , radio : Demo.RadioButtons.Model
    , ripple : Demo.Ripple.Model
    , selects : Demo.Selects.Model
    , shortCollapsedTopAppBar : Demo.ShortCollapsedTopAppBar.Model
    , shortTopAppBar : Demo.ShortTopAppBar.Model
    , slider : Demo.Slider.Model
    , snackbar : Demo.Snackbar.Model
    , standardTopAppBar : Demo.StandardTopAppBar.Model
    , switch : Demo.Switch.Model
    , tabbar : Demo.TabBar.Model
    , textfields : Demo.TextFields.Model
    , theme : Demo.Theme.Model
    , topAppBar : Demo.TopAppBar.Model
    , typography : Demo.Typography.Model
    }


defaultModel : Browser.Navigation.Key -> Model
defaultModel key =
    { key = key
    , url = Demo.Url.Button
    , catalogDrawerOpen = False
    , buttons = Demo.Buttons.defaultModel
    , cards = Demo.Cards.defaultModel
    , checkbox = Demo.Checkbox.defaultModel
    , chips = Demo.Chips.defaultModel
    , denseTopAppBar = Demo.DenseTopAppBar.defaultModel
    , dialog = Demo.Dialog.defaultModel
    , dismissibleDrawer = Demo.DismissibleDrawer.defaultModel
    , drawer = Demo.Drawer.defaultModel
    , elevation = Demo.Elevation.defaultModel
    , fabs = Demo.Fabs.defaultModel
    , fixedTopAppBar = Demo.FixedTopAppBar.defaultModel
    , iconButton = Demo.IconButton.defaultModel
    , imageList = Demo.ImageList.defaultModel
    , layoutGrid = Demo.LayoutGrid.defaultModel
    , linearProgress = Demo.LinearProgress.defaultModel
    , lists = Demo.Lists.defaultModel
    , menus = Demo.Menus.defaultModel
    , modalDrawer = Demo.ModalDrawer.defaultModel
    , permanentDrawer = Demo.PermanentDrawer.defaultModel
    , prominentTopAppBar = Demo.ProminentTopAppBar.defaultModel
    , radio = Demo.RadioButtons.defaultModel
    , ripple = Demo.Ripple.defaultModel
    , selects = Demo.Selects.defaultModel
    , shortCollapsedTopAppBar = Demo.ShortCollapsedTopAppBar.defaultModel
    , shortTopAppBar = Demo.ShortTopAppBar.defaultModel
    , slider = Demo.Slider.defaultModel
    , snackbar = Demo.Snackbar.defaultModel
    , standardTopAppBar = Demo.StandardTopAppBar.defaultModel
    , switch = Demo.Switch.defaultModel
    , tabbar = Demo.TabBar.defaultModel
    , textfields = Demo.TextFields.defaultModel
    , theme = Demo.Theme.defaultModel
    , topAppBar = Demo.TopAppBar.defaultModel
    , typography = Demo.Typography.defaultModel
    }


type Msg
    = NoOp
    | UrlChanged Url.Url
    | UrlRequested Browser.UrlRequest
    | OpenCatalogDrawer
    | CloseCatalogDrawer
    | ButtonsMsg Demo.Buttons.Msg
    | CardsMsg Demo.Cards.Msg
    | CheckboxMsg Demo.Checkbox.Msg
    | ChipsMsg Demo.Chips.Msg
    | DialogMsg Demo.Dialog.Msg
    | DismissibleDrawerMsg Demo.DismissibleDrawer.Msg
    | DrawerMsg Demo.Drawer.Msg
    | ElevationMsg Demo.Elevation.Msg
    | FabsMsg Demo.Fabs.Msg
    | IconButtonMsg Demo.IconButton.Msg
    | ImageListMsg Demo.ImageList.Msg
    | LayoutGridMsg Demo.LayoutGrid.Msg
    | LinearProgressMsg Demo.LinearProgress.Msg
    | ListsMsg Demo.Lists.Msg
    | MenuMsg Demo.Menus.Msg
    | ModalDrawerMsg Demo.ModalDrawer.Msg
    | PermanentDrawerMsg Demo.PermanentDrawer.Msg
    | RadioButtonsMsg Demo.RadioButtons.Msg
    | RippleMsg Demo.Ripple.Msg
    | SelectMsg Demo.Selects.Msg
    | SliderMsg Demo.Slider.Msg
    | SnackbarMsg Demo.Snackbar.Msg
    | StandardTopAppBarMsg Demo.StandardTopAppBar.Msg
    | SwitchMsg Demo.Switch.Msg
    | TabBarMsg Demo.TabBar.Msg
    | TextFieldMsg Demo.TextFields.Msg
    | ThemeMsg Demo.Theme.Msg
    | TopAppBarMsg Demo.TopAppBar.Msg
    | TypographyMsg Demo.Typography.Msg
    | ShortCollapsedTopAppBarMsg Demo.ShortCollapsedTopAppBar.Msg
    | DenseTopAppBarMsg Demo.DenseTopAppBar.Msg
    | ShortTopAppBarMsg Demo.ShortTopAppBar.Msg
    | ProminentTopAppBarMsg Demo.ProminentTopAppBar.Msg
    | FixedTopAppBarMsg Demo.FixedTopAppBar.Msg


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )

        UrlRequested (Browser.Internal url) ->
            ( model, Browser.Navigation.load (Demo.Url.toString (Demo.Url.fromUrl url)) )

        UrlRequested (Browser.External string) ->
            ( model, Cmd.none )

        UrlChanged url ->
            ( { model
                | url = Demo.Url.fromUrl url
                , catalogDrawerOpen =
                    if Demo.Url.fromUrl url /= Demo.Url.StartPage then
                        model.catalogDrawerOpen

                    else
                        False
              }
            , if Demo.Url.fromUrl url /= model.url then
                Task.attempt (\_ -> NoOp) (Browser.Dom.setViewportOf "demo-content" 0 0)

              else
                Cmd.none
            )

        OpenCatalogDrawer ->
            ( { model | catalogDrawerOpen = True }, Cmd.none )

        CloseCatalogDrawer ->
            ( { model | catalogDrawerOpen = False }, Cmd.none )

        ButtonsMsg msg_ ->
            ( { model | buttons = Demo.Buttons.update msg_ model.buttons }, Cmd.none )

        CardsMsg msg_ ->
            ( { model | cards = Demo.Cards.update msg_ model.cards }, Cmd.none )

        CheckboxMsg msg_ ->
            ( { model | checkbox = Demo.Checkbox.update msg_ model.checkbox }, Cmd.none )

        ChipsMsg msg_ ->
            ( { model | chips = Demo.Chips.update msg_ model.chips }, Cmd.none )

        DialogMsg msg_ ->
            ( { model | dialog = Demo.Dialog.update msg_ model.dialog }, Cmd.none )

        ElevationMsg msg_ ->
            ( { model | elevation = Demo.Elevation.update msg_ model.elevation }
            , Cmd.none
            )

        DrawerMsg msg_ ->
            ( { model | drawer = Demo.Drawer.update msg_ model.drawer }, Cmd.none )

        DismissibleDrawerMsg msg_ ->
            ( { model
                | dismissibleDrawer =
                    Demo.DismissibleDrawer.update msg_ model.dismissibleDrawer
              }
            , Cmd.none
            )

        ModalDrawerMsg msg_ ->
            ( { model | modalDrawer = Demo.ModalDrawer.update msg_ model.modalDrawer }
            , Cmd.none
            )

        PermanentDrawerMsg msg_ ->
            ( { model
                | permanentDrawer = Demo.PermanentDrawer.update msg_ model.permanentDrawer
              }
            , Cmd.none
            )

        FabsMsg msg_ ->
            ( { model | fabs = Demo.Fabs.update msg_ model.fabs }, Cmd.none )

        IconButtonMsg msg_ ->
            ( { model | iconButton = Demo.IconButton.update msg_ model.iconButton }
            , Cmd.none
            )

        ImageListMsg msg_ ->
            ( { model | imageList = Demo.ImageList.update msg_ model.imageList }
            , Cmd.none
            )

        MenuMsg msg_ ->
            ( { model | menus = Demo.Menus.update msg_ model.menus }, Cmd.none )

        RadioButtonsMsg msg_ ->
            ( { model | radio = Demo.RadioButtons.update msg_ model.radio }, Cmd.none )

        RippleMsg msg_ ->
            ( { model | ripple = Demo.Ripple.update msg_ model.ripple }, Cmd.none )

        SelectMsg msg_ ->
            ( { model | selects = Demo.Selects.update msg_ model.selects }, Cmd.none )

        SliderMsg msg_ ->
            ( { model | slider = Demo.Slider.update msg_ model.slider }, Cmd.none )

        SnackbarMsg msg_ ->
            Demo.Snackbar.update msg_ model.snackbar
                |> Tuple.mapFirst (\snackbar -> { model | snackbar = snackbar })
                |> Tuple.mapSecond (Cmd.map SnackbarMsg)

        SwitchMsg msg_ ->
            ( { model | switch = Demo.Switch.update msg_ model.switch }, Cmd.none )

        TextFieldMsg msg_ ->
            ( { model | textfields = Demo.TextFields.update msg_ model.textfields }
            , Cmd.none
            )

        TabBarMsg msg_ ->
            ( { model | tabbar = Demo.TabBar.update msg_ model.tabbar }, Cmd.none )

        LayoutGridMsg msg_ ->
            ( { model | layoutGrid = Demo.LayoutGrid.update msg_ model.layoutGrid }
            , Cmd.none
            )

        ListsMsg msg_ ->
            ( { model | lists = Demo.Lists.update msg_ model.lists }, Cmd.none )

        ThemeMsg msg_ ->
            ( { model | theme = Demo.Theme.update msg_ model.theme }, Cmd.none )

        TopAppBarMsg msg_ ->
            ( { model | topAppBar = Demo.TopAppBar.update msg_ model.topAppBar }
            , Cmd.none
            )

        LinearProgressMsg msg_ ->
            ( { model
                | linearProgress = Demo.LinearProgress.update msg_ model.linearProgress
              }
            , Cmd.none
            )

        TypographyMsg msg_ ->
            ( { model | typography = Demo.Typography.update msg_ model.typography }
            , Cmd.none
            )

        StandardTopAppBarMsg msg_ ->
            ( { model
                | standardTopAppBar =
                    Demo.StandardTopAppBar.update msg_ model.standardTopAppBar
              }
            , Cmd.none
            )

        FixedTopAppBarMsg msg_ ->
            ( { model
                | fixedTopAppBar = Demo.FixedTopAppBar.update msg_ model.fixedTopAppBar
              }
            , Cmd.none
            )

        DenseTopAppBarMsg msg_ ->
            ( { model
                | denseTopAppBar = Demo.DenseTopAppBar.update msg_ model.denseTopAppBar
              }
            , Cmd.none
            )

        ProminentTopAppBarMsg msg_ ->
            ( { model
                | prominentTopAppBar =
                    Demo.ProminentTopAppBar.update msg_ model.prominentTopAppBar
              }
            , Cmd.none
            )

        ShortCollapsedTopAppBarMsg msg_ ->
            ( { model
                | shortCollapsedTopAppBar =
                    Demo.ShortCollapsedTopAppBar.update msg_ model.shortCollapsedTopAppBar
              }
            , Cmd.none
            )

        ShortTopAppBarMsg msg_ ->
            ( { model
                | shortTopAppBar = Demo.ShortTopAppBar.update msg_ model.shortTopAppBar
              }
            , Cmd.none
            )


view : Model -> Browser.Document Msg
view model =
    { title = "Material Components for Elm"
    , body = [ body model ]
    }


body : Model -> Html Msg
body model =
    let
        catalogPageConfig =
            { openDrawer = OpenCatalogDrawer
            , closeDrawer = CloseCatalogDrawer
            , drawerOpen = model.catalogDrawerOpen
            , url = model.url
            }
    in
    case model.url of
        Demo.Url.StartPage ->
            Demo.Startpage.view

        Demo.Url.Button ->
            CatalogPage.view ButtonsMsg catalogPageConfig (Demo.Buttons.view model.buttons)

        Demo.Url.Card ->
            CatalogPage.view CardsMsg catalogPageConfig (Demo.Cards.view model.cards)

        Demo.Url.Checkbox ->
            CatalogPage.view CheckboxMsg
                catalogPageConfig
                (Demo.Checkbox.view model.checkbox)

        Demo.Url.Chips ->
            CatalogPage.view ChipsMsg catalogPageConfig (Demo.Chips.view model.chips)

        Demo.Url.Dialog ->
            CatalogPage.view DialogMsg catalogPageConfig (Demo.Dialog.view model.dialog)

        Demo.Url.Drawer ->
            CatalogPage.view DrawerMsg catalogPageConfig (Demo.Drawer.view model.drawer)

        Demo.Url.DismissibleDrawer ->
            DrawerPage.view DismissibleDrawerMsg
                (Demo.DismissibleDrawer.view model.dismissibleDrawer)

        Demo.Url.ModalDrawer ->
            DrawerPage.view ModalDrawerMsg (Demo.ModalDrawer.view model.modalDrawer)

        Demo.Url.PermanentDrawer ->
            DrawerPage.view PermanentDrawerMsg
                (Demo.PermanentDrawer.view model.permanentDrawer)

        Demo.Url.Elevation ->
            CatalogPage.view ElevationMsg
                catalogPageConfig
                (Demo.Elevation.view model.elevation)

        Demo.Url.Fab ->
            CatalogPage.view FabsMsg catalogPageConfig (Demo.Fabs.view model.fabs)

        Demo.Url.IconButton ->
            CatalogPage.view IconButtonMsg
                catalogPageConfig
                (Demo.IconButton.view model.iconButton)

        Demo.Url.ImageList ->
            CatalogPage.view ImageListMsg
                catalogPageConfig
                (Demo.ImageList.view model.imageList)

        Demo.Url.LinearProgress ->
            CatalogPage.view LinearProgressMsg
                catalogPageConfig
                (Demo.LinearProgress.view model.linearProgress)

        Demo.Url.List ->
            CatalogPage.view ListsMsg catalogPageConfig (Demo.Lists.view model.lists)

        Demo.Url.RadioButton ->
            CatalogPage.view RadioButtonsMsg
                catalogPageConfig
                (Demo.RadioButtons.view model.radio)

        Demo.Url.Select ->
            CatalogPage.view SelectMsg catalogPageConfig (Demo.Selects.view model.selects)

        Demo.Url.Menu ->
            CatalogPage.view MenuMsg catalogPageConfig (Demo.Menus.view model.menus)

        Demo.Url.Slider ->
            CatalogPage.view SliderMsg catalogPageConfig (Demo.Slider.view model.slider)

        Demo.Url.Snackbar ->
            CatalogPage.view SnackbarMsg
                catalogPageConfig
                (Demo.Snackbar.view model.snackbar)

        Demo.Url.Switch ->
            CatalogPage.view SwitchMsg catalogPageConfig (Demo.Switch.view model.switch)

        Demo.Url.TabBar ->
            CatalogPage.view TabBarMsg catalogPageConfig (Demo.TabBar.view model.tabbar)

        Demo.Url.TextField ->
            CatalogPage.view TextFieldMsg
                catalogPageConfig
                (Demo.TextFields.view model.textfields)

        Demo.Url.Theme ->
            CatalogPage.view ThemeMsg catalogPageConfig (Demo.Theme.view model.theme)

        Demo.Url.TopAppBar ->
            CatalogPage.view TopAppBarMsg
                catalogPageConfig
                (Demo.TopAppBar.view model.topAppBar)

        Demo.Url.StandardTopAppBar ->
            TopAppBarPage.view StandardTopAppBarMsg
                (Demo.StandardTopAppBar.view model.standardTopAppBar)

        Demo.Url.FixedTopAppBar ->
            TopAppBarPage.view FixedTopAppBarMsg
                (Demo.FixedTopAppBar.view model.fixedTopAppBar)

        Demo.Url.ProminentTopAppBar ->
            TopAppBarPage.view ProminentTopAppBarMsg
                (Demo.ProminentTopAppBar.view model.prominentTopAppBar)

        Demo.Url.ShortTopAppBar ->
            TopAppBarPage.view ShortTopAppBarMsg
                (Demo.ShortTopAppBar.view model.shortTopAppBar)

        Demo.Url.DenseTopAppBar ->
            TopAppBarPage.view DenseTopAppBarMsg
                (Demo.DenseTopAppBar.view model.denseTopAppBar)

        Demo.Url.ShortCollapsedTopAppBar ->
            TopAppBarPage.view ShortCollapsedTopAppBarMsg
                (Demo.ShortCollapsedTopAppBar.view model.shortCollapsedTopAppBar)

        Demo.Url.LayoutGrid ->
            CatalogPage.view LayoutGridMsg
                catalogPageConfig
                (Demo.LayoutGrid.view model.layoutGrid)

        Demo.Url.Ripple ->
            CatalogPage.view RippleMsg catalogPageConfig (Demo.Ripple.view model.ripple)

        Demo.Url.Typography ->
            CatalogPage.view TypographyMsg
                catalogPageConfig
                (Demo.Typography.view model.typography)

        Demo.Url.Error404 requestedHash ->
            Html.div
                []
                [ Html.h1
                    [ Typography.headline1
                    ]
                    [ text "404" ]
                , text requestedHash
                ]


urlOf : Model -> String
urlOf model =
    Demo.Url.toString model.url


main : Program () Model Msg
main =
    Browser.application
        { init = init
        , view = view
        , subscriptions = subscriptions
        , update = update
        , onUrlRequest = UrlRequested
        , onUrlChange = UrlChanged
        }


init : () -> Url.Url -> Browser.Navigation.Key -> ( Model, Cmd Msg )
init flags url key =
    let
        initialModel =
            defaultModel key
    in
    ( { initialModel | url = Demo.Url.fromUrl url }, Cmd.none )


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none
