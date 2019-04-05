module Material.Switch exposing (Config, switch, switchConfig)

import Html exposing (Html, text)
import Html.Attributes exposing (class)
import Html.Events
import Json.Decode as Decode


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
            , checkedAttr config
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


nativeControlCs : Maybe (Html.Attribute msg)
nativeControlCs =
    Just (class "mdc-switch__native-control")


switchRoleAttr : Maybe (Html.Attribute msg)
switchRoleAttr =
    Just (Html.Attributes.attribute "role" "switch")


checkboxTypeAttr : Maybe (Html.Attribute msg)
checkboxTypeAttr =
    Just (Html.Attributes.type_ "checkbox")


clickHandler : Config msg -> Maybe (Html.Attribute msg)
clickHandler config =
    Maybe.map (\msg -> Html.Events.preventDefaultOn "click" (Decode.succeed ( msg, True )))
        config.onClick


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
            , clickHandler config
            ]
        )
        []
