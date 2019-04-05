module Demo.TopAppBar exposing (Model, Msg(..), defaultModel, update, view)

import Demo.Page as Page exposing (Page)
import Demo.Url as Url exposing (TopAppBarPage)
import Dict exposing (Dict)
import Html exposing (Html, text)
import Html.Attributes
import Html.Events
import Material.Icon as Icon exposing (icon, iconConfig)
import Material.TopAppBar as TopAppBar exposing (prominentTopAppBar, shortCollapsedTopAppBar, shortTopAppBar, topAppBar, topAppBarConfig)
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
            topAppBar_

        Just Url.FixedTopAppBar ->
            fixedTopAppBar_

        Just Url.DenseTopAppBar ->
            denseTopAppBar_

        Just Url.ProminentTopAppBar ->
            prominentTopAppBar_

        Just Url.ShortTopAppBar ->
            shortTopAppBar_

        Just Url.ShortCollapsedTopAppBar ->
            shortCollapsedTopAppBar_

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


topAppBar_ : Html m
topAppBar_ =
    let
        defaultConfig =
            topAppBarConfig
    in
    topAppBarWrapper [ TopAppBar.fixedAdjust ]
        (topAppBar defaultConfig
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


fixedTopAppBar_ : Html m
fixedTopAppBar_ =
    let
        fixedConfig =
            { topAppBarConfig | fixed = True }
    in
    topAppBarWrapper [ TopAppBar.fixedAdjust ]
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


denseTopAppBar_ : Html m
denseTopAppBar_ =
    let
        denseConfig =
            { topAppBarConfig | dense = True }
    in
    topAppBarWrapper [ TopAppBar.denseFixedAdjust ]
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


prominentTopAppBar_ : Html m
prominentTopAppBar_ =
    topAppBarWrapper [ TopAppBar.prominentFixedAdjust ]
        (prominentTopAppBar topAppBarConfig
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


shortTopAppBar_ : Html m
shortTopAppBar_ =
    topAppBarWrapper [ TopAppBar.shortFixedAdjust ]
        (shortTopAppBar topAppBarConfig
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


shortCollapsedTopAppBar_ : Html m
shortCollapsedTopAppBar_ =
    topAppBarWrapper [ TopAppBar.shortFixedAdjust ]
        (shortCollapsedTopAppBar topAppBarConfig
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
