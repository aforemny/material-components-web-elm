module Material.ImageList.Item exposing
    ( Config, config
    , setLabel
    , setHref
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
@docs setAttributes


# Image list Item

@docs ImageListItem, imageListItem

-}

import Html exposing (Html, text)
import Html.Attributes exposing (class)
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
