module Demo.ImageList exposing (Model, Msg(..), defaultModel, update, view)

import Demo.CatalogPage exposing (CatalogPage)
import Html exposing (Html, text)
import Html.Attributes exposing (style)
import Material.ImageList as ImageList
import Material.ImageList.Item as ImageListItem exposing (ImageListItem)
import Material.Typography as Typography


type alias Model =
    {}


defaultModel : Model
defaultModel =
    {}


type Msg
    = NoOp


update : Msg -> Model -> Model
update msg model =
    model


view : Model -> CatalogPage Msg
view model =
    { title = "Image List"
    , prelude = "Image lists display a collection of images in an organized grid."
    , resources =
        { materialDesignGuidelines = Just "https://material.io/go/design-image-list"
        , documentation = Just "https://package.elm-lang.org/packages/aforemny/material-components-web-elm/latest/Material-ImageList"
        , sourceCode = Just "https://github.com/material-components/material-components-web/tree/master/packages/mdc-image-list"
        }
    , hero =
        [ ImageList.imageList
            (ImageList.config
                |> ImageList.setAttributes [ style "width" "300px" ]
            )
            (List.repeat 15 imageListHeroItem)
        ]
    , content =
        [ Html.h3
            [ Typography.subtitle1 ]
            [ text "Standard Image List with Text Protection" ]
        , standardImageList
        , Html.h3
            [ Typography.subtitle1 ]
            [ text "Masonry Image List" ]
        , masonryImageList
        ]
    }


standardImageList : Html msg
standardImageList =
    ImageList.imageList
        (ImageList.config
            |> ImageList.setWithTextProtection True
            |> ImageList.setAttributes [ style "max-width" "900px" ]
        )
        (List.map standardItem standardImages)


masonryImageList : Html msg
masonryImageList =
    ImageList.imageList
        (ImageList.config
            |> ImageList.setMasonry True
            |> ImageList.setAttributes
                [ style "max-width" "900px"
                , style "column-count" "5"
                , style "column-gap" "16px"
                ]
        )
        (List.map masonryItem masonryImages)


imageListHeroItem : ImageListItem msg
imageListHeroItem =
    ImageListItem.imageListItem
        (ImageListItem.config
            |> ImageListItem.setAttributes
                [ style "width" "calc(100% / 5 - 4.2px)"
                , style "margin" "2px"
                ]
        )
        "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAIAAAACCAYAAABytg0kAAAAAXNSR0IArs4c6QAAAAlwSFlzAAAWJQAAFiUBSVIk8AAAABNJREFUCB1jZGBg+A/EDEwgAgQADigBA//q6GsAAAAASUVORK5CYII%3D"


standardItem : String -> ImageListItem msg
standardItem url =
    -- TODO:
    -- ImageList.imageAspectContainer
    --   [ style "padding-bottom" "66.66667%" ]
    ImageListItem.imageListItem
        (ImageListItem.config
            |> ImageListItem.setLabel (Just "Text label")
            |> ImageListItem.setAttributes
                [ style "width" "calc(100% / 5 - 4.2px)"
                , style "margin" "2px"
                ]
        )
        url


masonryItem : String -> ImageListItem msg
masonryItem url =
    ImageListItem.imageListItem
        (ImageListItem.config
            |> ImageListItem.setLabel (Just "Text label")
            |> ImageListItem.setAttributes [ style "margin-bottom" "16px" ]
        )
        url


standardImages : List String
standardImages =
    [ "images/photos/3x2/1.jpg"
    , "images/photos/3x2/2.jpg"
    , "images/photos/3x2/3.jpg"
    , "images/photos/3x2/4.jpg"
    , "images/photos/3x2/5.jpg"
    , "images/photos/3x2/6.jpg"
    , "images/photos/3x2/7.jpg"
    , "images/photos/3x2/8.jpg"
    , "images/photos/3x2/9.jpg"
    , "images/photos/3x2/10.jpg"
    , "images/photos/3x2/11.jpg"
    , "images/photos/3x2/12.jpg"
    , "images/photos/3x2/13.jpg"
    , "images/photos/3x2/14.jpg"
    , "images/photos/3x2/15.jpg"
    ]


masonryImages : List String
masonryImages =
    [ "images/photos/3x2/16.jpg"
    , "images/photos/2x3/1.jpg"
    , "images/photos/3x2/1.jpg"
    , "images/photos/2x3/2.jpg"
    , "images/photos/2x3/3.jpg"
    , "images/photos/3x2/2.jpg"
    , "images/photos/2x3/4.jpg"
    , "images/photos/3x2/3.jpg"
    , "images/photos/2x3/5.jpg"
    , "images/photos/3x2/4.jpg"
    , "images/photos/2x3/6.jpg"
    , "images/photos/3x2/5.jpg"
    , "images/photos/2x3/7.jpg"
    , "images/photos/3x2/6.jpg"
    , "images/photos/3x2/7.jpg"
    ]
