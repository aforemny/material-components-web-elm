module Demo.Helper.Hero exposing (view)

import Html exposing (Html, text)
import Html.Attributes


view : List (Html.Attribute m) -> List (Html m) -> Html m
view options =
    Html.section
        (List.reverse
            (Html.Attributes.class "hero"
                :: Html.Attributes.style "display" "-webkit-box"
                :: Html.Attributes.style "display" "-ms-flexbox"
                :: Html.Attributes.style "display" "flex"
                :: Html.Attributes.style "-webkit-box-orient" "horizontal"
                :: Html.Attributes.style "-webkit-box-direction" "normal"
                :: Html.Attributes.style "-ms-flex-flow" "row nowrap"
                :: Html.Attributes.style "flex-flow" "row nowrap"
                :: Html.Attributes.style "-webkit-box-align" "center"
                :: Html.Attributes.style "-ms-flex-align" "center"
                :: Html.Attributes.style "align-items" "center"
                :: Html.Attributes.style "-webkit-box-pack" "center"
                :: Html.Attributes.style "-ms-flex-pack" "center"
                :: Html.Attributes.style "justify-content" "center"
                :: Html.Attributes.style "min-height" "360px"
                :: Html.Attributes.style "padding" "24px"
                :: Html.Attributes.style "background-color" "rgba(0, 0, 0, 0.05)"
                :: options
            )
        )
