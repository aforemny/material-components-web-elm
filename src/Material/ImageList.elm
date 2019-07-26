module Material.ImageList exposing
    ( ImageListConfig, imageListConfig, imageList
    , ImageListItemConfig, imageListItemConfig
    , imageListItem, ImageListItem
    )

{-| Image List provides a RTL-aware Material Design image list component. An
Image List consists of several items, each containing an image and optionally
supporting content (i.e. a text label).


# Example

    import Html.Attributes exposing (style)
    import Material.ImageList
        exposing
            ( imageList
            , imageListConfig
            , imageListItem
            , imageListItemConfig
            )

    main =
        imageList imageListConfig
            [ imageListItem
                { imageListItemConfig
                    | additionalAttributes =
                        [ style "width"
                            "calc(100% / 5 - 4.2px)"
                        , style "margin" "2px"
                        ]
                }
                "images/photos/3x2/1.jpg"
            ]


# Configuration

@docs ImageListConfig, imageListConfig, imageList


# Image list items

@docs ImageListItemConfig, imageListItemConfig
@docs imageListItem, ImageListItem


# Masonry image list

The Masonry Image List variant presents images vertically arranged into several
columns, using CSS Columns. In this layout, images may be any combination of
aspect ratios.

        imageList { imageListConfig | masonry = True } []


# Image list with text protection

Image's labels are by default positioned below the image. If you want image
labels to be positioned in a scrim overlaying each image, set the image list's
textProtection configuration field to True.

        imageList { imageListConfig | textProtection = True } []

-}

import Html exposing (Html, text)
import Html.Attributes exposing (class)


{-| Configuration of an image list
-}
type alias ImageListConfig msg =
    { masonry : Bool
    , withTextProtection : Bool
    , additionalAttributes : List (Html.Attribute msg)
    }


{-| Default configuration of an image list
-}
imageListConfig : ImageListConfig msg
imageListConfig =
    { masonry = False
    , withTextProtection = False
    , additionalAttributes = []
    }


{-| Image list view function
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


{-| Configuration of an image list item
-}
type alias ImageListItemConfig msg =
    { label : Maybe String
    , href : Maybe String
    , additionalAttributes : List (Html.Attribute msg)
    }


{-| Default configuration of an image list item
-}
imageListItemConfig : ImageListItemConfig msg
imageListItemConfig =
    { label = Nothing
    , href = Nothing
    , additionalAttributes = []
    }


{-| Image list item
-}
type ImageListItem msg
    = ImageListItem
        { config : ImageListItemConfig msg
        , image : String
        }


{-| Image list item constructor
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
