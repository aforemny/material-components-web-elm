module Material.Switch exposing (Config, switch, switchConfig)

import Html exposing (Html, text)
import Html.Attributes exposing (class)


type alias Config msg =
    { checked : Bool
    , disabled : Bool
    , additionalAttributes : List (Html.Attribute msg)
    }


switchConfig : Config msg
switchConfig =
    { checked = False
    , disabled = False
    , additionalAttributes = []
    }


switch : Config msg -> Html msg
switch config =
    Html.node "mdc-switch"
        (List.filterMap identity
            [ rootCs
            , checkedCs config
            , disabledCs config
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
        [ nativeControlCs
        , checkboxTypeAttr
        , switchRoleAttr
        , checkedAttr config
        , disabledAttr config
        ]
        []


checkedAttr : Config msg -> Html.Attribute msg
checkedAttr { checked } =
    Html.Attributes.checked checked


nativeControlCs : Html.Attribute msg
nativeControlCs =
    class "mdc-switch__native-control"


switchRoleAttr : Html.Attribute msg
switchRoleAttr =
    Html.Attributes.attribute "role" "switch"


checkboxTypeAttr : Html.Attribute msg
checkboxTypeAttr =
    Html.Attributes.type_ "checkbox"


disabledAttr : Config msg -> Html.Attribute msg
disabledAttr { disabled } =
    Html.Attributes.disabled disabled
