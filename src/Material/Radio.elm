module Material.Radio exposing (Config, radio, radioConfig)

import Html exposing (Html, text)
import Html.Attributes exposing (class)
import Html.Events


type alias Config msg =
    { checked : Bool
    , disabled : Bool
    , additionalAttributes : List (Html.Attribute msg)
    , onClick : Maybe msg
    }


radioConfig : Config msg
radioConfig =
    { checked = False
    , disabled = False
    , additionalAttributes = []
    , onClick = Nothing
    }


radio : Config msg -> Html msg
radio config =
    Html.node "mdc-radio"
        (List.filterMap identity
            [ rootCs
            , disabledCs config
            , checkedAttr config
            , disabledAttr config
            , clickHandler config
            ]
            ++ config.additionalAttributes
        )
        [ nativeControlElt config
        , backgroundElt
        ]


rootCs : Maybe (Html.Attribute msg)
rootCs =
    Just (class "mdc-radio")


checkedAttr : Config msg -> Maybe (Html.Attribute msg)
checkedAttr { checked } =
    if checked then
        Just (Html.Attributes.attribute "checked" "")

    else
        Nothing


disabledCs : Config msg -> Maybe (Html.Attribute msg)
disabledCs { disabled } =
    if disabled then
        Just (class "mdc-radio--disabled")

    else
        Nothing


disabledAttr : Config msg -> Maybe (Html.Attribute msg)
disabledAttr { disabled } =
    if disabled then
        Just (Html.Attributes.attribute "disabled" "")

    else
        Nothing


clickHandler : Config msg -> Maybe (Html.Attribute msg)
clickHandler config =
    Maybe.map Html.Events.onClick config.onClick


nativeControlElt : Config msg -> Html msg
nativeControlElt config =
    Html.input
        [ nativeControlCs
        , radioTypeAttr
        , nativeCheckedAttr config
        , nativeDisabledAttr config
        ]
        []


nativeControlCs : Html.Attribute msg
nativeControlCs =
    class "mdc-radio__native-control"


radioTypeAttr : Html.Attribute msg
radioTypeAttr =
    Html.Attributes.type_ "radio"


nativeCheckedAttr : Config msg -> Html.Attribute msg
nativeCheckedAttr { checked } =
    Html.Attributes.checked checked


nativeDisabledAttr : Config msg -> Html.Attribute msg
nativeDisabledAttr { disabled } =
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
