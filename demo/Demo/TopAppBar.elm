module Demo.TopAppBar exposing (Model, Msg(..), defaultModel, subscriptions, update, view)

import Demo.Page as Page exposing (Page)
import Demo.Url as Url exposing (TopAppBarPage)
import Dict exposing (Dict)
import Html exposing (Html, text)
import Html.Attributes
import Html.Events
import Material.Button as Button
import Material.TopAppBar as TopAppBar


type alias Model =
    { examples : Dict String Example
    }


type alias Example =
    {}


defaultExample : Example
defaultExample =
    {}


defaultModel : Model
defaultModel =
    { examples = Dict.empty
    }


type Msg
    = ExampleMsg String ExampleMsg


type ExampleMsg
    = OpenDrawer


update : (Msg -> m) -> Msg -> Model -> ( Model, Cmd m )
update lift msg model =
    case msg of
        ExampleMsg index msg_ ->
            let
                example =
                    Dict.get index model.examples
                        |> Maybe.withDefault defaultExample
                        |> updateExample msg_

                examples =
                    Dict.insert index example model.examples
            in
            ( { model | examples = examples }, Cmd.none )


updateExample : ExampleMsg -> Example -> Example
updateExample msg model =
    case msg of
        OpenDrawer ->
            model


view : (Msg -> m) -> Page m -> Maybe TopAppBarPage -> Model -> Html m
view lift page topAppBarPage model =
    case topAppBarPage of
        Just Url.StandardTopAppBar ->
            standardTopAppBar lift "top-app-bar-standard" model

        Just Url.FixedTopAppBar ->
            fixedTopAppBar lift "top-app-bar-fixed" model

        Just Url.DenseTopAppBar ->
            denseTopAppBar lift "top-app-bar-dense" model

        Just Url.ProminentTopAppBar ->
            prominentTopAppBar lift "top-app-bar-prominent" model

        Just Url.ShortTopAppBar ->
            shortTopAppBar lift "top-app-bar-short" model

        Just Url.ShortCollapsedTopAppBar ->
            shortCollapsedTopAppBar lift "top-app-bar-short-collapsed" model

        Nothing ->
            page.body "Top App Bar"
                "Top App Bars are a container for items such as application title, navigation icon, and action items."
                [ Page.hero []
                    [ Html.div
                        [ Html.Attributes.style "width" "480px"
                        , Html.Attributes.style "height" "72px"
                        ]
                        [ TopAppBar.view lift
                            "top-app-bar-default-top-app-bar"
                            model.mdc
                            [ Html.Attributes.style "position" "static"
                            ]
                            [ TopAppBar.section
                                [ TopAppBar.alignStart
                                ]
                                [ TopAppBar.navigationIcon [] "menu"
                                , TopAppBar.title [] [ text "Title" ]
                                ]
                            , TopAppBar.section
                                [ TopAppBar.alignEnd
                                ]
                                [ TopAppBar.actionItem [] "file_download"
                                , TopAppBar.actionItem [] "print"
                                , TopAppBar.actionItem [] "more_vert"
                                ]
                            ]
                        ]
                    ]
                , Html.div
                    [ Html.Attributes.class "mdc-topappbar-demo"
                    , Html.Attributes.style "display" "flex"
                    , Html.Attributes.style "flex-flow" "row wrap"
                    ]
                    [ iframe lift model "Standard TopAppBar" Url.StandardTopAppBar
                    , iframe lift model "Fixed TopAppBar" Url.FixedTopAppBar
                    , iframe lift model "Dense TopAppBar" Url.DenseTopAppBar
                    , iframe lift model "Prominent TopAppBar" Url.ProminentTopAppBar
                    , iframe lift model "Short TopAppBar" Url.ShortTopAppBar
                    , iframe lift
                        model
                        "Short - Always Closed TopAppBar"
                        Url.ShortCollapsedTopAppBar
                    ]
                ]


