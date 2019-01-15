module Material.ImageList exposing (Config, ListItem, imageList, imageListConfig)

import Html exposing (Html, text)
import Html.Attributes exposing (class)


type alias Config msg =
    { masonry : Bool
    , withTextProtection : Bool
    , additionalAttributes : List (Html.Attribute msg)
    }


imageListConfig : Config msg
imageListConfig =
    { masonry = False
    , withTextProtection = False
    , additionalAttributes = []
    }


imageList : Config msg -> List ListItem -> Html msg
imageList config listItems =
    Html.node "mdc-image-list"
        (List.filterMap identity
            [ rootCs
            , masonryCs config
            , withTextProtectionCs config
            ]
            ++ config.additionalAttributes
        )
        (List.map (listItemElt config) listItems)


type alias ListItem =
    { image : String
    , label : Maybe String
    }


rootCs : Maybe (Html.Attribute msg)
rootCs =
    Just (class "mdc-image-list")


masonryCs : Config msg -> Maybe (Html.Attribute msg)
masonryCs { masonry } =
    if masonry then
        Just (class "mdc-image-list--masonry")

    else
        Nothing


withTextProtectionCs : Config msg -> Maybe (Html.Attribute msg)
withTextProtectionCs { withTextProtection } =
    if withTextProtection then
        Just (class "mdc-image-list--with-text-protection")

    else
        Nothing


listItemElt : Config msg -> ListItem -> Html msg
listItemElt { masonry } listItem =
    Html.li
        [ class "mdc-image-list" ]
        [ if masonry then
            imageElt listItem

          else
            imageAspectContainerElt listItem
        , supportingElt listItem
        ]


imageAspectContainerElt : ListItem -> Html msg
imageAspectContainerElt listItem =
    Html.div
        [ class "mdc-image-list__image-aspect-container" ]
        [ imageElt listItem ]


imageElt : ListItem -> Html msg
imageElt { image } =
    Html.img
        [ class "mdc-image-list__image"
        , Html.Attributes.src image
        ]
        []


supportingElt : ListItem -> Html msg
supportingElt { label } =
    case label of
        Just string ->
            Html.div
                [ class "mdc-image-list__supporting" ]
                [ Html.span [ class "mdc-image-list__label" ] [ text string ] ]

        Nothing ->
            text ""
