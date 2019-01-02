module Material.Radio exposing (Config, radio, radioConfig)

import Html exposing (Html, text)
import Html.Attributes exposing (class)


type alias Config msg =
    { checked : Bool
    , disabled : Bool
    , additionalAttributes : List (Html.Attribute msg)
    }


radioConfig : Config msg
radioConfig =
    { checked = False
    , disabled = False
    , additionalAttributes = []
    }


radio : Config msg -> Html msg
radio config =
    Html.node "mdc-radio"
        (List.filterMap identity
            [ rootCs
            , disabledCs config
            ]
            ++ config.additionalAttributes
        )
        [ nativeControlElt config
        , backgroundElt
        ]


rootCs : Maybe (Html.Attribute msg)
rootCs =
    Just (class "mdc-radio")


disabledCs : Config msg -> Maybe (Html.Attribute msg)
disabledCs { disabled } =
    if disabled then
        Just (class "mdc-radio--disabled")

    else
        Nothing


nativeControlElt : Config msg -> Html msg
nativeControlElt config =
    Html.input
        [ nativeControlCs
        , radioTypeAttr
        , checkedAttr config
        , disabledAttr config
        ]
        []


nativeControlCs : Html.Attribute msg
nativeControlCs =
    class "mdc-radio__native-control"


radioTypeAttr : Html.Attribute msg
radioTypeAttr =
    Html.Attributes.type_ "radio"


checkedAttr : Config msg -> Html.Attribute msg
checkedAttr { checked } =
    Html.Attributes.checked checked


disabledAttr : Config msg -> Html.Attribute msg
disabledAttr { disabled } =
    Html.Attributes.disabled disabled


backgroundElt : Html msg
backgroundElt =
    Html.div [ class "mdc-radio__background" ] [ outerCircleElt, innerCircleElt ]


outerCircleElt : Html msg
outerCircleElt =
    Html.div [ class "mdc-radio__outer-circle" ] []


innerCircleElt : Html msg
innerCircleElt =
    Html.div [ class "mdc-radio__inner-circle" ] []
