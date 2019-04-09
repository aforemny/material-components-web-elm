module Demo.Url exposing
    ( Url(..)
    , fromString
    , fromUrl
    , toString
    )

import Url


type Url
    = StartPage
    | Button
    | Card
    | Checkbox
    | Chips
    | Dialog
    | Drawer
    | DismissibleDrawer
    | ModalDrawer
    | PermanentDrawer
    | Elevation
    | Fab
    | IconButton
    | ImageList
    | LayoutGrid
    | LinearProgress
    | List
    | RadioButton
    | Ripple
    | Select
    | Menu
    | Slider
    | Snackbar
    | Switch
    | TabBar
    | TextField
    | Theme
    | TopAppBar
    | StandardTopAppBar
    | FixedTopAppBar
    | DenseTopAppBar
    | ProminentTopAppBar
    | ShortTopAppBar
    | ShortCollapsedTopAppBar
    | Typography
    | Error404 String


toString : Url -> String
toString url =
    case url of
        StartPage ->
            "#"

        Button ->
            "#buttons"

        Card ->
            "#cards"

        Checkbox ->
            "#checkbox"

        Chips ->
            "#chips"

        Dialog ->
            "#dialog"

        Drawer ->
            "#drawer"

        DismissibleDrawer ->
            "#dismissible-drawer"

        ModalDrawer ->
            "#modal-drawer"

        PermanentDrawer ->
            "#permanent-drawer"

        Elevation ->
            "#elevation"

        Fab ->
            "#fab"

        IconButton ->
            "#icon-button"

        ImageList ->
            "#image-list"

        LayoutGrid ->
            "#layout-grid"

        LinearProgress ->
            "#linear-progress"

        List ->
            "#lists"

        RadioButton ->
            "#radio-buttons"

        Ripple ->
            "#ripple"

        Select ->
            "#select"

        Menu ->
            "#menu"

        Slider ->
            "#slider"

        Snackbar ->
            "#snackbar"

        Switch ->
            "#switch"

        TabBar ->
            "#tabbar"

        TextField ->
            "#text-field"

        Theme ->
            "#theme"

        TopAppBar ->
            "#top-app-bar"

        StandardTopAppBar ->
            "#top-app-bar/standard"

        FixedTopAppBar ->
            "#top-app-bar/fixed"

        DenseTopAppBar ->
            "#top-app-bar/dense"

        ProminentTopAppBar ->
            "#top-app-bar/prominent"

        ShortTopAppBar ->
            "#top-app-bar/short"

        ShortCollapsedTopAppBar ->
            "#top-app-bar/short-collapsed"

        Typography ->
            "#typography"

        Error404 requestedHash ->
            requestedHash


fromUrl : Url.Url -> Url
fromUrl url =
    fromString (Maybe.withDefault "" url.fragment)


fromString : String -> Url
fromString url =
    case url of
        "" ->
            StartPage

        "buttons" ->
            Button

        "cards" ->
            Card

        "checkbox" ->
            Checkbox

        "chips" ->
            Chips

        "dialog" ->
            Dialog

        "drawer" ->
            Drawer

        "dismissible-drawer" ->
            DismissibleDrawer

        "modal-drawer" ->
            ModalDrawer

        "permanent-drawer" ->
            PermanentDrawer

        "elevation" ->
            Elevation

        "fab" ->
            Fab

        "icon-button" ->
            IconButton

        "image-list" ->
            ImageList

        "layout-grid" ->
            LayoutGrid

        "linear-progress" ->
            LinearProgress

        "lists" ->
            List

        "radio-buttons" ->
            RadioButton

        "ripple" ->
            Ripple

        "select" ->
            Select

        "menu" ->
            Menu

        "slider" ->
            Slider

        "snackbar" ->
            Snackbar

        "switch" ->
            Switch

        "tabbar" ->
            TabBar

        "text-field" ->
            TextField

        "theme" ->
            Theme

        "top-app-bar" ->
            TopAppBar

        "top-app-bar/standard" ->
            StandardTopAppBar

        "top-app-bar/fixed" ->
            FixedTopAppBar

        "top-app-bar/dense" ->
            DenseTopAppBar

        "top-app-bar/prominent" ->
            ProminentTopAppBar

        "top-app-bar/short" ->
            ShortTopAppBar

        "top-app-bar/short-collapsed" ->
            ShortCollapsedTopAppBar

        "typography" ->
            Typography

        _ ->
            Error404 url
