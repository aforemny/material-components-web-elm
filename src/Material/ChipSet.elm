module Material.ChipSet exposing (choiceChipSet, filterChipSet, inputChipSet)

{-|

@docs choiceChipSet, filterChipSet, inputChipSet

-}

import Html exposing (Html, text)
import Html.Attributes exposing (class)


{-| TODO
-}
choiceChipSet : List (Html.Attribute msg) -> List (Html msg) -> Html msg
choiceChipSet additionalAttributes chips =
    Html.node "mdc-chip-set" (rootCs :: choiceCs :: additionalAttributes) chips


{-| TODO
-}
filterChipSet : List (Html.Attribute msg) -> List (Html msg) -> Html msg
filterChipSet additionalAttributes chips =
    Html.node "mdc-chip-set" (rootCs :: filterCs :: additionalAttributes) chips


{-| TODO
-}
inputChipSet : List (Html.Attribute msg) -> List (Html msg) -> Html msg
inputChipSet additionalAttributes chips =
    Html.node "mdc-chip-set" (rootCs :: inputCs :: additionalAttributes) chips


rootCs : Html.Attribute msg
rootCs =
    class "mdc-chip-set"


choiceCs : Html.Attribute msg
choiceCs =
    class "mdc-chip-set--choice"


filterCs : Html.Attribute msg
filterCs =
    class "mdc-chip-set--filter"


inputCs : Html.Attribute msg
inputCs =
    class "mdc-chip-set--input"
