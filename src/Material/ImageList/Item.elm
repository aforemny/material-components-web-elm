module Material.ImageList.Item exposing
    ( Config, config
    , setLabel
    , setHref
    , setAttributes
    , ImageListItem, imageListItem
    )

{-| An Image List consists of several items, each containing an image and
optionally supporting a text label.


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
yourself, preferably through SASS.

    import Html.Attributes exposing (style)
    import Material.ImageList as ImageList
    import Material.ImageList.Item as ImageListItem

    main =
        ImageList.imageList ImageList.config
            [ ImageListItem.imageListItem
                (ImageList.itemConfig
                    |> ImageList.setAttributes
                        [ style "width" "calc(100% / 5 - 4.2px)"
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
import Material.ImageList.Item.Internal


{-| Configuration of an image list item
-}
type alias Config msg =
    Material.ImageList.Item.Internal.Config msg


{-| Default configuration of an image list item
-}
config : Config msg
config =
    Material.ImageList.Item.Internal.Config
        { label = Nothing
        , href = Nothing
        , additionalAttributes = []
        , image = ""
        }


{-| Set an image list item's label
-}
setLabel : String -> Config msg -> Config msg
setLabel label (Material.ImageList.Item.Internal.Config config_) =
    Material.ImageList.Item.Internal.Config { config_ | label = Just label }


{-| Make an image list item behave like a HTML5 anchor element
-}
setHref : Maybe String -> Config msg -> Config msg
setHref href (Material.ImageList.Item.Internal.Config config_) =
    Material.ImageList.Item.Internal.Config { config_ | href = href }


{-| Specify additional attributes
-}
setAttributes : List (Html.Attribute msg) -> Config msg -> Config msg
setAttributes additionalAttributes (Material.ImageList.Item.Internal.Config config_) =
    Material.ImageList.Item.Internal.Config
        { config_ | additionalAttributes = additionalAttributes }


{-| Image list item
-}
type alias ImageListItem msg =
    Material.ImageList.Item.Internal.ImageListItem msg


{-| Image list item constructor
-}
imageListItem : Config msg -> String -> ImageListItem msg
imageListItem (Material.ImageList.Item.Internal.Config config_) image =
    Material.ImageList.Item.Internal.ImageListItem
        (Material.ImageList.Item.Internal.Config { config_ | image = image })
