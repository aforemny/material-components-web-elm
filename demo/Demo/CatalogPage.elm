module Demo.CatalogPage exposing (CatalogPage, CatalogPageResources, view)

import Demo.Url as Url
import Html exposing (Html, text)
import Html.Attributes
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


view : (msg -> topMsg) -> CatalogPage msg -> Html topMsg
view lift catalogPage =
    Html.map lift <|
        Html.div catalogPageContainer
            [ topAppBar topAppBarConfig
                [ TopAppBar.section [ TopAppBar.alignStart ]
                    [ Html.a
                        [ Html.Attributes.href (Url.toString Url.StartPage) ]
                        [ iconButton
                            { iconButtonConfig
                                | additionalAttributes = [ TopAppBar.navigationIcon ]
                            }
                            "menu"
                        ]
                    , Html.span
                        [ TopAppBar.title
                        , Html.Attributes.style "text-transform" "uppercase"
                        , Html.Attributes.style "font-weight" "400"
                        ]
                        [ text "Material Components for Elm" ]
                    ]
                ]
            , Html.div demoPanel
                [ Html.div (TopAppBar.fixedAdjust :: demoContent)
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
        [ listItem listItemConfig
            [ listItemGraphic resourcesGraphic
                [ Html.img
                    (Html.Attributes.src "images/ic_material_design_24px.svg"
                        :: resourcesGraphic
                    )
                    []
                ]
            , text "Material Design Guidelines"
            ]
        , listItem listItemConfig
            [ listItemGraphic resourcesGraphic
                [ Html.img
                    (Html.Attributes.src "images/ic_drive_document_24px.svg"
                        :: resourcesGraphic
                    )
                    []
                ]
            , text "Documentation"
            ]
        , listItem listItemConfig
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


catalogPageContainer : List (Html.Attribute msg)
catalogPageContainer =
    [ Html.Attributes.style "position" "relative" ]


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
    [ Html.Attributes.style "height" "100%"
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
