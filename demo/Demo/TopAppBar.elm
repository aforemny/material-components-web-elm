module Demo.TopAppBar exposing (Model, Msg(..), defaultModel, update, view)

import Demo.Page as Page exposing (Page)
import Demo.Url as Url exposing (TopAppBarPage)
import Dict exposing (Dict)
import Html exposing (Html, text)
import Html.Attributes
import Html.Events
import Material.Icon as Icon exposing (icon, iconConfig)
import Material.TopAppBar as TopAppBar exposing (topAppBar, topAppBarConfig)
import Material.Typography as Typography


type alias Model =
    {}


type alias Example =
    {}


defaultExample : Example
defaultExample =
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


view : (Msg -> m) -> Page m -> Maybe TopAppBarPage -> Model -> Html m
view lift page topAppBarPage model =
    case topAppBarPage of
        Just Url.StandardTopAppBar ->
            standardTopAppBar

        Just Url.FixedTopAppBar ->
            fixedTopAppBar

        Just Url.DenseTopAppBar ->
            denseTopAppBar

        Just Url.ProminentTopAppBar ->
            prominentTopAppBar

        Just Url.ShortTopAppBar ->
            shortTopAppBar

        Just Url.ShortCollapsedTopAppBar ->
            shortCollapsedTopAppBar

        Nothing ->
            page.body "Top App Bar"
                "Top App Bars are a container for items such as application title, navigation icon, and action items."
                [ Page.hero []
                    [ Html.div
                        [ Html.Attributes.style "width" "480px"
                        , Html.Attributes.style "height" "72px"
                        ]
                        [ topAppBar
                            { topAppBarConfig
                                | additionalAttributes =
                                    [ Html.Attributes.style "position" "static" ]
                            }
                            [ TopAppBar.section
                                [ TopAppBar.alignStart
                                ]
                                [ icon
                                    { iconConfig
                                        | additionalAttributes =
                                            [ TopAppBar.navigationIcon ]
                                    }
                                    "menu"
                                , Html.span [ TopAppBar.title ] [ text "Title" ]
                                ]
                            , TopAppBar.section
                                [ TopAppBar.alignEnd
                                ]
                                [ icon
                                    { iconConfig
                                        | additionalAttributes = [ TopAppBar.actionItem ]
                                    }
                                    "file_download"
                                , icon
                                    { iconConfig
                                        | additionalAttributes = [ TopAppBar.actionItem ]
                                    }
                                    "print"
                                , icon
                                    { iconConfig
                                        | additionalAttributes = [ TopAppBar.actionItem ]
                                    }
                                    "more_vert"
                                ]
                            ]
                        ]
                    ]
                , Html.div
                    [ Html.Attributes.style "display" "-ms-flexbox"
                    , Html.Attributes.style "display" "flex"
                    , Html.Attributes.style "-ms-flex-wrap" "wrap"
                    , Html.Attributes.style "flex-wrap" "wrap"
                    , Html.Attributes.style "min-height" "200px"
                    ]
                    [ iframe "Standard" Url.StandardTopAppBar
                    , iframe "Fixed" Url.FixedTopAppBar
                    , iframe "Dense" Url.DenseTopAppBar
                    , iframe "Prominent" Url.ProminentTopAppBar
                    , iframe "Short" Url.ShortTopAppBar
                    , iframe "Short - Always Collapsed" Url.ShortCollapsedTopAppBar
                    ]
                ]


iframe : String -> TopAppBarPage -> Html m
iframe title topAppBarPage =
    let
        url =
            Url.toString (Url.TopAppBar (Just topAppBarPage))
    in
    Html.div
        [ Html.Attributes.style "display" "inline-block"
        , Html.Attributes.style "-ms-flex" "1 1 45%"
        , Html.Attributes.style "flex" "1 1 45%"
        , Html.Attributes.style "-ms-flex-pack" "distribute"
        , Html.Attributes.style "justify-content" "space-around"
        , Html.Attributes.style "min-height" "200px"
        , Html.Attributes.style "min-width" "400px"
        , Html.Attributes.style "padding" "15px"
        ]
        [ Html.div []
            [ Html.a
                [ Html.Attributes.href url
                , Html.Attributes.target "_blank"
                ]
                [ Html.h3 [ Typography.subtitle1 ] [ text title ]
                ]
            ]
        , Html.iframe
            [ Html.Attributes.style "width" "100%"
            , Html.Attributes.style "height" "200px"
            , Html.Attributes.src url
            ]
            []
        ]


topAppBarWrapper : List (Html.Attribute m) -> Html m -> Html m
topAppBarWrapper fixedAdjust topAppBar =
    Html.div
        [ Html.Attributes.class "top-app-bar__frame"
        , Html.Attributes.style "height" "200vh"
        , Typography.typography
        ]
        [ topAppBar
        , body fixedAdjust
        ]


standardTopAppBar : Html m
standardTopAppBar =
    let
        standardConfig =
            topAppBarConfig
    in
    topAppBarWrapper
        [ TopAppBar.fixedAdjust standardConfig
        ]
        (topAppBar standardConfig
            [ TopAppBar.row []
                [ TopAppBar.section
                    [ TopAppBar.alignStart
                    ]
                    [ icon
                        { iconConfig
                            | additionalAttributes = [ TopAppBar.navigationIcon ]
                        }
                        "menu"
                    , Html.span [ TopAppBar.title ] [ text "Standard" ]
                    ]
                , TopAppBar.section
                    [ TopAppBar.alignEnd
                    ]
                    [ icon
                        { iconConfig | additionalAttributes = [ TopAppBar.actionItem ] }
                        "file_download"
                    , icon
                        { iconConfig | additionalAttributes = [ TopAppBar.actionItem ] }
                        "print"
                    , icon
                        { iconConfig | additionalAttributes = [ TopAppBar.actionItem ] }
                        "bookmark"
                    ]
                ]
            ]
        )


