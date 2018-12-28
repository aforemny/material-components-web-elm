module Material.Checkbox exposing (Config, State(..), checkbox, checkboxConfig)

import Html exposing (Html, text)
import Html.Attributes exposing (class)
import Json.Encode
import Svg
import Svg.Attributes


type alias Config msg =
    { state : State
    , disabled : Bool
    , additionalAttributes : List (Html.Attribute msg)
    }


type State
    = Unchecked
    | Checked
    | Indeterminate


checkboxConfig : Config msg
checkboxConfig =
    { state = Unchecked
    , disabled = False
    , additionalAttributes = []
    }


checkbox : Config msg -> Html msg
checkbox config =
    Html.node "mdc-checkbox"
        ([ rootCs
         , checkedAttr config
         , indeterminateAttr config
         , disabledAttr config
         ]
            ++ config.additionalAttributes
        )
        [ nativeControlElt config
        , backgroundElt
        ]


nativeControlElt : Config msg -> Html msg
nativeControlElt config =
    Html.input
        [ Html.Attributes.type_ "checkbox"
        , class "mdc-checkbox__native-control"
        ]
        []


backgroundElt : Html msg
backgroundElt =
    Html.div
        [ class "mdc-checkbox__background" ]
        [ Svg.svg
            [ Svg.Attributes.class "mdc-checkbox__checkmark"
            , Svg.Attributes.viewBox "0 0 24 24"
            ]
            [ Svg.path
                [ Svg.Attributes.class "mdc-checkbox__checkmark-path"
                , Svg.Attributes.fill "none"
                , Svg.Attributes.d "M1.73,12.91 8.1,19.28 22.79,4.59"
                ]
                []
            ]
        , Html.div [ class "mdc-checkbox__mixedmark" ] []
        ]


rootCs : Html.Attribute msg
rootCs =
    class "mdc-checkbox"


disabledAttr : Config msg -> Html.Attribute msg
disabledAttr { disabled } =
    Html.Attributes.disabled disabled


checkedAttr : Config msg -> Html.Attribute msg
checkedAttr { state } =
    Html.Attributes.checked (state == Checked)


indeterminateAttr : Config msg -> Html.Attribute msg
indeterminateAttr { state } =
    Html.Attributes.property "indeterminate" (Json.Encode.bool (state == Indeterminate))
