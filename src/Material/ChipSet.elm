module Material.ChipSet exposing (chipSet)

import Html exposing (Html, text)
import Html.Attributes exposing (class)


chipSet : List (Html.Attribute msg) -> List (Html msg) -> Html msg
chipSet additionalAttributes chips =
    Html.node "mdc-chip-set" (rootCs :: additionalAttributes) chips


rootCs : Html.Attribute msg
rootCs =
    class "mdc-chip-set"
