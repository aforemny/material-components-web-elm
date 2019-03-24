module Material.ImageList exposing
    ( Config
    , ImageListItem
    , ImageListItemConfig
    , imageList
    , imageListConfig
    , imageListItem
    , imageListItemConfig
    )

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


imageList : Config msg -> List (ImageListItem msg) -> Html msg
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


type alias ImageListItemConfig msg =
    { label : Maybe String
    , href : Maybe String
    , additionalAttributes : List (Html.Attribute msg)
    }


imageListItemConfig : ImageListItemConfig msg
imageListItemConfig =
    { label = Nothing
    , href = Nothing
    , additionalAttributes = []
    }


type ImageListItem msg
    = ImageListItem
        { config : ImageListItemConfig msg
        , image : String
        }


imageListItem : ImageListItemConfig msg -> String -> ImageListItem msg
imageListItem config image =
    ImageListItem { config = config, image = image }


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


listItemElt : Config msg -> ImageListItem msg -> Html msg
listItemElt ({ masonry } as config_) ((ImageListItem { config }) as listItem) =
    let
        inner =
            [ if masonry then
                imageElt config_ listItem

              else
                imageAspectContainerElt config_ listItem
            , supportingElt listItem
            ]
    in
    Html.li (class "mdc-image-list__item" :: config.additionalAttributes)
        (config.href
            |> Maybe.map (\href -> [ Html.a [ Html.Attributes.href href ] inner ])
            |> Maybe.withDefault inner
        )


imageAspectContainerElt : Config msg -> ImageListItem msg -> Html msg
imageAspectContainerElt config listItem =
    Html.div
        [ class "mdc-image-list__image-aspect-container" ]
        [ imageElt config listItem ]


imageElt : Config msg -> ImageListItem msg -> Html msg
imageElt { masonry } (ImageListItem { image }) =
    if masonry then
        Html.img
            [ class "mdc-image-list__image"
            , Html.Attributes.src image
            ]
            []

    else
        Html.div
            [ class "mdc-image-list__image"
            , Html.Attributes.style "background-image" ("url('" ++ image ++ "')")
            ]
            []


supportingElt : ImageListItem msg -> Html msg
supportingElt (ImageListItem { config }) =
    case config.label of
        Just string ->
            Html.div
                [ class "mdc-image-list__supporting" ]
                [ Html.span [ class "mdc-image-list__label" ] [ text string ] ]

        Nothing ->
            text ""
