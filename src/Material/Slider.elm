module Material.Slider exposing (Config, slider, sliderConfig)

import Html exposing (Html, text)
import Html.Attributes exposing (class)
import Html.Events
import Json.Decode as Decode
import Svg
import Svg.Attributes



-- TODO: withTickMarks
-- TODO: step


type alias Config msg =
    { discrete : Bool
    , min : Float
    , max : Float
    , step : Float
    , value : Float
    , additionalAttributes : List (Html.Attribute msg)
    , onChange : Maybe (Float -> msg)
    }


sliderConfig : Config msg
sliderConfig =
    { discrete = False
    , min = 0
    , max = 1
    , step = 1
    , value = 0
    , additionalAttributes = []
    , onChange = Nothing
    }


slider : Config msg -> Html msg
slider config =
    Html.node "mdc-slider"
        (List.filterMap identity
            [ rootCs
            , discreteCs config
            , tabIndexAttr
            , sliderRoleAttr
            , ariaValueMinAttr config
            , ariaValueMaxAttr config
            , ariaValuenowAttr config
            , changeHandler config
            ]
            ++ config.additionalAttributes
        )
        [ trackContainerElt
        , thumbContainerElt
        , focusRingElt
        ]


rootCs : Maybe (Html.Attribute msg)
rootCs =
    Just (class "mdc-slider")


discreteCs : Config msg -> Maybe (Html.Attribute msg)
discreteCs { discrete } =
    if discrete then
        Just (class "mdc-slider--discrete")

    else
        Nothing


tabIndexAttr : Maybe (Html.Attribute msg)
tabIndexAttr =
    Just (Html.Attributes.tabindex 0)


sliderRoleAttr : Maybe (Html.Attribute msg)
sliderRoleAttr =
    Just (Html.Attributes.attribute "role" "slider")


ariaValueMinAttr : Config msg -> Maybe (Html.Attribute msg)
ariaValueMinAttr { min } =
    Just (Html.Attributes.attribute "aria-valuemin" (String.fromFloat min))


ariaValueMaxAttr : Config msg -> Maybe (Html.Attribute msg)
ariaValueMaxAttr { max } =
    Just (Html.Attributes.attribute "aria-valuemax" (String.fromFloat max))


ariaValuenowAttr : Config msg -> Maybe (Html.Attribute msg)
ariaValuenowAttr { value } =
    Just (Html.Attributes.attribute "aria-valuenow" (String.fromFloat value))


changeHandler : Config msg -> Maybe (Html.Attribute msg)
changeHandler config =
    Maybe.map
        (\handler ->
            Html.Events.on "change"
                (Decode.map handler
                    (Decode.map (Maybe.withDefault 0)
                        (Decode.map String.toFloat Html.Events.targetValue)
                    )
                )
        )
        config.onChange


trackContainerElt : Html msg
trackContainerElt =
    Html.div [ class "mdc-slider__track-container" ] [ trackElt ]


trackElt : Html msg
trackElt =
    Html.div [ class "mdc-slider__track" ] []


thumbContainerElt : Html msg
thumbContainerElt =
    Html.div [ class "mdc-slider__thumb-container" ] [ thumbElt ]


thumbElt : Html msg
thumbElt =
    Svg.svg
        [ Svg.Attributes.class "mdc-slider__thumb"
        , Svg.Attributes.width "21"
        , Svg.Attributes.height "21"
        ]
        [ Svg.circle
            [ Svg.Attributes.cx "10.5"
            , Svg.Attributes.cy "10.5"
            , Svg.Attributes.r "7.875"
            ]
            []
        ]


focusRingElt : Html msg
focusRingElt =
    Html.div [ class "mdc-slider__focus-ring" ] []
