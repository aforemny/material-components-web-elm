module Demo.Theme exposing (Model, Msg, defaultModel, update, view)

import Demo.CatalogPage exposing (CatalogPage)
import Html exposing (Html, text)
import Html.Attributes
import Material.Button exposing (buttonConfig, outlinedButton, raisedButton, textButton)
import Material.Elevation as Elevation
import Material.Theme as Theme
import Material.Typography as Typography


type alias Model =
    {}


defaultModel : Model
defaultModel =
    {}


type Msg
    = NoOp


update : Msg -> Model -> Model
update msg model =
    model


view : Model -> CatalogPage Msg
view model =
    { title = "Theme"
    , prelude = "Color in Material Design is inspired by bold hues juxtaposed with muted environments, deep shadows, and bright highlights."
    , resources =
        { materialDesignGuidelines = Just "https://material.io/go/design-color-theming"
        , documentation = Just "https://package.elm-lang.org/packages/aforemny/material-components-web-elm/latest/Material-Theme"
        , sourceCode = Just "https://github.com/material-components/material-components-web/tree/master/packages/mdc-theme"
        }
    , hero =
        [ textButton
            { buttonConfig
                | additionalAttributes = heroMargin
            }
            "Text"
        , raisedButton
            { buttonConfig
                | additionalAttributes = heroMargin
            }
            "Raised"
        , outlinedButton
            { buttonConfig
                | additionalAttributes = heroMargin
            }
            "Outlined"
        ]
    , content =
        [ Html.legend [ Typography.subtitle1 ] [ text "Theme colors as text" ]
        , themeColorsAsText
        , Html.legend [ Typography.subtitle1 ] [ text "Theme colors as background" ]
        , themeColorsAsBackground
        , Html.legend [ Typography.subtitle1 ] [ text "Text on background" ]
        , textOnBackground
        , Html.legend [ Typography.subtitle1 ] [ text "Text on primary" ]
        , textOnPrimary
        , Html.legend [ Typography.subtitle1 ] [ text "Text on secondary" ]
        , textOnSecondary
        , Html.legend [ Typography.subtitle1 ]
            [ text "Text on user-defined light background" ]
        , textOnLightBackground
        , Html.legend [ Typography.subtitle1 ]
            [ text "Text on user-defined dark background" ]
        , textOnDarkBackground
        ]
    }


themeColorsAsText : Html msg
themeColorsAsText =
    Html.div demoThemeColorGroup
        [ Html.div (Theme.primary :: demoThemeColorSwatches)
            [ Html.div demoThemeColorSwatch [ text "Primary" ] ]
        , Html.div (Theme.secondary :: demoThemeColorSwatches)
            [ Html.div demoThemeColorSwatch [ text "Secondary" ] ]
        ]


themeColorsAsBackground : Html msg
themeColorsAsBackground =
    Html.div demoThemeColorGroup
        [ Html.div
            (Theme.primaryBg :: Theme.onPrimary :: demoThemeColorSwatches)
            [ Html.div demoThemeColorSwatch [ text "Primary" ] ]
        , Html.div
            (Theme.secondaryBg :: Theme.onSecondary :: demoThemeColorSwatches)
            [ Html.div demoThemeColorSwatch [ text "Secondary" ] ]
        , Html.div
            (Theme.background :: Theme.textPrimaryOnBackground :: demoThemeColorSwatches)
            [ Html.div demoThemeColorSwatch [ text "Background" ] ]
        ]


textOnBackground : Html msg
textOnBackground =
    Html.div demoThemeColorGroup
        [ Html.div (Theme.background :: demoThemeTextRow)
            [ Html.span (Theme.textPrimaryOnBackground :: demoThemeTextStyle)
                [ text "Primary" ]
            , Html.span (Theme.textSecondaryOnBackground :: demoThemeTextStyle)
                [ text "Secondary" ]
            , Html.span (Theme.textHintOnBackground :: demoThemeTextStyle)
                [ text "Hint" ]
            , Html.span (Theme.textDisabledOnBackground :: demoThemeTextStyle)
                [ text "Disabled" ]
            , Html.span (Theme.textIconOnBackground :: demoThemeIconStyle)
                [ text "favorite" ]
            ]
        ]


textOnPrimary : Html msg
textOnPrimary =
    Html.div demoThemeColorGroup
        [ Html.div (Theme.primaryBg :: demoThemeTextRow)
            [ Html.span (Theme.onPrimary :: demoThemeTextStyle)
                [ text "Text" ]
            , Html.span (Theme.onPrimary :: demoThemeIconStyle)
                [ text "favorite" ]
            ]
        ]


