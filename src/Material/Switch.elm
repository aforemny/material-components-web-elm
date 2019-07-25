module Material.Switch exposing
    ( SwitchConfig, switchConfig
    , switch
    )

{-|

@docs SwitchConfig, switchConfig
@docs switch

-}

import Html exposing (Html, text)
import Html.Attributes exposing (class)
import Html.Events
import Json.Decode as Decode


{-| TODO docs
-}
type alias SwitchConfig msg =
    { checked : Bool
    , disabled : Bool
    , additionalAttributes : List (Html.Attribute msg)
    , onClick : Maybe msg
    }


{-| TODO docs
-}
switchConfig : SwitchConfig msg
switchConfig =
    { checked = False
    , disabled = False
    , additionalAttributes = []
    , onClick = Nothing
    }


{-| TODO docs
-}
switch : SwitchConfig msg -> Html msg
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


checkedAttr : SwitchConfig msg -> Maybe (Html.Attribute msg)
checkedAttr { checked } =
    if checked then
        Just (Html.Attributes.attribute "checked" "")

    else
        Nothing


disabledAttr : SwitchConfig msg -> Maybe (Html.Attribute msg)
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


clickHandler : SwitchConfig msg -> Maybe (Html.Attribute msg)
clickHandler config =
    Maybe.map (\msg -> Html.Events.preventDefaultOn "click" (Decode.succeed ( msg, True )))
        config.onClick


trackElt : Html msg
trackElt =
    Html.div [ class "mdc-switch__track" ] []


thumbUnderlayElt : SwitchConfig msg -> Html msg
thumbUnderlayElt config =
    Html.div [ class "mdc-switch__thumb-underlay" ] [ thumbElt config ]


thumbElt : SwitchConfig msg -> Html msg
thumbElt config =
    Html.div [ class "mdc-switch__thumb" ] [ nativeControlElt config ]


nativeControlElt : SwitchConfig msg -> Html msg
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
