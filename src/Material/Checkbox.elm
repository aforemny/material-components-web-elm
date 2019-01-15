module Material.Checkbox exposing (Config, State(..), checkbox, checkboxConfig, toggle)

import Html exposing (Html, text)
import Html.Attributes exposing (class)
import Html.Events
import Json.Encode
import Svg
import Svg.Attributes


type alias Config msg =
    { state : State
    , disabled : Bool
    , additionalAttributes : List (Html.Attribute msg)
    , onClick : Maybe msg
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
    , onClick = Nothing
    }


checkbox : Config msg -> Html msg
checkbox config =
    Html.node "mdc-checkbox"
        (List.filterMap identity
            [ rootCs
            , checkedAttr config
            , indeterminateAttr config
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
    Just (class "mdc-checkbox")


disabledAttr : Config msg -> Maybe (Html.Attribute msg)
disabledAttr { disabled } =
    Just (Html.Attributes.disabled disabled)


checkedAttr : Config msg -> Maybe (Html.Attribute msg)
checkedAttr { state } =
    Just (Html.Attributes.checked (state == Checked))


indeterminateAttr : Config msg -> Maybe (Html.Attribute msg)
indeterminateAttr { state } =
    Just (Html.Attributes.property "indeterminate" (Json.Encode.bool (state == Indeterminate)))


clickHandler : Config msg -> Maybe (Html.Attribute msg)
clickHandler { onClick } =
    Maybe.map Html.Events.onClick onClick


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


toggle : State -> State
toggle state =
    case state of
        Checked ->
            Unchecked

        Unchecked ->
            Checked

        Indeterminate ->
            Checked