iframe : (Msg -> m) -> Model -> String -> TopAppBarPage -> Html m
iframe lift model title topAppBarPage =
    let
        url =
            (++) "https://aforemny.github.io/elm-mdc/" <|
                Url.toString (Url.TopAppBar (Just topAppBarPage))
    in
    Html.div
        [ Html.Attributes.style "display" "flex"
        , Html.Attributes.style "flex-flow" "column"
        , Html.Attributes.style "margin" "24px"
        , Html.Attributes.style "width" "320px"
        , Html.Attributes.style "height" "600px"
        ]
        [ Html.h2
            [ Html.Attributes.class "demo-topappbar-example-heading"
            , Html.Attributes.style "font-size" "24px"
            , Html.Attributes.style "margin-bottom" "16px"
            , Html.Attributes.style "font-family" "Roboto, sans-serif"
            , Html.Attributes.style "font-size" "2.8125rem"
            , Html.Attributes.style "line-height" "3rem"
            , Html.Attributes.style "font-weight" "400"
            , Html.Attributes.style "letter-spacing" "normal"
            , Html.Attributes.style "text-transform" "inherit"
            ]
            [ Html.span
                [ Html.Attributes.class "demo-topappbar-example-heading__text"
                , Html.Attributes.style "flex-grow" "1"
                , Html.Attributes.style "margin-right" "16px"
                ]
                [ text title ]
            ]
        , Html.p []
            [ Html.a
                [ Html.Attributes.href url
                , Html.Attributes.target "_blank"
                ]
                [ text "View in separate window"
                ]
            ]
        , Html.iframe
            [ Html.Attributes.src url
            , Html.Attributes.style "border" "1px solid #eee"
            , Html.Attributes.style "height" "500px"
            , Html.Attributes.style "font-size" "16px"
            , Html.Attributes.style "overflow" "scroll"
            ]
            []
        ]


topAppBarWrapper :
    (Msg -> m)
    -> String
    -> Model
    -> List (Html.Attribute m)
    -> Html m
    -> Html m
topAppBarWrapper lift index model options topappbar =
    let
        state =
            Dict.get index model.examples
                |> Maybe.withDefault defaultExample
    in
    Html.div
        [ Html.Attributes.class "mdc-topappbar-demo"
        ]
        [ topappbar
        , body options lift index model
        ]


standardTopAppBar : (Msg -> m) -> String -> Model -> Html m
standardTopAppBar lift index model =
    topAppBarWrapper lift
        index
        model
        [ TopAppBar.fixedAdjust
        ]
        (TopAppBar.view lift
            index
            model.mdc
            []
            [ TopAppBar.section
                [ TopAppBar.alignStart
                ]
                [ TopAppBar.navigationIcon [] "menu"
                , TopAppBar.title [] [ text "Title" ]
                ]
            , TopAppBar.section
                [ TopAppBar.alignEnd
                ]
                [ TopAppBar.actionItem [] "file_download"
                , TopAppBar.actionItem [] "print"
                , TopAppBar.actionItem [] "bookmark"
                ]
            ]
        )


fixedTopAppBar : (Msg -> m) -> String -> Model -> Html m
fixedTopAppBar lift index model =
    topAppBarWrapper lift
        index
        model
        [ TopAppBar.fixedAdjust
        ]
        (TopAppBar.view lift
            index
            model.mdc
            [ TopAppBar.fixed
            ]
            [ TopAppBar.section
                [ TopAppBar.alignStart
                ]
                [ TopAppBar.navigationIcon [] "menu"
                , TopAppBar.title [] [ text "Title" ]
                ]
            , TopAppBar.section
                [ TopAppBar.alignEnd
                ]
                [ TopAppBar.actionItem [] "file_download"
                , TopAppBar.actionItem [] "print"
                , TopAppBar.actionItem [] "bookmark"
                ]
            ]
        )


menuTopAppBar : (Msg -> m) -> String -> Model -> Html m
menuTopAppBar lift index model =
    topAppBarWrapper lift
        index
        model
        [ TopAppBar.fixedAdjust
        ]
        (TopAppBar.view lift
            index
            model.mdc
            [ TopAppBar.fixed
            ]
            [ TopAppBar.section
                [ TopAppBar.alignStart
                ]
                [ TopAppBar.navigationIcon [] "menu"
                , TopAppBar.title [] [ text "Title" ]
                ]
            , TopAppBar.section
                [ TopAppBar.alignEnd
                ]
                [ TopAppBar.actionItem [] "file_download"
                , TopAppBar.actionItem [] "print"
                , TopAppBar.actionItem [] "bookmark"
                ]
            ]
        )



