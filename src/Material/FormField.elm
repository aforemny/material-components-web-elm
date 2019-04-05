module Material.FormField exposing (Config, formField, formFieldConfig)

import Html exposing (Html, text)
import Html.Attributes exposing (class)
import Html.Events


type alias Config msg =
    { label : String
    , for : Maybe String
    , alignEnd : Bool
    , additionalAttributes : List (Html.Attribute msg)
    , onClick : Maybe msg
    }


formFieldConfig : Config msg
formFieldConfig =
    { label = ""
    , for = Nothing
    , alignEnd = False
    , additionalAttributes = []
    , onClick = Nothing
    }


formField : Config msg -> List (Html msg) -> Html msg
formField config nodes =
    Html.node "mdc-form-field"
        (List.filterMap identity [ rootCs, alignEndCs config ]
            ++ config.additionalAttributes
        )
        (nodes ++ [ labelElt config ])


rootCs : Maybe (Html.Attribute msg)
rootCs =
    Just (class "mdc-form-field")


alignEndCs : Config msg -> Maybe (Html.Attribute msg)
alignEndCs { alignEnd } =
    if alignEnd then
        Just (class "mdc-form-field--align-end")

    else
        Nothing


forAttr : Config msg -> Maybe (Html.Attribute msg)
forAttr { for } =
    Maybe.map Html.Attributes.for for


clickHandler : Config msg -> Maybe (Html.Attribute msg)
clickHandler { onClick } =
    Maybe.map Html.Events.onClick onClick


labelElt : Config msg -> Html msg
labelElt ({ label } as config) =
    Html.label (List.filterMap identity [ forAttr config, clickHandler config ])
        [ text label ]
