module Demo.Slider exposing (Model, Msg(..), defaultModel, update, view)

import Browser.Dom
import Demo.CatalogPage exposing (CatalogPage)
import Dict exposing (Dict)
import Html exposing (Html, text)
import Html.Attributes
import Material.Button as Button
import Material.Slider as Slider
import Material.Typography as Typography
import Task


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
    | Focus String
    | Focused (Result Browser.Dom.Error ())


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Changed id value ->
            ( { model | sliders = Dict.insert id value model.sliders }, Cmd.none )

        Focus id ->
            ( model, Task.attempt Focused (Browser.Dom.focus id) )

        Focused _ ->
            ( model, Cmd.none )


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
        , Html.h3 [ Typography.subtitle1 ] [ text "Focus Slider" ]
        , focusSlider model
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
            |> Slider.setValue (Dict.get id model.sliders)
            |> Slider.setOnInput (Changed id)
        )


continuousSlider : Model -> Html Msg
continuousSlider model =
    let
        id =
            "continuous-slider"
    in
    Slider.slider
        (Slider.config
            |> Slider.setValue (Dict.get id model.sliders)
            |> Slider.setOnInput (Changed id)
            |> Slider.setMin (Just 0)
            |> Slider.setMax (Just 50)
        )


discreteSlider : Model -> Html Msg
discreteSlider model =
    let
        id =
            "discrete-slider"
    in
    Slider.slider
        (Slider.config
            |> Slider.setValue (Dict.get id model.sliders)
            |> Slider.setOnInput (Changed id)
            |> Slider.setDiscrete True
            |> Slider.setMin (Just 0)
            |> Slider.setMax (Just 50)
            |> Slider.setStep (Just 1)
        )


discreteSliderWithTickMarks : Model -> Html Msg
discreteSliderWithTickMarks model =
    let
        id =
            "discrete-slider-with-tick-marks"
    in
    Slider.slider
        (Slider.config
            |> Slider.setValue (Dict.get id model.sliders)
            |> Slider.setOnInput (Changed id)
            |> Slider.setDiscrete True
            |> Slider.setMin (Just 0)
            |> Slider.setMax (Just 50)
            |> Slider.setStep (Just 1)
            |> Slider.setDisplayMarkers True
        )


focusSlider : Model -> Html Msg
focusSlider model =
    let
        id =
            "my-slider"
    in
    Html.div []
        [ Slider.slider
            (Slider.config
                |> Slider.setValue (Dict.get id model.sliders)
                |> Slider.setOnInput (Changed id)
                |> Slider.setAttributes [ Html.Attributes.id id ]
            )
        , text "\u{00A0}"
        , Button.raised
            (Button.config |> Button.setOnClick (Focus id))
            "Focus"
        ]
