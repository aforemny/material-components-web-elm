module Demo.CatalogPage exposing (CatalogPage, CatalogPageResources)

import Demo.Url as Url
import Html exposing (Html, text)
import Html.Attributes
import Material.IconButton exposing (iconButton, iconButtonConfig)
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
    Html.div catalogPageContainer
        [ toolbar
        , Html.div (TopAppBar.fixedAdjust :: demoPanel)
            [ Html.map lift <|
                Html.div demoContent
                    (Html.h1 [ Typography.headline5 ] [ text catalogPage.title ]
                        :: Html.p [ Typography.body1 ] [ text catalogPage.prelude ]
                        :: catalogPage.content
                    )
            ]
        ]


toolbar : Html msg
toolbar =
    topAppBar topAppBarConfig
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
    , Html.Attributes.style "padding" "40px 16px 100px"
    , Html.Attributes.style "padding-top" "40px"
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
