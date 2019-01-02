module Material.Slider exposing (Config, slider, sliderConfig)

import Html exposing (Html, text)
import Html.Attributes exposing (class)
import Svg
import Svg.Attributes


type alias Config msg =
    { discrete : Bool
    , min : Float
    , max : Float
    , value : Float
    , additionalAttributes : List (Html.Attribute msg)
    }


sliderConfig : Config msg
sliderConfig =
    { discrete = False
    , min = 0
    , max = 1
    , value = 0
    , additionalAttributes = []
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
