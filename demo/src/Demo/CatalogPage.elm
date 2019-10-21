module Demo.CatalogPage exposing (CatalogPage, CatalogPageResources, view)

import Demo.Url as Url exposing (Url)
import Html exposing (Html, text)
import Html.Attributes
import Html.Events
import Json.Decode as Decode
import Material.Drawer as Drawer exposing (dismissibleDrawer, dismissibleDrawerConfig, drawerContent)
import Material.Icon exposing (icon, iconConfig)
import Material.IconButton exposing (iconButton, iconButtonConfig)
import Material.List exposing (list, listConfig, listItem, listItemConfig, listItemGraphic)
import Material.TopAppBar as TopAppBar exposing (topAppBar, topAppBarConfig)
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
        [ topAppBar topAppBarConfig
            [ TopAppBar.row []
                [ TopAppBar.section [ TopAppBar.alignStart ]
                    [ iconButton
                        { iconButtonConfig
                            | additionalAttributes = [ TopAppBar.navigationIcon ]
                            , onClick = Just toggleCatalogDrawer
                        }
                        "menu"
                    , Html.span
                        [ TopAppBar.title
                        , Html.Attributes.style "text-transform" "uppercase"
                        , Html.Attributes.style "font-weight" "400"
                        ]
                        [ text "Material Components for Elm" ]
                    ]
                ]
            ]
        , Html.div demoPanel
            [ dismissibleDrawer
                { dismissibleDrawerConfig
                    | open = catalogPageConfig.drawerOpen
                    , additionalAttributes =
                        [ TopAppBar.fixedAdjust
                        , Html.Attributes.style "z-index" "1"
                        ]
                }
                [ drawerContent []
                    [ list listConfig
                        (List.map
                            (\{ url, label } ->
                                listItem
                                    { listItemConfig
                                        | activated = catalogPageConfig.url == url
                                        , href = Just (Url.toString url)
                                    }
                                    [ text label ]
                            )
                            catalogDrawerItems
                        )
                    ]
                ]
            , Html.map lift <|
                Html.div (TopAppBar.fixedAdjust :: Drawer.appContent :: demoContent)
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
    list listConfig
        [ listItem
            { listItemConfig
                | href = materialDesignGuidelines
                , target = Just "_blank"
            }
            [ listItemGraphic resourcesGraphic
                [ Html.img
                    (Html.Attributes.src "images/ic_material_design_24px.svg"
                        :: resourcesGraphic
                    )
                    []
                ]
            , text "Material Design Guidelines"
            ]
        , listItem
            { listItemConfig
                | href = documentation
                , target = Just "_blank"
            }
            [ listItemGraphic resourcesGraphic
                [ Html.img
                    (Html.Attributes.src "images/ic_drive_document_24px.svg"
                        :: resourcesGraphic
                    )
                    []
                ]
            , text "Documentation"
            ]
        , listItem
            { listItemConfig
                | href = sourceCode
                , target = Just "_blank"
            }
            [ listItemGraphic resourcesGraphic
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
    [ Html.Attributes.style "position" "relative"
    , Typography.typography
    ]


demoPanel : List (Html.Attribute msg)
demoPanel =
    [ Html.Attributes.style "display" "-ms-flexbox"
    , Html.Attributes.style "display" "flex"
    , Html.Attributes.style "position" "relative"
    , Html.Attributes.style "height" "100vh"
    , Html.Attributes.style "overflow" "hidden"
    ]


demoContent : List (Html.Attribute msg)
demoContent =
    [ Html.Attributes.id "demo-content"
    , Html.Attributes.style "height" "100%"
    , Html.Attributes.style "-webkit-box-sizing" "border-box"
    , Html.Attributes.style "box-sizing" "border-box"
    , Html.Attributes.style "max-width" "100%"
    , Html.Attributes.style "padding-left" "16px"
    , Html.Attributes.style "padding-right" "16px"
    , Html.Attributes.style "padding-bottom" "100px"
    , Html.Attributes.style "width" "100%"
    , Html.Attributes.style "overflow" "auto"
    , Html.Attributes.style "display" "-ms-flexbox"
    , Html.Attributes.style "display" "flex"
    , Html.Attributes.style "-ms-flex-direction" "column"
    , Html.Attributes.style "flex-direction" "column"
    , Html.Attributes.style "-ms-flex-align" "center"
    , Html.Attributes.style "align-items" "center"
    , Html.Attributes.style "-ms-flex-pack" "start"
    , Html.Attributes.style "justify-content" "flex-start"
    ]


demoContentTransition : List (Html.Attribute msg)
demoContentTransition =
    [ Html.Attributes.style "max-width" "900px"
    , Html.Attributes.style "width" "100%"
    ]


hero : List (Html.Attribute msg)
hero =
    [ Html.Attributes.style "display" "-ms-flexbox"
    , Html.Attributes.style "display" "flex"
    , Html.Attributes.style "-ms-flex-flow" "row nowrap"
    , Html.Attributes.style "flex-flow" "row nowrap"
    , Html.Attributes.style "-ms-flex-align" "center"
    , Html.Attributes.style "align-items" "center"
    , Html.Attributes.style "-ms-flex-pack" "center"
    , Html.Attributes.style "justify-content" "center"
    , Html.Attributes.style "min-height" "360px"
    , Html.Attributes.style "padding" "24px"
    , Html.Attributes.style "background-color" "#f2f2f2"
    ]


demoTitle : List (Html.Attribute msg)
demoTitle =
    [ Html.Attributes.style "border-bottom" "1px solid rgba(0,0,0,.87)"
    ]


resourcesGraphic : List (Html.Attribute msg)
resourcesGraphic =
    [ Html.Attributes.style "width" "30px"
    , Html.Attributes.style "height" "30px"
    ]
