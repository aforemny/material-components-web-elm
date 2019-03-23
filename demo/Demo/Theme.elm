module Demo.Theme exposing (Model, Msg, defaultModel, update, view)

import Demo.Page as Page exposing (Page)
import Html exposing (Html, text)
import Html.Attributes
import Material.Button as Button
import Material.Theme as Theme
import Material.Typography as Typography


type alias Model =
    {}


defaultModel : Model
defaultModel =
    {}


type Msg
    = NoOp


update : (Msg -> m) -> Msg -> Model -> ( Model, Cmd m )
update lift msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )


view : (Msg -> m) -> Page m -> Model -> Html m
view lift page model =
    page.body "Theme"
        "Color in Material Design is inspired by bold hues juxtaposed with muted environments, deep shadows, and bright highlights."
        [ Page.hero []
            [ Button.view lift
                "theme-button-primary"
                model.mdc
                [ Button.raised
                , Html.Attributes.style "margin" "24px"
                ]
                [ text "Primary"
                ]
            , Button.view lift
                "theme-button-secondary"
                model.mdc
                [ Button.raised
                , Html.Attributes.style "margin" "24px"
                ]
                [ text "Secondary"
                ]
            ]
        , h2 []
            [ text "Theme colors"
            ]
        , themeColorsAsText
        , themeColorsAsBackground
        , h2 []
            [ text "Text colors for contrast"
            ]
        , example1
        ]


themeColorsAsText : Html m
themeColorsAsText =
    example []
        [ h3 []
            [ text "Theme colors as text"
            ]
        , demoThemeColor []
            [ demoThemeColorBlock
                [ Theme.primary
                ]
                [ text "Primary"
                ]
            , demoThemeColorBlock
                [ Theme.primaryLight
                ]
                [ text "Primary Light"
                ]
            , demoThemeColorBlock
                [ Theme.primaryDark
                ]
                [ text "Primary Dark"
                ]
            ]
        , demoThemeColor []
            [ demoThemeColorBlock
                [ Theme.secondary
                ]
                [ text "Secondary"
                ]
            , demoThemeColorBlock
                [ Theme.secondaryLight
                ]
                [ text "Secondary Light"
                ]
            , demoThemeColorBlock
                [ Theme.secondaryDark
                ]
                [ text "Secondary Dark"
                ]
            ]
        ]


themeColorsAsBackground : Html m
themeColorsAsBackground =
    example []
        [ h3 []
            [ text "Theme colors as background"
            ]
        , demoThemeColor []
            [ demoThemeColorBlock
                [ Theme.primaryBg
                ]
                [ text "Primary"
                ]
            , demoThemeColorBlock
                [ Theme.primaryLightBg
                ]
                [ text "Primary Light"
                ]
            , demoThemeColorBlock
                [ Theme.primaryDarkBg
                ]
                [ text "Primary Dark"
                ]
            ]
        , demoThemeColor []
            [ demoThemeColorBlock
                [ Theme.secondaryBg
                ]
                [ text "Secondary"
                ]
            , demoThemeColorBlock
                [ Theme.secondaryLightBg
                ]
                [ text "Secondary Light"
                ]
            , demoThemeColorBlock
                [ Theme.secondaryDarkBg
                ]
                [ text "Secondary Dark"
                ]
            ]
        , demoThemeColor []
            [ demoThemeColorBlock
                [ Theme.background
                ]
                [ text "Background"
                ]
            ]
        ]


demoThemeColor : List (Html.Attribute m) -> List (Html m) -> Html m
demoThemeColor options =
    Html.div
        (Html.Attributes.class "demo-theme__color"
            :: Html.Attributes.style "display" "inline-flex"
            :: Html.Attributes.style "flex-direction" "column"
            :: options
        )


demoThemeColorBlock : List (Html.Attribute m) -> List (Html m) -> Html m
demoThemeColorBlock options =
    Html.div
        (Html.Attributes.class "demo-theme__color__block"
            :: Html.Attributes.style "display" "inline-block"
            :: Html.Attributes.style "box-sizing" "border-box"
            :: Html.Attributes.style "width" "150px"
            :: Html.Attributes.style "height" "50px"
            :: Html.Attributes.style "line-height" "50px"
            :: Html.Attributes.style "text-align" "center"
            :: Html.Attributes.style "border" "1px solid #f0f0f0"
            :: options
        )


