module Demo.Helper.ResourceLink exposing (view)

import Html exposing (text)
import Html.Attributes exposing (class)
import Material.List.Item as ListItem exposing (ListItem)


view :
    { link : String
    , title : String
    , icon : String
    , altText : String
    }
    -> ListItem msg
view { link, title, icon, altText } =
    ListItem.listItem
        (ListItem.config
            |> ListItem.setAttributes
                [ Html.Attributes.href link
                , Html.Attributes.target "_blank"
                ]
        )
        [ ListItem.graphic []
            [ Html.img
                [ class "resources-icon"
                , Html.Attributes.src icon
                , Html.Attributes.alt altText
                ]
                []
            ]
        , text title
        ]
