module Material.Ripple exposing
    ( RippleColor(..)
    , RippleConfig
    , ripple
    , rippleConfig
    , unboundedRipple
    )

import Html exposing (Html, text)
import Html.Attributes exposing (class)


type alias RippleConfig msg =
    { unbounded : Bool
    , color : Maybe RippleColor
    , additionalAttributes : List (Html.Attribute msg)
    }


rippleConfig : RippleConfig msg
rippleConfig =
    { unbounded = False
    , color = Nothing
    , additionalAttributes = []
    }


type RippleColor
    = PrimaryColor
    | AccentColor


ripple : RippleConfig msg -> Html msg
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


unboundedRipple : RippleConfig msg -> Html msg
unboundedRipple config =
    ripple { config | unbounded = True }


rippleSurface : Maybe (Html.Attribute msg)
rippleSurface =
    Just (class "mdc-ripple-surface")


colorCs : RippleConfig msg -> Maybe (Html.Attribute msg)
colorCs { color } =
    case color of
        Just PrimaryColor ->
            Just (class "mdc-ripple-surface--primary")

        Just AccentColor ->
            Just (class "mdc-ripple-surface--accent")

        Nothing ->
            Nothing


dataUnboundedAttr : RippleConfig msg -> Maybe (Html.Attribute msg)
dataUnboundedAttr { unbounded } =
    if unbounded then
        Just (Html.Attributes.attribute "data-mdc-ripple-is-unbounded" "")

    else
        Nothing
