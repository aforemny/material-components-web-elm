module Material.Ripple exposing (Config, ripple, rippleConfig)

import Html exposing (Html, text)
import Html.Attributes exposing (class)


type alias Config msg =
    { unbounded : Bool
    , additionalAttributes : List (Html.Attribute msg)
    }


rippleConfig : Config msg
rippleConfig =
    { unbounded = False
    , additionalAttributes = []
    }


ripple : Config msg -> Html msg
ripple config =
    Html.node "mdc-ripple"
        (List.filterMap identity
            [ rippleSurfaceCs
            , dataUnboundedAttr config
            ]
            ++ config.additionalAttributes
        )
        []


rippleSurfaceCs : Maybe (Html.Attribute msg)
rippleSurfaceCs =
    Just (class "mdc-ripple-surface")


dataUnboundedAttr : Config msg -> Maybe (Html.Attribute msg)
dataUnboundedAttr { unbounded } =
    if unbounded then
        Just (Html.Attributes.attribute "data-mdc-ripple-is-unbounded" "")

    else
        Nothing
