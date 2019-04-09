module Main exposing (main)

import Browser
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
import Url


type alias Model =
    { key : Browser.Navigation.Key
    , url : Demo.Url.Url
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
    , url = Demo.Url.StartPage
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
            ( { model | url = Demo.Url.fromUrl url }
            , Browser.Navigation.load (Demo.Url.toString (Demo.Url.fromUrl url))
            )

        UrlRequested (Browser.External string) ->
            ( model, Cmd.none )

        UrlChanged url ->
            ( { model | url = Demo.Url.fromUrl url }, Cmd.none )

        ButtonsMsg msg_ ->
            let
                ( buttons, effects ) =
                    Demo.Buttons.update ButtonsMsg msg_ model.buttons
            in
            ( { model | buttons = buttons }, effects )

        CardsMsg msg_ ->
            let
                ( cards, effects ) =
                    Demo.Cards.update CardsMsg msg_ model.cards
            in
            ( { model | cards = cards }, effects )

        CheckboxMsg msg_ ->
            let
                ( checkbox, effects ) =
                    Demo.Checkbox.update CheckboxMsg msg_ model.checkbox
            in
            ( { model | checkbox = checkbox }, effects )

        ChipsMsg msg_ ->
            let
                ( chips, effects ) =
                    Demo.Chips.update ChipsMsg msg_ model.chips
            in
            ( { model | chips = chips }, effects )

        DialogMsg msg_ ->
            let
                ( dialog, effects ) =
                    Demo.Dialog.update DialogMsg msg_ model.dialog
            in
            ( { model | dialog = dialog }, effects )

        ElevationMsg msg_ ->
            let
                ( elevation, effects ) =
                    Demo.Elevation.update ElevationMsg msg_ model.elevation
            in
            ( { model | elevation = elevation }, effects )

        DrawerMsg msg_ ->
            let
                ( drawer, effects ) =
                    Demo.Drawer.update DrawerMsg msg_ model.drawer
            in
            ( { model | drawer = drawer }, effects )

        DismissibleDrawerMsg msg_ ->
            let
                ( dismissibleDrawer, effects ) =
                    Demo.DismissibleDrawer.update DismissibleDrawerMsg msg_ model.dismissibleDrawer
            in
            ( { model | dismissibleDrawer = dismissibleDrawer }, effects )

        ModalDrawerMsg msg_ ->
            let
                ( modalDrawer, effects ) =
                    Demo.ModalDrawer.update ModalDrawerMsg msg_ model.modalDrawer
            in
            ( { model | modalDrawer = modalDrawer }, effects )

        PermanentDrawerMsg msg_ ->
            let
                ( permanentDrawer, effects ) =
                    Demo.PermanentDrawer.update PermanentDrawerMsg msg_ model.permanentDrawer
            in
            ( { model | permanentDrawer = permanentDrawer }, effects )

        FabsMsg msg_ ->
            let
                ( fabs, effects ) =
                    Demo.Fabs.update FabsMsg msg_ model.fabs
            in
            ( { model | fabs = fabs }, effects )

        IconButtonMsg msg_ ->
            let
                ( iconButton, effects ) =
                    Demo.IconButton.update IconButtonMsg msg_ model.iconButton
            in
            ( { model | iconButton = iconButton }, effects )

        ImageListMsg msg_ ->
            let
                ( imageList, effects ) =
                    Demo.ImageList.update ImageListMsg msg_ model.imageList
            in
            ( { model | imageList = imageList }, effects )

        MenuMsg msg_ ->
            let
                ( menus, effects ) =
                    Demo.Menus.update MenuMsg msg_ model.menus
            in
            ( { model | menus = menus }, effects )

        RadioButtonsMsg msg_ ->
            let
                ( radio, effects ) =
                    Demo.RadioButtons.update RadioButtonsMsg msg_ model.radio
            in
            ( { model | radio = radio }, effects )

        RippleMsg msg_ ->
            let
                ( ripple, effects ) =
                    Demo.Ripple.update RippleMsg msg_ model.ripple
            in
            ( { model | ripple = ripple }, effects )

        SelectMsg msg_ ->
            let
                ( selects, effects ) =
                    Demo.Selects.update SelectMsg msg_ model.selects
            in
            ( { model | selects = selects }, effects )

        SliderMsg msg_ ->
            let
                ( slider, effects ) =
                    Demo.Slider.update SliderMsg msg_ model.slider
            in
            ( { model | slider = slider }, effects )

        SnackbarMsg msg_ ->
            let
                ( snackbar, effects ) =
                    Demo.Snackbar.update SnackbarMsg msg_ model.snackbar
            in
            ( { model | snackbar = snackbar }, effects )

        SwitchMsg msg_ ->
            let
                ( switch, effects ) =
                    Demo.Switch.update SwitchMsg msg_ model.switch
            in
            ( { model | switch = switch }, effects )

        TextFieldMsg msg_ ->
            let
                ( textfields, effects ) =
                    Demo.TextFields.update TextFieldMsg msg_ model.textfields
            in
            ( { model | textfields = textfields }, effects )

        TabBarMsg msg_ ->
            let
                ( tabbar, effects ) =
                    Demo.TabBar.update TabBarMsg msg_ model.tabbar
            in
            ( { model | tabbar = tabbar }, effects )

        LayoutGridMsg msg_ ->
            let
                ( layoutGrid, effects ) =
                    Demo.LayoutGrid.update LayoutGridMsg msg_ model.layoutGrid
            in
            ( { model | layoutGrid = layoutGrid }, effects )

        ListsMsg msg_ ->
            let
                ( lists, effects ) =
                    Demo.Lists.update ListsMsg msg_ model.lists
            in
            ( { model | lists = lists }, effects )

        ThemeMsg msg_ ->
            let
                ( theme, effects ) =
                    Demo.Theme.update ThemeMsg msg_ model.theme
            in
            ( { model | theme = theme }, effects )

        TopAppBarMsg msg_ ->
            let
                ( topAppBar, effects ) =
                    Demo.TopAppBar.update TopAppBarMsg msg_ model.topAppBar
            in
            ( { model | topAppBar = topAppBar }, effects )

        LinearProgressMsg msg_ ->
            let
                ( linearProgress, effects ) =
                    Demo.LinearProgress.update LinearProgressMsg msg_ model.linearProgress
            in
            ( { model | linearProgress = linearProgress }, effects )

        TypographyMsg msg_ ->
            let
                ( typography, effects ) =
                    Demo.Typography.update TypographyMsg msg_ model.typography
            in
            ( { model | typography = typography }, effects )

        StandardTopAppBarMsg msg_ ->
            let
                ( standardTopAppBar, effects ) =
                    Demo.StandardTopAppBar.update StandardTopAppBarMsg msg_ model.standardTopAppBar
            in
            ( { model | standardTopAppBar = standardTopAppBar }, effects )

        FixedTopAppBarMsg msg_ ->
            let
                ( fixedTopAppBar, effects ) =
                    Demo.FixedTopAppBar.update FixedTopAppBarMsg msg_ model.fixedTopAppBar
            in
            ( { model | fixedTopAppBar = fixedTopAppBar }, effects )

        DenseTopAppBarMsg msg_ ->
            let
                ( denseTopAppBar, effects ) =
                    Demo.DenseTopAppBar.update DenseTopAppBarMsg msg_ model.denseTopAppBar
            in
            ( { model | denseTopAppBar = denseTopAppBar }, effects )

        ProminentTopAppBarMsg msg_ ->
            let
                ( prominentTopAppBar, effects ) =
                    Demo.ProminentTopAppBar.update ProminentTopAppBarMsg msg_ model.prominentTopAppBar
            in
            ( { model | prominentTopAppBar = prominentTopAppBar }, effects )

        ShortCollapsedTopAppBarMsg msg_ ->
            let
                ( shortCollapsedTopAppBar, effects ) =
                    Demo.ShortCollapsedTopAppBar.update ShortCollapsedTopAppBarMsg msg_ model.shortCollapsedTopAppBar
            in
            ( { model | shortCollapsedTopAppBar = shortCollapsedTopAppBar }, effects )

        ShortTopAppBarMsg msg_ ->
            let
                ( shortTopAppBar, effects ) =
                    Demo.ShortTopAppBar.update ShortTopAppBarMsg msg_ model.shortTopAppBar
            in
            ( { model | shortTopAppBar = shortTopAppBar }, effects )


view : Model -> Browser.Document Msg
view model =
    { title = "The elm-mdc library"
    , body = [ body model ]
    }


body : Model -> Html Msg
body model =
    case model.url of
        Demo.Url.StartPage ->
            Demo.Startpage.view

        Demo.Url.Button ->
            CatalogPage.view ButtonsMsg (Demo.Buttons.view model.buttons)

        Demo.Url.Card ->
            CatalogPage.view CardsMsg (Demo.Cards.view model.cards)

        Demo.Url.Checkbox ->
            CatalogPage.view CheckboxMsg (Demo.Checkbox.view model.checkbox)

        Demo.Url.Chips ->
            CatalogPage.view ChipsMsg (Demo.Chips.view model.chips)

        Demo.Url.Dialog ->
            CatalogPage.view DialogMsg (Demo.Dialog.view model.dialog)

        Demo.Url.Drawer ->
            CatalogPage.view DrawerMsg (Demo.Drawer.view model.drawer)

        Demo.Url.DismissibleDrawer ->
            DrawerPage.view DismissibleDrawerMsg (Demo.DismissibleDrawer.view model.dismissibleDrawer)

        Demo.Url.ModalDrawer ->
            DrawerPage.view ModalDrawerMsg (Demo.ModalDrawer.view model.modalDrawer)

        Demo.Url.PermanentDrawer ->
            DrawerPage.view PermanentDrawerMsg (Demo.PermanentDrawer.view model.permanentDrawer)

        Demo.Url.Elevation ->
            CatalogPage.view ElevationMsg (Demo.Elevation.view model.elevation)

        Demo.Url.Fabs ->
            CatalogPage.view FabsMsg (Demo.Fabs.view model.fabs)

        Demo.Url.IconButton ->
            CatalogPage.view IconButtonMsg (Demo.IconButton.view model.iconButton)

        Demo.Url.ImageList ->
            CatalogPage.view ImageListMsg (Demo.ImageList.view model.imageList)

        Demo.Url.LinearProgress ->
            CatalogPage.view LinearProgressMsg (Demo.LinearProgress.view model.linearProgress)

        Demo.Url.List ->
            CatalogPage.view ListsMsg (Demo.Lists.view model.lists)

        Demo.Url.RadioButton ->
            CatalogPage.view RadioButtonsMsg (Demo.RadioButtons.view model.radio)

        Demo.Url.Select ->
            CatalogPage.view SelectMsg (Demo.Selects.view model.selects)

        Demo.Url.Menu ->
            CatalogPage.view MenuMsg (Demo.Menus.view model.menus)

        Demo.Url.Slider ->
            CatalogPage.view SliderMsg (Demo.Slider.view model.slider)

        Demo.Url.Snackbar ->
            CatalogPage.view SnackbarMsg (Demo.Snackbar.view model.snackbar)

        Demo.Url.Switch ->
            CatalogPage.view SwitchMsg (Demo.Switch.view model.switch)

        Demo.Url.TabBar ->
            CatalogPage.view TabBarMsg (Demo.TabBar.view model.tabbar)

        Demo.Url.TextField ->
            CatalogPage.view TextFieldMsg (Demo.TextFields.view model.textfields)

        Demo.Url.Theme ->
            CatalogPage.view ThemeMsg (Demo.Theme.view model.theme)

        Demo.Url.TopAppBar ->
            CatalogPage.view TopAppBarMsg (Demo.TopAppBar.view model.topAppBar)

        Demo.Url.StandardTopAppBar ->
            TopAppBarPage.view StandardTopAppBarMsg (Demo.StandardTopAppBar.view model.standardTopAppBar)

        Demo.Url.FixedTopAppBar ->
            TopAppBarPage.view FixedTopAppBarMsg (Demo.FixedTopAppBar.view model.fixedTopAppBar)

        Demo.Url.ProminentTopAppBar ->
            TopAppBarPage.view ProminentTopAppBarMsg (Demo.ProminentTopAppBar.view model.prominentTopAppBar)

        Demo.Url.ShortTopAppBar ->
            TopAppBarPage.view ShortTopAppBarMsg (Demo.ShortTopAppBar.view model.shortTopAppBar)

        Demo.Url.DenseTopAppBar ->
            TopAppBarPage.view DenseTopAppBarMsg (Demo.DenseTopAppBar.view model.denseTopAppBar)

        Demo.Url.ShortCollapsedTopAppBar ->
            TopAppBarPage.view ShortCollapsedTopAppBarMsg (Demo.ShortCollapsedTopAppBar.view model.shortCollapsedTopAppBar)

        Demo.Url.LayoutGrid ->
            CatalogPage.view LayoutGridMsg (Demo.LayoutGrid.view model.layoutGrid)

        Demo.Url.Ripple ->
            CatalogPage.view RippleMsg (Demo.Ripple.view model.ripple)

        Demo.Url.Typography ->
            CatalogPage.view TypographyMsg (Demo.Typography.view model.typography)

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