-- , viewDrawer


denseTopAppBar : (Msg -> m) -> String -> Model -> Html m
denseTopAppBar lift index model =
    topAppBarWrapper lift
        index
        model
        [ TopAppBar.denseFixedAdjust
        ]
        (TopAppBar.view lift
            index
            model.mdc
            [ TopAppBar.dense
            ]
            [ TopAppBar.section
                [ TopAppBar.alignStart
                ]
                [ TopAppBar.navigationIcon [] "menu"
                , TopAppBar.title [] [ text "Title" ]
                ]
            , TopAppBar.section
                [ TopAppBar.alignEnd
                ]
                [ TopAppBar.actionItem [] "file_download"
                , TopAppBar.actionItem [] "print"
                , TopAppBar.actionItem [] "bookmark"
                ]
            ]
        )


prominentTopAppBar : (Msg -> m) -> String -> Model -> Html m
prominentTopAppBar lift index model =
    topAppBarWrapper lift
        index
        model
        [ TopAppBar.prominentFixedAdjust
        ]
        (TopAppBar.view lift
            index
            model.mdc
            [ TopAppBar.prominent
            ]
            [ TopAppBar.section
                [ TopAppBar.alignStart
                ]
                [ TopAppBar.navigationIcon [] "menu"
                , TopAppBar.title [] [ text "Title" ]
                ]
            , TopAppBar.section
                [ TopAppBar.alignEnd
                ]
                [ TopAppBar.actionItem [] "file_download"
                , TopAppBar.actionItem [] "print"
                , TopAppBar.actionItem [] "bookmark"
                ]
            ]
        )


shortTopAppBar : (Msg -> m) -> String -> Model -> Html m
shortTopAppBar lift index model =
    topAppBarWrapper lift
        index
        model
        [ TopAppBar.fixedAdjust
        ]
        (TopAppBar.view lift
            index
            model.mdc
            [ TopAppBar.short
            , TopAppBar.hasActionItem
            ]
            [ TopAppBar.section
                [ TopAppBar.alignStart
                ]
                [ TopAppBar.navigationIcon [] "menu"
                , TopAppBar.title [] [ text "Title" ]
                ]
            , TopAppBar.section
                [ TopAppBar.alignEnd
                ]
                [ TopAppBar.actionItem [] "file_download"
                ]
            ]
        )


shortCollapsedTopAppBar : (Msg -> m) -> String -> Model -> Html m
shortCollapsedTopAppBar lift index model =
    topAppBarWrapper lift
        index
        model
        [ TopAppBar.fixedAdjust
        ]
        (TopAppBar.view lift
            index
            model.mdc
            [ TopAppBar.short
            , TopAppBar.collapsed
            , TopAppBar.hasActionItem
            ]
            [ TopAppBar.section
                [ TopAppBar.alignStart
                ]
                [ TopAppBar.navigationIcon [] "menu"
                , TopAppBar.title [] [ text "Title" ]
                ]
            , TopAppBar.section
                [ TopAppBar.alignEnd
                ]
                [ TopAppBar.actionItem [] "file_download"
                ]
            ]
        )


body : List (Html.Attribute m) -> (Msg -> m) -> String -> Model -> Html m
body options lift index model =
    Html.div
        options
        (List.repeat 18 <|
            Html.p []
                [ text """
Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac
turpis egestas. Vestibulum tortor quam, feugiat vitae, ultricies eget, tempor
sit amet, ante. Donec eu libero sit amet quam egestas semper. Aenean ultricies
mi vitae est. Pellentesque habitant morbi tristique senectus et netus et
malesuada fames ac turpis egestas. Vestibulum tortor quam, feugiat vitae,
ultricies eget, tempor sit amet, ante. Donec eu libero sit amet quam egestas
semper. Aenean ultricies mi vitae est.
    """
                ]
        )


subscriptions : (Msg -> m) -> Model -> Sub m
subscriptions lift model =
    Sub.none
