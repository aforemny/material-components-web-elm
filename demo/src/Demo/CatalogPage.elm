module Demo.CatalogPage exposing (CatalogPage, CatalogPageResources, view)

import Demo.Url as Url exposing (Url)
import Html exposing (Html, text)
import Html.Attributes exposing (style)
import Material.Drawer.Dismissible as DismissibleDrawer
import Material.IconButton as IconButton
import Material.List as List
import Material.List.Item as ListItem
import Material.TopAppBar as TopAppBar
import Material.Typography as Typography


type alias CatalogPage msg =
    { title : String
    , prelude : String
    , resources : CatalogPageResources
    , hero : List (Html msg)
    , content : List (Html msg)
    }


type alias CatalogPageResources =
    { materialDesignGuidelines : Maybe String
    , documentation : Maybe String
    , sourceCode : Maybe String
    }


type alias CatalogPageConfig topMsg =
    { openDrawer : topMsg
    , closeDrawer : topMsg
    , drawerOpen : Bool
    , url : Url
    }


view : (msg -> topMsg) -> CatalogPageConfig topMsg -> CatalogPage msg -> Html topMsg
view lift catalogPageConfig catalogPage =
    let
        toggleCatalogDrawer =
            if catalogPageConfig.drawerOpen then
                catalogPageConfig.closeDrawer

            else
                catalogPageConfig.openDrawer
    in
    Html.div catalogPageContainer
        [ TopAppBar.regular TopAppBar.config
            [ TopAppBar.row []
                [ TopAppBar.section [ TopAppBar.alignStart ]
                    [ IconButton.iconButton
                        (IconButton.config
                            |> IconButton.setAttributes [ TopAppBar.navigationIcon ]
                            |> IconButton.setOnClick toggleCatalogDrawer
                        )
                        "menu"
                    , Html.span
                        [ TopAppBar.title
                        , style "text-transform" "uppercase"
                        , style "font-weight" "400"
                        ]
                        [ text "Material Components for Elm" ]
                    ]
                ]
            ]
        , Html.div demoPanel
            [ DismissibleDrawer.drawer
                (DismissibleDrawer.config
                    |> DismissibleDrawer.setOpen catalogPageConfig.drawerOpen
                    |> DismissibleDrawer.setAttributes
                        [ TopAppBar.fixedAdjust
                        , style "z-index" "1"
                        ]
                )
                [ DismissibleDrawer.content []
                    [ List.list List.config
                        (List.map
                            (\{ url, label } ->
                                ListItem.listItem
                                    (ListItem.config
                                        |> ListItem.setSelected
                                            (if catalogPageConfig.url == url then
                                                Just ListItem.activated

                                             else
                                                Nothing
                                            )
                                        |> ListItem.setHref (Just (Url.toString url))
                                    )
                                    [ text label ]
                            )
                            catalogDrawerItems
                        )
                    ]
                ]
            , Html.map lift <|
                Html.div
                    (TopAppBar.fixedAdjust
                        :: DismissibleDrawer.appContent
                        :: demoContent
                    )
                    [ Html.div demoContentTransition
                        (Html.h1 [ Typography.headline5 ] [ text catalogPage.title ]
                            :: Html.p [ Typography.body1 ] [ text catalogPage.prelude ]
                            :: Html.div hero catalogPage.hero
                            :: Html.h2 (Typography.headline6 :: demoTitle)
                                [ text "Resources" ]
                            :: resourcesList catalogPage.resources
                            :: Html.h2 (Typography.headline6 :: demoTitle)
                                [ text "Demos" ]
                            :: catalogPage.content
                        )
                    ]
            ]
        ]


resourcesList : CatalogPageResources -> Html msg
resourcesList { materialDesignGuidelines, documentation, sourceCode } =
    List.list List.config
        [ ListItem.listItem
            (ListItem.config
                |> ListItem.setHref materialDesignGuidelines
                |> ListItem.setTarget (Just "_blank")
            )
            [ ListItem.graphic resourcesGraphic
                [ Html.img
                    (Html.Attributes.src "images/ic_material_design_24px.svg"
                        :: resourcesGraphic
                    )
                    []
                ]
            , text "Material Design Guidelines"
            ]
        , ListItem.listItem
            (ListItem.config
                |> ListItem.setHref documentation
                |> ListItem.setTarget (Just "_blank")
            )
            [ ListItem.graphic resourcesGraphic
                [ Html.img
                    (Html.Attributes.src "images/ic_drive_document_24px.svg"
                        :: resourcesGraphic
                    )
                    []
                ]
            , text "Documentation"
            ]
        , ListItem.listItem
            (ListItem.config
                |> ListItem.setHref sourceCode
                |> ListItem.setTarget (Just "_blank")
            )
            [ ListItem.graphic resourcesGraphic
                [ Html.img
                    (Html.Attributes.src "images/ic_code_24px.svg"
                        :: resourcesGraphic
                    )
                    []
                ]
            , text "Source Code"
            ]
        ]