example1 : Html m
example1 =
    let
        demo background nodes =
            demoThemeTextStyles
                [ Typography.typography
                , Typography.body2
                , background
                ]
                (let
                    options =
                        [ Html.Attributes.style "padding" "0 16px"
                        ]
                 in
                 nodes
                    |> List.map (\node -> node options)
                )
    in
    example []
        [ h3 []
            [ text "Text on background"
            ]
        , demo Theme.background
            [ \options -> Html.span (Theme.textPrimaryOnBackground :: options) [ text "Primary" ]
            , \options -> Html.span (Theme.textSecondaryOnBackground :: options) [ text "Secondary" ]
            , \options -> Html.span (Theme.textHintOnBackground :: options) [ text "Hint" ]
            , \options -> Html.span (Theme.textHintOnBackground :: options) [ text "Disabled" ]
            , \options -> Html.span (Theme.textIconOnBackground :: options) [ text "favorite" ]
            ]
        , h3 []
            [ text "Text on primary"
            ]
        , demo Theme.primaryBg
            [ \options -> Html.span (Theme.textPrimaryOnPrimary :: options) [ text "Primary" ]
            , \options -> Html.span (Theme.textSecondaryOnPrimary :: options) [ text "Secondary" ]
            , \options -> Html.span (Theme.textHintOnPrimary :: options) [ text "Hint" ]
            , \options -> Html.span (Theme.textHintOnPrimary :: options) [ text "Disabled" ]
            , \options -> Html.span (Theme.textIconOnPrimary :: options) [ text "favorite" ]
            ]
        , h3 []
            [ text "Text on secondary"
            ]
        , demo Theme.secondaryBg
            [ \options -> Html.span (Theme.textPrimaryOnSecondary :: options) [ text "Primary" ]
            , \options -> Html.span (Theme.textSecondaryOnSecondary :: options) [ text "Secondary" ]
            , \options -> Html.span (Theme.textHintOnSecondary :: options) [ text "Hint" ]
            , \options -> Html.span (Theme.textHintOnSecondary :: options) [ text "Disabled" ]
            , \options -> Html.span (Theme.textIconOnSecondary :: options) [ text "favorite" ]
            ]
        , h3 []
            [ text "Text on user-defined light background"
            ]
        , demo (Html.Attributes.style "background-color" "#dddddd")
            [ \options -> Html.span (Theme.textPrimaryOnLight :: options) [ text "Primary" ]
            , \options -> Html.span (Theme.textSecondaryOnLight :: options) [ text "Secondary" ]
            , \options -> Html.span (Theme.textHintOnLight :: options) [ text "Hint" ]
            , \options -> Html.span (Theme.textHintOnLight :: options) [ text "Disabled" ]
            , \options -> Html.span (Theme.textIconOnLight :: options) [ text "favorite" ]
            ]
        , h3 []
            [ text "Text on user-defined dark background"
            ]
        , demo (Html.Attributes.style "background-color" "#1d1d1d")
            [ \options -> Html.span (Theme.textPrimaryOnDark :: options) [ text "Primary" ]
            , \options -> Html.span (Theme.textSecondaryOnDark :: options) [ text "Secondary" ]
            , \options -> Html.span (Theme.textHintOnDark :: options) [ text "Hint" ]
            , \options -> Html.span (Theme.textHintOnDark :: options) [ text "Disabled" ]
            , \options -> Html.span (Theme.textIconOnDark :: options) [ text "favorite" ]
            ]
        ]


demoThemeTextStyles : List (Html.Attribute m) -> List (Html m) -> Html m
demoThemeTextStyles options =
    Html.div
        (Html.Attributes.class "demo-theme__text--styles"
            :: Html.Attributes.style "display" "inline-flex"
            :: Html.Attributes.style "box-sizing" "border-box"
            :: Html.Attributes.style "padding" "16px"
            :: Html.Attributes.style "border" "1px solid #f0f0f0"
            :: Html.Attributes.style "align-items" "center"
            :: Html.Attributes.style "flex-direction" "row"
            :: options
        )


h2 : List (Html.Attribute m) -> List (Html m) -> Html m
h2 options =
    Html.h2
        (Typography.display1
            :: Html.Attributes.style "margin" "30px 0 30px 48px"
            :: options
        )


h3 : List (Html.Attribute m) -> List (Html m) -> Html m
h3 options =
    Html.h2
        (Typography.title
            :: options
        )


example : List (Html.Attribute m) -> List (Html m) -> Html m
example options =
    Html.section
        (Html.Attributes.style "margin" "24px"
            :: Html.Attributes.style "padding" "24px"
            :: options
        )
