module Material.FormField exposing (Config, formField, formFieldConfig)

import Html exposing (Html, text)
import Html.Attributes exposing (class)


type alias Config msg =
    { label : String
    , alignEnd : Bool
    , additionalAttributes : List (Html.Attribute msg)
    }


formFieldConfig : Config msg
formFieldConfig =
    { label = ""
    , alignEnd = False
    , additionalAttributes = []
    }


formField : Config msg -> List (Html msg) -> Html msg
formField config nodes =
    Html.node "mdc-form-field"
        (List.filterMap identity [ rootCs, alignEndCs config ]
            ++ config.additionalAttributes
        )
        (labelElt config :: nodes)


rootCs : Maybe (Html.Attribute msg)
rootCs =
    Just (class "mdc-form-field")


alignEndCs : Config msg -> Maybe (Html.Attribute msg)
alignEndCs { alignEnd } =
    if alignEnd then
        Just (class "mdc-form-field--align-end")

    else
        Nothing


labelElt : Config msg -> Html msg
labelElt { label } =
    Html.label [] [ text label ]
