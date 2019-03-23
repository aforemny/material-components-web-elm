module Demo.Helper.ResourceLink exposing (view)

import Html exposing (Html, text)
import Html.Attributes
import Material.List as Lists


view :
    { link : String
    , title : String
    , icon : String
    , altText : String
    }
    -> Html m
view { link, title, icon, altText } =
    Lists.a
        [ Html.Attributes.href link
        , Html.Attributes.target "_blank"
        ]
        [ Lists.graphic []
            [ Html.img
                [ Html.Attributes.class "resources-icon"
                , Html.Attributes.src icon
                , Html.Attributes.alt altText
                ]
                []
            ]
        , text title
        ]