textOnSecondary : Html msg
textOnSecondary =
    Html.div demoThemeColorGroup
        [ Html.div (Theme.secondaryBg :: demoThemeTextRow)
            [ Html.span (Theme.onSecondary :: demoThemeTextStyle)
                [ text "Text" ]
            , Html.span (Theme.onSecondary :: demoThemeIconStyle)
                [ text "favorite" ]
            ]
        ]


textOnLightBackground : Html msg
textOnLightBackground =
    Html.div demoThemeColorGroup
        [ Html.div (demoThemeBgCustomLight ++ demoThemeTextRow)
            [ Html.span (Theme.textPrimaryOnLight :: demoThemeTextStyle)
                [ text "Primary" ]
            , Html.span (Theme.textSecondaryOnLight :: demoThemeTextStyle)
                [ text "Secondary" ]
            , Html.span (Theme.textHintOnLight :: demoThemeTextStyle)
                [ text "Hint" ]
            , Html.span (Theme.textDisabledOnLight :: demoThemeTextStyle)
                [ text "Disabled" ]
            , Html.span (Theme.textIconOnLight :: demoThemeIconStyle)
                [ text "favorite" ]
            ]
        ]


textOnDarkBackground : Html msg
textOnDarkBackground =
    Html.div demoThemeColorGroup
        [ Html.div (demoThemeBgCustomDark ++ demoThemeTextRow)
            [ Html.span (Theme.textPrimaryOnDark :: demoThemeTextStyle)
                [ text "Primary" ]
            , Html.span (Theme.textSecondaryOnDark :: demoThemeTextStyle)
                [ text "Secondary" ]
            , Html.span (Theme.textHintOnDark :: demoThemeTextStyle)
                [ text "Hint" ]
            , Html.span (Theme.textDisabledOnDark :: demoThemeTextStyle)
                [ text "Disabled" ]
            , Html.span (Theme.textIconOnDark :: demoThemeIconStyle)
                [ text "favorite" ]
            ]
        ]


heroMargin : List (Html.Attribute msg)
heroMargin =
    [ Html.Attributes.style "margin" "16px 32px" ]


demoThemeColorGroup : List (Html.Attribute msg)
demoThemeColorGroup =
    [ Html.Attributes.style "padding" "16px 0" ]


demoThemeColorSwatches : List (Html.Attribute msg)
demoThemeColorSwatches =
    [ Html.Attributes.style "display" "-ms-inline-flexbox"
    , Html.Attributes.style "display" "inline-flex"
    , Html.Attributes.style "-ms-flex-direction" "column"
    , Html.Attributes.style "flex-direction" "column"
    , Html.Attributes.style "margin-right" "16px"
    , Elevation.z2
    ]


demoThemeColorSwatch : List (Html.Attribute msg)
demoThemeColorSwatch =
    [ Html.Attributes.style "display" "inline-block"
    , Html.Attributes.style "-webkit-box-sizing" "border-box"
    , Html.Attributes.style "box-sizing" "border-box"
    , Html.Attributes.style "width" "150px"
    , Html.Attributes.style "height" "50px"
    , Html.Attributes.style "line-height" "50px"
    , Html.Attributes.style "text-align" "center"
    , Html.Attributes.style "margin-bottom" "8px"
    , Html.Attributes.style "border-radius" "4px"
    ]


demoThemeTextRow : List (Html.Attribute msg)
demoThemeTextRow =
    [ Html.Attributes.style "display" "-ms-inline-flexbox"
    , Html.Attributes.style "display" "inline-flex"
    , Html.Attributes.style "-webkit-box-sizing" "border-box"
    , Html.Attributes.style "box-sizing" "border-box"
    , Html.Attributes.style "padding" "16px"
    , Html.Attributes.style "border" "1px solid #f0f0f0"
    , Html.Attributes.style "-ms-flex-align" "center"
    , Html.Attributes.style "align-items" "center"
    , Html.Attributes.style "-ms-flex-direction" "row"
    , Html.Attributes.style "flex-direction" "row"
    ]


demoThemeTextStyle : List (Html.Attribute msg)
demoThemeTextStyle =
    [ Html.Attributes.style "padding" "0 16px" ]


demoThemeIconStyle : List (Html.Attribute msg)
demoThemeIconStyle =
    Html.Attributes.class "material-icons" :: demoThemeTextStyle


demoThemeBgCustomLight : List (Html.Attribute msg)
demoThemeBgCustomLight =
    [ Html.Attributes.style "background-color" "#ddd" ]


demoThemeBgCustomDark : List (Html.Attribute msg)
demoThemeBgCustomDark =
    [ Html.Attributes.style "background-color" "#d1d1d1" ]
