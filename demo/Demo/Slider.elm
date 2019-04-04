module Demo.Slider exposing (Model, Msg(..), defaultModel, subscriptions, update, view)

import Demo.Helper.ResourceLink as ResourceLink
import Demo.Page as Page exposing (Page)
import Dict exposing (Dict)
import Html exposing (Html, text)
import Html.Attributes
import Html.Events
import Json.Decode as Json exposing (Decoder)
import Material.Slider as Slider exposing (slider, sliderConfig)
import Material.Typography as Typography
import Platform.Cmd exposing (Cmd, none)


type alias Model =
    { sliders : Dict String Float
    }


defaultModel : Model
defaultModel =
    { sliders =
        Dict.fromList
            [ ( "slider-hero-slider", 25 )
            , ( "slider-continuous-slider", 25 )
            , ( "slider-discrete-slider", 25 )
            , ( "slider-discrete-slider-with-tick-marks", 25 )
            ]
    }


type Msg
    = Change String Float


update : (Msg -> m) -> Msg -> Model -> ( Model, Cmd m )
update lift msg model =
    case msg of
        Change index value ->
            ( { model | sliders = Dict.insert index value model.sliders }, Cmd.none )


subscriptions : (Msg -> m) -> Model -> Sub m
subscriptions lift model =
    Sub.none


heroSlider : (Msg -> m) -> Model -> Html m
heroSlider lift model =
    let
        index =
            "slider-hero-slider"
    in
    slider
        { sliderConfig
            | value = Maybe.withDefault 0 (Dict.get index model.sliders)
            , onChange = Just (lift << Change index)
        }


continuousSlider : (Msg -> m) -> Model -> Html m
continuousSlider lift model =
    let
        index =
            "slider-continuous-slider"
    in
    slider
        { sliderConfig
            | value = Maybe.withDefault 0 (Dict.get index model.sliders)
            , onChange = Just (lift << Change index)
            , min = 0
            , max = 50
        }


discreteSlider : (Msg -> m) -> Model -> Html m
discreteSlider lift model =
    let
        index =
            "slider-discrete-slider"
    in
    slider
        { sliderConfig
            | value = Maybe.withDefault 0 (Dict.get index model.sliders)
            , onChange = Just (lift << Change index)
            , discrete = True
            , min = 0
            , max = 50
            , step = Just 1
        }


discreteSliderWithTickMarks : (Msg -> m) -> Model -> Html m
discreteSliderWithTickMarks lift model =
    let
        index =
            "slider-discrete-slider-with-tick-marks"
    in
    slider
        { sliderConfig
            | value = Maybe.withDefault 0 (Dict.get index model.sliders)
            , onChange = Just (lift << Change index)
            , discrete = True
            , min = 0
            , max = 50
            , step = Just 1
            , displayMarkers = True
        }


view : (Msg -> m) -> Page m -> Model -> Html m
view lift page model =
    page.body "Slider"
        "Sliders let users select from a range of values by moving the slider thumb."
        [ Page.hero [] [ heroSlider lift model ]
        , Html.h2
            [ Typography.headline6
            , Html.Attributes.style "border-bottom" "1px solid rgba(0,0,0,.87)"
            ]
            [ text "Resources"
            ]
        , ResourceLink.view
            { link = "https://material.io/go/design-sliders"
            , title = "Material Design Guidelines"
            , icon = "images/material.svg"
            , altText = "Material Design Guidelines icon"
            }
        , ResourceLink.view
            { link = "https://material.io/components/web/catalog/input-controls/sliders/"
            , title = "Documentation"
            , icon = "images/ic_drive_document_24px.svg"
            , altText = "Documentation icon"
            }
        , ResourceLink.view
            { link = "https://github.com/material-components/material-components-web/tree/master/packages/mdc-slider"
            , title = "Source Code (Material Components Web)"
            , icon = "images/ic_code_24px.svg"
            , altText = "Source Code"
            }
        , Html.h3 [ Typography.subtitle1 ] [ text "Continuous" ]
        , continuousSlider lift model
        , Html.h3 [ Typography.subtitle1 ] [ text "Discrete" ]
        , discreteSlider lift model
        , Html.h3 [ Typography.subtitle1 ] [ text "Discrete with Tick Marks" ]
        , discreteSliderWithTickMarks lift model
        ]