catalogDrawerItems : List { label : String, url : Url }
catalogDrawerItems =
    [ { label = "Home", url = Url.StartPage }
    , { label = "Button", url = Url.Button }
    , { label = "Card", url = Url.Card }
    , { label = "Checkbox", url = Url.Checkbox }
    , { label = "Chips", url = Url.Chips }
    , { label = "DataTable", url = Url.DataTable }
    , { label = "Dialog", url = Url.Dialog }
    , { label = "Drawer", url = Url.Drawer }
    , { label = "Elevation", url = Url.Elevation }
    , { label = "FAB", url = Url.Fab }
    , { label = "Icon Button", url = Url.IconButton }
    , { label = "Image List", url = Url.ImageList }
    , { label = "Layout Grid", url = Url.LayoutGrid }
    , { label = "Linear Progress Indicator", url = Url.LinearProgress }
    , { label = "List", url = Url.List }
    , { label = "Menu", url = Url.Menu }
    , { label = "Radio Button", url = Url.RadioButton }
    , { label = "Ripple", url = Url.Ripple }
    , { label = "Select", url = Url.Select }
    , { label = "Slider", url = Url.Slider }
    , { label = "Snackbar", url = Url.Snackbar }
    , { label = "Switch", url = Url.Switch }
    , { label = "Tab Bar", url = Url.TabBar }
    , { label = "Text Field", url = Url.TextField }
    , { label = "Theme", url = Url.Theme }
    , { label = "Top App Bar", url = Url.TopAppBar }
    , { label = "Typography", url = Url.Typography }
    ]


catalogPageContainer : List (Html.Attribute msg)
catalogPageContainer =
    [ style "position" "relative"
    , Typography.typography
    ]


demoPanel : List (Html.Attribute msg)
demoPanel =
    [ style "display" "-ms-flexbox"
    , style "display" "flex"
    , style "position" "relative"
    , style "height" "100vh"
    , style "overflow" "hidden"
    ]


demoContent : List (Html.Attribute msg)
demoContent =
    [ Html.Attributes.id "demo-content"
    , style "height" "100%"
    , style "-webkit-box-sizing" "border-box"
    , style "box-sizing" "border-box"
    , style "max-width" "100%"
    , style "padding-left" "16px"
    , style "padding-right" "16px"
    , style "padding-bottom" "100px"
    , style "width" "100%"
    , style "overflow" "auto"
    , style "display" "-ms-flexbox"
    , style "display" "flex"
    , style "-ms-flex-direction" "column"
    , style "flex-direction" "column"
    , style "-ms-flex-align" "center"
    , style "align-items" "center"
    , style "-ms-flex-pack" "start"
    , style "justify-content" "flex-start"
    ]


demoContentTransition : List (Html.Attribute msg)
demoContentTransition =
    [ style "max-width" "900px"
    , style "width" "100%"
    ]


hero : List (Html.Attribute msg)
hero =
    [ style "display" "-ms-flexbox"
    , style "display" "flex"
    , style "-ms-flex-flow" "row nowrap"
    , style "flex-flow" "row nowrap"
    , style "-ms-flex-align" "center"
    , style "align-items" "center"
    , style "-ms-flex-pack" "center"
    , style "justify-content" "center"
    , style "min-height" "360px"
    , style "padding" "24px"
    , style "background-color" "#f2f2f2"
    ]


demoTitle : List (Html.Attribute msg)
demoTitle =
    [ style "border-bottom" "1px solid rgba(0,0,0,.87)"
    ]


resourcesGraphic : List (Html.Attribute msg)
resourcesGraphic =
    [ style "width" "30px"
    , style "height" "30px"
    ]
