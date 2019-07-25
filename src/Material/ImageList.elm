module Material.ImageList exposing
    ( ImageListConfig, imageListConfig
    , ImageListItem, imageList
    , ImageListItemConfig, imageListItemConfig
    , imageListItem
    )

{-|

@docs ImageListConfig, imageListConfig
@docs ImageListItem, imageList

@docs ImageListItemConfig, imageListItemConfig
@docs imageListItem

-}

import Html exposing (Html, text)
import Html.Attributes exposing (class)


{-| TODO docs
-}
type alias ImageListConfig msg =
    { masonry : Bool
    , withTextProtection : Bool
    , additionalAttributes : List (Html.Attribute msg)
    }


{-| TODO docs
-}
imageListConfig : ImageListConfig msg
imageListConfig =
    { masonry = False
    , withTextProtection = False
    , additionalAttributes = []
    }


{-| TODO docs
-}
imageList : ImageListConfig msg -> List (ImageListItem msg) -> Html msg
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


{-| TODO docs
-}
type alias ImageListItemConfig msg =
    { label : Maybe String
    , href : Maybe String
    , additionalAttributes : List (Html.Attribute msg)
    }


{-| TODO docs
-}
imageListItemConfig : ImageListItemConfig msg
imageListItemConfig =
    { label = Nothing
    , href = Nothing
    , additionalAttributes = []
    }


{-| TODO docs
-}
type ImageListItem msg
    = ImageListItem
        { config : ImageListItemConfig msg
        , image : String
        }


{-| TODO docs
-}
imageListItem : ImageListItemConfig msg -> String -> ImageListItem msg
imageListItem config image =
    ImageListItem { config = config, image = image }


rootCs : Maybe (Html.Attribute msg)
rootCs =
    Just (class "mdc-image-list")


masonryCs : ImageListConfig msg -> Maybe (Html.Attribute msg)
masonryCs { masonry } =
    if masonry then
        Just (class "mdc-image-list--masonry")

    else
        Nothing


withTextProtectionCs : ImageListConfig msg -> Maybe (Html.Attribute msg)
withTextProtectionCs { withTextProtection } =
    if withTextProtection then
        Just (class "mdc-image-list--with-text-protection")

    else
        Nothing


listItemElt : ImageListConfig msg -> ImageListItem msg -> Html msg
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


imageAspectContainerElt : ImageListConfig msg -> ImageListItem msg -> Html msg
imageAspectContainerElt config listItem =
    Html.div
        [ class "mdc-image-list__image-aspect-container" ]
        [ imageElt config listItem ]


imageElt : ImageListConfig msg -> ImageListItem msg -> Html msg
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