fixedTopAppBar : Html m
fixedTopAppBar =
    let
        fixedConfig =
            { topAppBarConfig | fixed = True }
    in
    topAppBarWrapper
        [ TopAppBar.fixedAdjust fixedConfig
        ]
        (topAppBar fixedConfig
            [ TopAppBar.row []
                [ TopAppBar.section
                    [ TopAppBar.alignStart
                    ]
                    [ icon
                        { iconConfig
                            | additionalAttributes = [ TopAppBar.navigationIcon ]
                        }
                        "menu"
                    , Html.span [ TopAppBar.title ] [ text "Fixed" ]
                    ]
                , TopAppBar.section
                    [ TopAppBar.alignEnd
                    ]
                    [ icon
                        { iconConfig | additionalAttributes = [ TopAppBar.actionItem ] }
                        "file_download"
                    , icon
                        { iconConfig | additionalAttributes = [ TopAppBar.actionItem ] }
                        "print"
                    , icon
                        { iconConfig | additionalAttributes = [ TopAppBar.actionItem ] }
                        "bookmark"
                    ]
                ]
            ]
        )


denseTopAppBar : Html m
denseTopAppBar =
    let
        denseConfig =
            { topAppBarConfig | dense = True }
    in
    topAppBarWrapper
        [ TopAppBar.fixedAdjust denseConfig
        ]
        (topAppBar denseConfig
            [ TopAppBar.row []
                [ TopAppBar.section
                    [ TopAppBar.alignStart
                    ]
                    [ icon
                        { iconConfig
                            | additionalAttributes = [ TopAppBar.navigationIcon ]
                        }
                        "menu"
                    , Html.span [ TopAppBar.title ] [ text "Dense" ]
                    ]
                , TopAppBar.section
                    [ TopAppBar.alignEnd
                    ]
                    [ icon { iconConfig | additionalAttributes = [ TopAppBar.actionItem ] }
                        "file_download"
                    , icon { iconConfig | additionalAttributes = [ TopAppBar.actionItem ] }
                        "print"
                    , icon { iconConfig | additionalAttributes = [ TopAppBar.actionItem ] }
                        "bookmark"
                    ]
                ]
            ]
        )


prominentTopAppBar : Html m
prominentTopAppBar =
    let
        prominentConfig =
            { topAppBarConfig | variant = TopAppBar.Prominent }
    in
    topAppBarWrapper
        [ TopAppBar.fixedAdjust prominentConfig
        ]
        (topAppBar prominentConfig
            [ TopAppBar.row []
                [ TopAppBar.section
                    [ TopAppBar.alignStart
                    ]
                    [ icon
                        { iconConfig
                            | additionalAttributes = [ TopAppBar.navigationIcon ]
                        }
                        "menu"
                    , Html.span [ TopAppBar.title ] [ text "Prominent" ]
                    ]
                , TopAppBar.section
                    [ TopAppBar.alignEnd
                    ]
                    [ icon { iconConfig | additionalAttributes = [ TopAppBar.actionItem ] }
                        "file_download"
                    , icon { iconConfig | additionalAttributes = [ TopAppBar.actionItem ] }
                        "print"
                    , icon { iconConfig | additionalAttributes = [ TopAppBar.actionItem ] }
                        "bookmark"
                    ]
                ]
            ]
        )


shortTopAppBar : Html m
shortTopAppBar =
    let
        shortConfig =
            { topAppBarConfig | variant = TopAppBar.Short }
    in
    topAppBarWrapper
        [ TopAppBar.fixedAdjust shortConfig
        ]
        (topAppBar shortConfig
            [ TopAppBar.row []
                [ TopAppBar.section
                    [ TopAppBar.alignStart
                    ]
                    [ icon
                        { iconConfig
                            | additionalAttributes = [ TopAppBar.navigationIcon ]
                        }
                        "menu"
                    , Html.span [ TopAppBar.title ] [ text "Short" ]
                    ]
                , TopAppBar.section
                    [ TopAppBar.alignEnd
                    ]
                    [ icon { iconConfig | additionalAttributes = [ TopAppBar.actionItem ] }
                        "file_download"
                    ]
                ]
            ]
        )


shortCollapsedTopAppBar : Html m
shortCollapsedTopAppBar =
    let
        shortCollapsedConfig =
            { topAppBarConfig | variant = TopAppBar.ShortCollapsed }
    in
    topAppBarWrapper
        [ TopAppBar.fixedAdjust shortCollapsedConfig
        ]
        (topAppBar shortCollapsedConfig
            [ TopAppBar.row []
                [ TopAppBar.section
                    [ TopAppBar.alignStart
                    ]
                    [ icon
                        { iconConfig
                            | additionalAttributes = [ TopAppBar.navigationIcon ]
                        }
                        "menu"
                    ]
                , TopAppBar.section
                    [ TopAppBar.alignEnd
                    ]
                    [ icon { iconConfig | additionalAttributes = [ TopAppBar.actionItem ] }
                        "file_download"
                    ]
                ]
            ]
        )


body : List (Html.Attribute m) -> Html m
body fixedAdjust =
    Html.div fixedAdjust
        (List.repeat 4 <|
            Html.p []
                [ text """
Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor
incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis
nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.
Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu
fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in
culpa qui officia deserunt mollit anim id est laborum.
"""
                ]
        )
