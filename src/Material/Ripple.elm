module Material.Ripple exposing (Color(..), Config, ripple, rippleConfig, unboundedRipple)

import Html exposing (Html, text)
import Html.Attributes exposing (class)


type alias Config msg =
    { unbounded : Bool
    , color : Maybe Color
    , additionalAttributes : List (Html.Attribute msg)
    }


rippleConfig : Config msg
rippleConfig =
    { unbounded = False
    , color = Nothing
    , additionalAttributes = []
    }


type Color
    = PrimaryColor
    | AccentColor


ripple : Config msg -> Html msg
ripple config =
    Html.node "mdc-ripple"
        (List.filterMap identity
            [ dataUnboundedAttr config
            , colorCs config
            , rippleSurface
            , Just (Html.Attributes.style "position" "absolute")
            , Just (Html.Attributes.style "top" "0")
            , Just (Html.Attributes.style "left" "0")
            , Just (Html.Attributes.style "right" "0")
            , Just (Html.Attributes.style "bottom" "0")
            ]
            ++ config.additionalAttributes
        )
        []


unboundedRipple : Config msg -> Html msg
unboundedRipple config =
    ripple { config | unbounded = True }


rippleSurface : Maybe (Html.Attribute msg)
rippleSurface =
    Just (class "mdc-ripple-surface")


colorCs : Config msg -> Maybe (Html.Attribute msg)
colorCs { color } =
    case color of
        Just PrimaryColor ->
            Just (class "mdc-ripple-surface--primary")

        Just AccentColor ->
            Just (class "mdc-ripple-surface--accent")

        Nothing ->
            Nothing


dataUnboundedAttr : Config msg -> Maybe (Html.Attribute msg)
dataUnboundedAttr { unbounded } =
    if unbounded then
        Just (Html.Attributes.attribute "data-mdc-ripple-is-unbounded" "")

    else
        Nothing
