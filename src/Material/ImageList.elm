module Material.ImageList exposing
    ( Config, config
    , setMasonry
    , setWithTextProtection
    , setAttributes
    , imageList
    )

{-| An Image List consists of several items, each containing an image and
optionally supporting a text label.


# Table of Contents

  - [Resources](#resources)
  - [Configuration](#configuration)
      - [Configuration Options](#configuration-options)
  - [Basic Usage](#basic-usage)
  - [Image List](#image-list)
  - [Masonry Image List](#masonry-image-list)
  - [Image List with Text Label](#image-list-with-text-label)


# Resources

  - [Demo: Image Lists](https://aforemny.github.io/material-components-web-elm/#image-list)
  - [Material Design Guidelines: Image list](https://material.io/go/design-image-list)
  - [MDC Web: Image List](https://github.com/material-components/material-components-web/tree/master/packages/mdc-image-list)
  - [Sass Mixins (MDC Web)](https://github.com/material-components/material-components-web/tree/master/packages/mdc-image-list#sass-mixins)


# Basic Usage

Note that you will have to set the width and margin of image list items
yourself, preferably through SASS.

    import Html.Attributes exposing (style)
    import Material.ImageList as ImageList
    import Material.ImageList.Item as ImageListItem

    main =
        ImageList.imageList ImageList.config
            [ ImageListItem.imageListItem
                (ImageListItem.config
                    |> ImageListItem.setAttributes
                        [ style "width" "calc(100% / 5 - 4.2px)"
                        , style "margin" "2px"
                        ]
                )
                "images/photos/3x2/1.jpg"
            ]


# Configuration

@docs Config, config


## Configuration Options

@docs setMasonry
@docs setWithTextProtection
@docs setAttributes


# Image List

@docs imageList


# Masonry Image List

The Masonry Image List variant presents images vertically arranged into several
columns, using CSS Columns. In this layout, images may be any combination of
aspect ratios.

    ImageList.imageList
        (ImageList.config
            |> ImageList.setMasonry True
        )
        []


# Image List with Label

Image's labels are by default positioned below the image. If you want image
labels to be positioned in a scrim overlaying each image, use the image list's
`setWithTextProtection` configuration option.

    ImageList.imageList
        (ImageList.config
            |> ImageList.setWithTextProtection True
        )
        [ ImageListItem.imageListItem
            (ImageListItem.config
                |> ImageListItem.setLabel "Photo"
            )
            "images/photos/3x2/1.jpg"
        ]

-}

import Html exposing (Html, text)
import Html.Attributes exposing (class)
import Material.ImageList.Item exposing (ImageListItem)
import Material.ImageList.Item.Internal as ImageListItem


{-| Configuration of an image list
-}
type Config msg
    = Config
        { masonry : Bool
        , withTextProtection : Bool
        , additionalAttributes : List (Html.Attribute msg)
        }


{-| Default configuration of an image list
-}
config : Config msg
config =
    Config
        { masonry = False
        , withTextProtection = False
        , additionalAttributes = []
        }


{-| Make an image list a masonry image list
-}
setMasonry : Bool -> Config msg -> Config msg
setMasonry masonry (Config config_) =
    Config { config_ | masonry = masonry }


{-| Make an image list item's label display below the item
-}
setWithTextProtection : Bool -> Config msg -> Config msg
setWithTextProtection withTextProtection (Config config_) =
    Config { config_ | withTextProtection = withTextProtection }


{-| Specify additional attributes
-}
setAttributes : List (Html.Attribute msg) -> Config msg -> Config msg
setAttributes additionalAttributes (Config config_) =
    Config { config_ | additionalAttributes = additionalAttributes }


{-| Image list view function
-}
imageList : Config msg -> List (ImageListItem msg) -> Html msg
imageList ((Config { additionalAttributes }) as config_) listItems =
    Html.node "mdc-image-list"
        (List.filterMap identity
            [ rootCs
            , masonryCs config_
            , withTextProtectionCs config_
            ]
            ++ additionalAttributes
        )
        (List.map (listItemElt config_) listItems)


rootCs : Maybe (Html.Attribute msg)
rootCs =
    Just (class "mdc-image-list")


masonryCs : Config msg -> Maybe (Html.Attribute msg)
masonryCs (Config { masonry }) =
    if masonry then
        Just (class "mdc-image-list--masonry")

    else
        Nothing


withTextProtectionCs : Config msg -> Maybe (Html.Attribute msg)
withTextProtectionCs (Config { withTextProtection }) =
    if withTextProtection then
        Just (class "mdc-image-list--with-text-protection")

    else
        Nothing


listItemElt : Config msg -> ImageListItem msg -> Html msg
listItemElt ((Config { masonry }) as config_) ((ImageListItem.ImageListItem (ImageListItem.Config { href, additionalAttributes })) as listItem) =
    let
        inner =
            [ if masonry then
                imageElt masonry listItem

              else
                imageAspectContainerElt masonry listItem
            , supportingElt listItem
            ]
    in
    Html.node "mdc-image-list-item"
        (class "mdc-image-list__item" :: additionalAttributes)
        (href
            |> Maybe.map (\href_ -> [ Html.a [ Html.Attributes.href href_ ] inner ])
            |> Maybe.withDefault inner
        )


imageAspectContainerElt : Bool -> ImageListItem msg -> Html msg
imageAspectContainerElt masonry ((ImageListItem.ImageListItem (ImageListItem.Config { href })) as listItem) =
    Html.div
        (List.filterMap identity
            [ Just (class "mdc-image-list__image-aspect-container")
            , Maybe.map (\_ -> class "mdc-ripple-surface") href
            ]
        )
        [ imageElt masonry listItem ]


imageElt : Bool -> ImageListItem msg -> Html msg
imageElt masonry (ImageListItem.ImageListItem (ImageListItem.Config { href, image })) =
    let
        img =
            Html.img
                [ class "mdc-image-list__image"
                , Html.Attributes.src image
                ]
                []
    in
    if masonry then
        if href /= Nothing then
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
supportingElt (ImageListItem.ImageListItem (ImageListItem.Config { label })) =
    case label of
        Just string ->
            Html.div
                [ class "mdc-image-list__supporting" ]
                [ Html.span [ class "mdc-image-list__label" ] [ text string ] ]

        Nothing ->
            text ""
