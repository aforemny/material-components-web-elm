module Material.ImageList exposing
    ( imageList, imageListConfig, ImageListConfig
    , imageListItem, imageListItemConfig, ImageListItemConfig, ImageListItem
    )

{-| An Image List consists of several items, each containing an image and
optionally supporting a text label.


# Table of Contents

  - [Resources](#resources)
  - [Basic Usage](#basic-usage)
  - [Image List](#image-list)
  - [Image List Item](#image-list-item)
  - [Masonry Image List](#masonry-image-list)
  - [Image List with Text Label](#image-list-with-text-label)


# Resources

  - [Demo: Image Lists](https://aforemny.github.io/material-components-web-elm/#image-lists)
  - [Material Design Guidelines: Image list](https://material.io/go/design-image-list)
  - [MDC Web: Image List](https://github.com/material-components/material-components-web/tree/master/packages/mdc-image-list)
  - [Sass Mixins (MDC Web)](https://github.com/material-components/material-components-web/tree/master/packages/mdc-image-list#sass-mixins)


# Basic Usage

Note that you will have to set the width and margin of image list items
yourself, preferably through SASS.

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


# Image List

@docs imageList, imageListConfig, ImageListConfig


# Image list Item

@docs imageListItem, imageListItemConfig, ImageListItemConfig, ImageListItem


# Masonry Image List

The Masonry Image List variant presents images vertically arranged into several
columns, using CSS Columns. In this layout, images may be any combination of
aspect ratios.

        imageList { imageListConfig | masonry = True } []


# Image List with Label

Image's labels are by default positioned below the image. If you want image
labels to be positioned in a scrim overlaying each image, set the image list's
textProtection configuration field to True.

        imageList { imageListConfig | textProtection = True }
            [ imageListItem
                { imageListItemConfig | label = "Photo" }
                "images/photos/3x2/1.jpg"
            ]

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
    Html.node "mdc-image-list-item"
        (class "mdc-image-list__item" :: config.additionalAttributes)
        (config.href
            |> Maybe.map (\href -> [ Html.a [ Html.Attributes.href href ] inner ])
            |> Maybe.withDefault inner
        )


imageAspectContainerElt : ImageListConfig msg -> ImageListItem msg -> Html msg
imageAspectContainerElt config_ ((ImageListItem { config }) as listItem) =
    Html.div
        (List.filterMap identity
            [ Just (class "mdc-image-list__image-aspect-container")
            , Maybe.map (\_ -> class "mdc-ripple-surface") config.href
            ]
        )
        [ imageElt config_ listItem ]


imageElt : ImageListConfig msg -> ImageListItem msg -> Html msg
imageElt { masonry } (ImageListItem { config, image }) =
    let
        img =
            Html.img
                [ class "mdc-image-list__image"
                , Html.Attributes.src image
                ]
                []
    in
    if masonry then
        if config.href /= Nothing then
            Html.div [ class "mdc-ripple-surface" ] [ img ]

        else
            img

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
