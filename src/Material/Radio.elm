module Material.Radio exposing (RadioConfig, radio, radioConfig)

import Html exposing (Html, text)
import Html.Attributes exposing (class)
import Html.Events
import Json.Decode as Decode


type alias RadioConfig msg =
    { checked : Bool
    , disabled : Bool
    , additionalAttributes : List (Html.Attribute msg)
    , onClick : Maybe msg
    }


radioConfig : RadioConfig msg
radioConfig =
    { checked = False
    , disabled = False
    , additionalAttributes = []
    , onClick = Nothing
    }


radio : RadioConfig msg -> Html msg
radio config =
    Html.node "mdc-radio"
        (List.filterMap identity
            [ rootCs
            , checkedAttr config
            , disabledAttr config
            ]
            ++ config.additionalAttributes
        )
        [ nativeControlElt config
        , backgroundElt
        ]


rootCs : Maybe (Html.Attribute msg)
rootCs =
    Just (class "mdc-radio")


checkedAttr : RadioConfig msg -> Maybe (Html.Attribute msg)
checkedAttr { checked } =
    if checked then
        Just (Html.Attributes.attribute "checked" "")

    else
        Nothing


disabledAttr : RadioConfig msg -> Maybe (Html.Attribute msg)
disabledAttr { disabled } =
    if disabled then
        Just (Html.Attributes.attribute "disabled" "")

    else
        Nothing


clickHandler : RadioConfig msg -> Maybe (Html.Attribute msg)
clickHandler config =
    Maybe.map (\msg -> Html.Events.preventDefaultOn "click" (Decode.succeed ( msg, True )))
        config.onClick


nativeControlElt : RadioConfig msg -> Html msg
nativeControlElt config =
    Html.input
        (List.filterMap identity [ nativeControlCs, radioTypeAttr, clickHandler config ])
        []


nativeControlCs : Maybe (Html.Attribute msg)
nativeControlCs =
    Just (class "mdc-radio__native-control")


radioTypeAttr : Maybe (Html.Attribute msg)
radioTypeAttr =
    Just (Html.Attributes.type_ "radio")


backgroundElt : Html msg
backgroundElt =
    Html.div [ class "mdc-radio__background" ] [ outerCircleElt, innerCircleElt ]


outerCircleElt : Html msg
outerCircleElt =
    Html.div [ class "mdc-radio__outer-circle" ] []


innerCircleElt : Html msg
innerCircleElt =
    Html.div [ class "mdc-radio__inner-circle" ] []
