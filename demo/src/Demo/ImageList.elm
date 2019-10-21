module Demo.ImageList exposing (Model, Msg(..), defaultModel, update, view)

import Demo.CatalogPage exposing (CatalogPage)
import Demo.Helper.ResourceLink as ResourceLink
import Html exposing (Html, text)
import Html.Attributes
import Material.ImageList exposing (ImageListItem, imageList, imageListConfig, imageListItem, imageListItemConfig)
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
        [ imageList
            { imageListConfig
                | additionalAttributes = [ Html.Attributes.style "width" "300px" ]
            }
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
    imageList
        { imageListConfig
            | withTextProtection = True
            , additionalAttributes =
                [ Html.Attributes.style "max-width" "900px" ]
        }
        (List.map standardItem standardImages)


masonryImageList : Html msg
masonryImageList =
    imageList
        { imageListConfig
            | masonry = True
            , additionalAttributes =
                [ Html.Attributes.style "max-width" "900px"
                , Html.Attributes.style "column-count" "5"
                , Html.Attributes.style "column-gap" "16px"
                ]
        }
        (List.map masonryItem masonryImages)


imageListHeroItem : ImageListItem msg
imageListHeroItem =
    imageListItem
        { imageListItemConfig
            | label = Nothing
            , additionalAttributes =
                [ Html.Attributes.style "width" "calc(100% / 5 - 4.2px)"
                , Html.Attributes.style "margin" "2px"
                ]
        }
        "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAIAAAACCAYAAABytg0kAAAAAXNSR0IArs4c6QAAAAlwSFlzAAAWJQAAFiUBSVIk8AAAABNJREFUCB1jZGBg+A/EDEwgAgQADigBA//q6GsAAAAASUVORK5CYII%3D"


standardItem : String -> ImageListItem msg
standardItem url =
    -- TODO:
    -- ImageList.imageAspectContainer
    --   [ Html.Attributes.style "padding-bottom" "66.66667%"
    --   ]
    imageListItem
        { imageListItemConfig
            | label = Just "Text label"
            , additionalAttributes =
                [ Html.Attributes.style "width" "calc(100% / 5 - 4.2px)"
                , Html.Attributes.style "margin" "2px"
                ]
        }
        url


masonryItem : String -> ImageListItem msg
masonryItem url =
    imageListItem
        { imageListItemConfig
            | label = Just "Text label"
            , additionalAttributes = [ Html.Attributes.style "margin-bottom" "16px" ]
        }
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
