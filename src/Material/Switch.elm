module Material.Switch exposing (Config, switch, switchConfig)

import Html exposing (Html, text)
import Html.Attributes exposing (class)
import Html.Events


type alias Config msg =
    { checked : Bool
    , disabled : Bool
    , additionalAttributes : List (Html.Attribute msg)
    , onClick : Maybe msg
    }


switchConfig : Config msg
switchConfig =
    { checked = False
    , disabled = False
    , additionalAttributes = []
    , onClick = Nothing
    }


switch : Config msg -> Html msg
switch config =
    Html.node "mdc-switch"
        (List.filterMap identity
            [ rootCs
            , checkedCs config
            , checkedAttr config
            , disabledCs config
            , disabledAttr config
            ]
            ++ config.additionalAttributes
        )
        [ trackElt
        , thumbUnderlayElt config
        ]


rootCs : Maybe (Html.Attribute msg)
rootCs =
    Just (class "mdc-switch")


checkedCs : Config msg -> Maybe (Html.Attribute msg)
checkedCs { checked } =
    if checked then
        Just (class "mdc-switch--checked")

    else
        Nothing


checkedAttr : Config msg -> Maybe (Html.Attribute msg)
checkedAttr { checked } =
    if checked then
        Just (Html.Attributes.attribute "checked" "")

    else
        Nothing


disabledAttr : Config msg -> Maybe (Html.Attribute msg)
disabledAttr { disabled } =
    if disabled then
        Just (Html.Attributes.attribute "disabled" "")

    else
        Nothing


disabledCs : Config msg -> Maybe (Html.Attribute msg)
disabledCs { disabled } =
    if disabled then
        Just (class "mdc-switch--disabled")

    else
        Nothing


trackElt : Html msg
trackElt =
    Html.div [ class "mdc-switch__track" ] []


thumbUnderlayElt : Config msg -> Html msg
thumbUnderlayElt config =
    Html.div [ class "mdc-switch__thumb-underlay" ] [ thumbElt config ]


thumbElt : Config msg -> Html msg
thumbElt config =
    Html.div [ class "mdc-switch__thumb" ] [ nativeControlElt config ]


nativeControlElt : Config msg -> Html msg
nativeControlElt config =
    Html.input
        (List.filterMap identity
            [ nativeControlCs
            , checkboxTypeAttr
            , switchRoleAttr
            , nativeCheckedAttr config
            , nativeDisabledAttr config
            , clickHandler config
            ]
        )
        []


nativeControlCs : Maybe (Html.Attribute msg)
nativeControlCs =
    Just (class "mdc-switch__native-control")


switchRoleAttr : Maybe (Html.Attribute msg)
switchRoleAttr =
    Just (Html.Attributes.attribute "role" "switch")


checkboxTypeAttr : Maybe (Html.Attribute msg)
checkboxTypeAttr =
    Just (Html.Attributes.type_ "checkbox")


nativeCheckedAttr : Config msg -> Maybe (Html.Attribute msg)
nativeCheckedAttr { checked } =
    Just (Html.Attributes.checked checked)


nativeDisabledAttr : Config msg -> Maybe (Html.Attribute msg)
nativeDisabledAttr { disabled } =
    Just (Html.Attributes.disabled disabled)


clickHandler : Config msg -> Maybe (Html.Attribute msg)
clickHandler config =
    Maybe.map Html.Events.onClick config.onClick
