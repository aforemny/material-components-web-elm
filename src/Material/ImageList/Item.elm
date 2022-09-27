module Material.ImageList.Item exposing
    ( Config, config
    , setLabel
    , setHref
    , setImageNode
    , setAttributes
    , ImageListItem, imageListItem
    )

{-| An Image List consists of several items, each containing an image and
optionally supporting a text label.

This modules concerns the image list item. If you are looking for information
about the image list contianer, refer to
[Material.ImageList](Material-ImageList).


# Table of Contents

  - [Resources](#resources)
  - [Configuration](#configuration)
      - [Configuration Options](#configuration-options)
  - [Basic Usage](#basic-usage)
  - [Image List Item](#image-list-item)
  - [Image List Item with `Html.img`](#image-list-item)


# Resources

  - [Demo: Image Lists](https://aforemny.github.io/material-components-web-elm/#image-list)
  - [Material Design Guidelines: Image list](https://material.io/go/design-image-list)
  - [MDC Web: Image List](https://github.com/material-components/material-components-web/tree/master/packages/mdc-image-list)
  - [Sass Mixins (MDC Web)](https://github.com/material-components/material-components-web/tree/master/packages/mdc-image-list#sass-mixins)


# Basic Usage

Note that you will have to set the width and margin of image list items
yourself, preferably through SASS or through inline CSS.

    import Html.Attributes exposing (style)
    import Material.ImageList as ImageList
    import Material.ImageList.Item as ImageListItem

    main =
        ImageList.imageList ImageList.config
            [ ImageListItem.imageListItem
                (ImageList.itemConfig
                    |> ImageList.setAttributes
                        [ style "width" "calc(100% / 5 - 4px)"
                        , style "margin" "2px"
                        ]
                )
                "images/photos/3x2/1.jpg"
            ]


# Configuration

@docs Config, config


## Configuration Options

@docs setLabel
@docs setHref
@docs setImageNode
@docs setAttributes


# Image list Item

@docs ImageListItem, imageListItem


# Image list Item with `Html.img`

By default, image list items display the given image as a background image. If you prefer to display the image using a `Html.img` element, set the configuration option `setImageNode`. You may specify additional attributes that go on the `Html.img` element, such as [srcset](https://developer.mozilla.org/en-US/docs/Web/API/HTMLImageElement/srcset) or [sizes](https://developer.mozilla.org/en-US/docs/Web/API/HTMLImageElement/sizes).

Note that in order to retain default behavior, you should specify the CSS rule
`object-fit: cover`.

        ImageListItem.imageListItem
            (ImageList.itemConfig
                |> ImageList.setImageNode (Just [
                  Html.Attribute.style "object-fit" "cover"
                  ])
            )
            "images/photos/3x2/1.jpg"

-}

import Html
import Material.ImageList.Item.Internal exposing (Config(..), ImageListItem(..))


{-| Configuration of an image list item
-}
type alias Config msg =
    Material.ImageList.Item.Internal.Config msg


{-| Default configuration of an image list item
-}
config : Config msg
config =
    Config
        { label = Nothing
        , href = Nothing
        , additionalAttributes = []
        , image = ""
        , imageNode = Nothing
        }


{-| Specify an image list item's label
-}
setLabel : Maybe String -> Config msg -> Config msg
setLabel label (Config config_) =
    Config { config_ | label = label }


{-| Specify whether an image list item is supposed to be a _link image list item_

A link image list items behaves essentially like a HTML5 anchor element.

-}
setHref : Maybe String -> Config msg -> Config msg
setHref href (Config config_) =
    Config { config_ | href = href }


{-| Specify whether an image list item should render a `Html.img` element instead of a background image.

You may pass additional attributes to the `Html.img` element.

Note that in order to retain expected behavior, you may want to specify the CSS rule `object-fit: cover`.

-}
setImageNode : Maybe (List (Html.Attribute msg)) -> Config msg -> Config msg
setImageNode imageNode (Config config_) =
    Config { config_ | imageNode = imageNode }


{-| Specify additional attributes
-}
setAttributes : List (Html.Attribute msg) -> Config msg -> Config msg
setAttributes additionalAttributes (Config config_) =
    Config { config_ | additionalAttributes = additionalAttributes }


{-| Image list item type

Image list items can only be rendered within a [image list
container](Material-ImageList)

-}
type alias ImageListItem msg =
    Material.ImageList.Item.Internal.ImageListItem msg


{-| Image list item constructor
-}
imageListItem : Config msg -> String -> ImageListItem msg
imageListItem (Config config_) image =
    ImageListItem (Config { config_ | image = image })
