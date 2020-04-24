module Demo.Slider exposing (Model, Msg(..), defaultModel, update, view)

import Demo.CatalogPage exposing (CatalogPage)
import Demo.Helper.ResourceLink as ResourceLink
import Dict exposing (Dict)
import Html exposing (Html, text)
import Html.Attributes
import Html.Events
import Json.Decode as Json exposing (Decoder)
import Material.Slider as Slider
import Material.Typography as Typography
import Platform.Cmd exposing (Cmd, none)


type alias Model =
    { sliders : Dict String Float }


defaultModel : Model
defaultModel =
    { sliders =
        Dict.fromList
            [ ( "hero-slider", 25 )
            , ( "continuous-slider", 25 )
            , ( "discrete-slider", 25 )
            , ( "discrete-slider-with-tick-marks", 25 )
            ]
    }


type Msg
    = Changed String Float


update : Msg -> Model -> Model
update msg model =
    case msg of
        Changed id value ->
            { model | sliders = Dict.insert id value model.sliders }


view : Model -> CatalogPage Msg
view model =
    { title = "Slider"
    , prelude = "Sliders let users select from a range of values by moving the slider thumb."
    , resources =
        { materialDesignGuidelines = Just "https://material.io/go/design-sliders"
        , documentation = Just "https://package.elm-lang.org/packages/aforemny/material-components-web-elm/latest/Material-Slider"
        , sourceCode = Just "https://github.com/material-components/material-components-web/tree/master/packages/mdc-slider"
        }
    , hero = [ heroSlider model ]
    , content =
        [ Html.h3 [ Typography.subtitle1 ] [ text "Continuous" ]
        , continuousSlider model
        , Html.h3 [ Typography.subtitle1 ] [ text "Discrete" ]
        , discreteSlider model
        , Html.h3 [ Typography.subtitle1 ] [ text "Discrete with Tick Marks" ]
        , discreteSliderWithTickMarks model
        ]
    }


heroSlider : Model -> Html Msg
heroSlider model =
    let
        id =
            "hero-slider"
    in
    Slider.slider
        (Slider.config
            |> Slider.setValue (Maybe.withDefault 0 (Dict.get id model.sliders))
            |> Slider.setOnChange (Changed id)
        )


continuousSlider : Model -> Html Msg
continuousSlider model =
    let
        id =
            "continuous-slider"
    in
    Slider.slider
        (Slider.config
            |> Slider.setValue (Maybe.withDefault 0 (Dict.get id model.sliders))
            |> Slider.setOnChange (Changed id)
            |> Slider.setMin 0
            |> Slider.setMax 50
        )


discreteSlider : Model -> Html Msg
discreteSlider model =
    let
        id =
            "discrete-slider"
    in
    Slider.slider
        (Slider.config
            |> Slider.setValue (Maybe.withDefault 0 (Dict.get id model.sliders))
            |> Slider.setOnChange (Changed id)
            |> Slider.setDiscrete True
            |> Slider.setMin 0
            |> Slider.setMax 50
            |> Slider.setStep 1
        )


discreteSliderWithTickMarks : Model -> Html Msg
discreteSliderWithTickMarks model =
    let
        id =
            "discrete-slider-with-tick-marks"
    in
    Slider.slider
        (Slider.config
            |> Slider.setValue (Maybe.withDefault 0 (Dict.get id model.sliders))
            |> Slider.setOnChange (Changed id)
            |> Slider.setDiscrete True
            |> Slider.setMin 0
            |> Slider.setMax 50
            |> Slider.setStep 1
            |> Slider.setDisplayMarkers True
        )
