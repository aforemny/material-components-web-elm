module Demo.Helper.ResourceLink exposing (view)

import Html exposing (Html, text)
import Html.Attributes
import Material.List exposing (ListItem, listItem, listItemConfig, listItemGraphic)


view :
    { link : String
    , title : String
    , icon : String
    , altText : String
    }
    -> ListItem msg
view { link, title, icon, altText } =
    listItem
        { listItemConfig
            | additionalAttributes =
                [ Html.Attributes.href link
                , Html.Attributes.target "_blank"
                ]
        }
        [ listItemGraphic []
            [ Html.img
                [ Html.Attributes.class "resources-icon"
                , Html.Attributes.src icon
                , Html.Attributes.alt altText
                ]
                []
            ]
        , text title
        ]
