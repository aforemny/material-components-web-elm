module Material.Checkbox exposing
    ( CheckboxConfig
    , CheckboxState(..)
    , checkbox
    , checkboxConfig
    )

import Html exposing (Html, text)
import Html.Attributes exposing (class)
import Html.Events
import Json.Decode as Decode
import Json.Encode as Encode
import Svg
import Svg.Attributes


type alias CheckboxConfig msg =
    { state : CheckboxState
    , disabled : Bool
    , additionalAttributes : List (Html.Attribute msg)
    , onClick : Maybe msg
    }


type CheckboxState
    = Unchecked
    | Checked
    | Indeterminate


checkboxConfig : CheckboxConfig msg
checkboxConfig =
    { state = Unchecked
    , disabled = False
    , additionalAttributes = []
    , onClick = Nothing
    }


checkbox : CheckboxConfig msg -> Html msg
checkbox config =
    Html.node "mdc-checkbox"
        (List.filterMap identity
            [ rootCs
            , stateAttr config
            , disabledAttr config
            ]
            ++ config.additionalAttributes
        )
        [ nativeControlElt config
        , backgroundElt
        ]


rootCs : Maybe (Html.Attribute msg)
rootCs =
    Just (class "mdc-checkbox")


disabledAttr : CheckboxConfig msg -> Maybe (Html.Attribute msg)
disabledAttr { disabled } =
    if disabled then
        Just (Html.Attributes.attribute "disabled" "")

    else
        Nothing


stateAttr : CheckboxConfig msg -> Maybe (Html.Attribute msg)
stateAttr { state } =
    Just <|
        Html.Attributes.attribute "state" <|
            case state of
                Checked ->
                    "checked"

                Unchecked ->
                    "unchecked"

                Indeterminate ->
                    "indeterminate"


clickHandler : CheckboxConfig msg -> Maybe (Html.Attribute msg)
clickHandler { onClick } =
    Maybe.map
        (\msg -> Html.Events.preventDefaultOn "click" (Decode.succeed ( msg, True )))
        onClick


nativeControlElt : CheckboxConfig msg -> Html msg
nativeControlElt config =
    Html.input
        (List.filterMap identity
            [ Just (Html.Attributes.type_ "checkbox")
            , Just (class "mdc-checkbox__native-control")
            , clickHandler config
            ]
        )
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
