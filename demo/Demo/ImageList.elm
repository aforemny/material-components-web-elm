module Demo.ImageList exposing (Model, Msg(..), defaultModel, update, view)

import Demo.Helper.ResourceLink as ResourceLink
import Demo.Page as Page exposing (Page)
import Html exposing (Html, text)
import Html.Attributes
import Material.ImageList as ImageList exposing (ImageListItem, imageList, imageListConfig, imageListItem, imageListItemConfig)
import Material.Typography as Typography


type alias Model =
    {}


defaultModel : Model
defaultModel =
    {}


type Msg
    = NoOp


update : (Msg -> m) -> Msg -> Model -> ( Model, Cmd m )
update lift msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )


standardImageList : Html m
standardImageList =
    imageList
        { imageListConfig
            | withTextProtection = True
            , additionalAttributes =
                [ Html.Attributes.style "max-width" "900px" ]
        }
        (List.map standardItem standardImages)


masonryImageList : Html m
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
    imageListItem { imageListItemConfig | label = Just "Text label" } url


view : (Msg -> m) -> Page m -> Model -> Html m
view lift page model =
    page.body "Image List"
        "Image lists display a collection of images in an organized grid."
        [ Page.hero []
            [ imageList
                { imageListConfig
                    | additionalAttributes = [ Html.Attributes.style "width" "300px" ]
                }
                (List.repeat 15 imageListHeroItem)
            ]
        , Html.h2
            [ Typography.headline6
            , Html.Attributes.style "border-bottom" "1px solid rgba(0,0,0,.87)"
            ]
            [ text "Resources"
            ]
        , ResourceLink.view
            { link = "https://material.io/go/design-image-list"
            , title = "Material Design Guidelines"
            , icon = "images/material.svg"
            , altText = "Material Design Guidelines icon"
            }
        , ResourceLink.view
            { link = "https://material.io/components/web/catalog/image-lists/"
            , title = "Documentation"
            , icon = "images/ic_drive_document_24px.svg"
            , altText = "Documentation icon"
            }
        , ResourceLink.view
            { link = "https://github.com/material-components/material-components-web/tree/master/packages/mdc-image-list"
            , title = "Source Code (Material Components Web)"
            , icon = "images/ic_code_24px.svg"
            , altText = "Source Code"
            }
        , Page.demos
            [ Html.h3
                [ Typography.subtitle1 ]
                [ text "Standard Image List with Text Protection" ]
            , standardImageList
            , Html.h3
                [ Typography.subtitle1 ]
                [ text "Masonry Image List" ]
            , masonryImageList
            ]
        ]


standardImages : List String
standardImages =
    [ "https://material-components.github.io/material-components-web-catalog/static/media/photos/3x2/1.jpg"
    , "https://material-components.github.io/material-components-web-catalog/static/media/photos/3x2/2.jpg"
    , "https://material-components.github.io/material-components-web-catalog/static/media/photos/3x2/3.jpg"
    , "https://material-components.github.io/material-components-web-catalog/static/media/photos/3x2/4.jpg"
    , "https://material-components.github.io/material-components-web-catalog/static/media/photos/3x2/5.jpg"
    , "https://material-components.github.io/material-components-web-catalog/static/media/photos/3x2/6.jpg"
    , "https://material-components.github.io/material-components-web-catalog/static/media/photos/3x2/7.jpg"
    , "https://material-components.github.io/material-components-web-catalog/static/media/photos/3x2/8.jpg"
    , "https://material-components.github.io/material-components-web-catalog/static/media/photos/3x2/9.jpg"
    , "https://material-components.github.io/material-components-web-catalog/static/media/photos/3x2/10.jpg"
    , "https://material-components.github.io/material-components-web-catalog/static/media/photos/3x2/11.jpg"
    , "https://material-components.github.io/material-components-web-catalog/static/media/photos/3x2/12.jpg"
    , "https://material-components.github.io/material-components-web-catalog/static/media/photos/3x2/13.jpg"
    , "https://material-components.github.io/material-components-web-catalog/static/media/photos/3x2/14.jpg"
    , "https://material-components.github.io/material-components-web-catalog/static/media/photos/3x2/15.jpg"
    ]


masonryImages : List String
masonryImages =
    [ "https://material-components.github.io/material-components-web-catalog/static/media/photos/3x2/16.jpg"
    , "https://material-components.github.io/material-components-web-catalog/static/media/photos/2x3/1.jpg"
    , "https://material-components.github.io/material-components-web-catalog/static/media/photos/3x2/1.jpg"
    , "https://material-components.github.io/material-components-web-catalog/static/media/photos/2x3/2.jpg"
    , "https://material-components.github.io/material-components-web-catalog/static/media/photos/2x3/3.jpg"
    , "https://material-components.github.io/material-components-web-catalog/static/media/photos/3x2/2.jpg"
    , "https://material-components.github.io/material-components-web-catalog/static/media/photos/2x3/4.jpg"
    , "https://material-components.github.io/material-components-web-catalog/static/media/photos/3x2/3.jpg"
    , "https://material-components.github.io/material-components-web-catalog/static/media/photos/2x3/5.jpg"
    , "https://material-components.github.io/material-components-web-catalog/static/media/photos/3x2/4.jpg"
    , "https://material-components.github.io/material-components-web-catalog/static/media/photos/2x3/6.jpg"
    , "https://material-components.github.io/material-components-web-catalog/static/media/photos/3x2/5.jpg"
    , "https://material-components.github.io/material-components-web-catalog/static/media/photos/2x3/7.jpg"
    , "https://material-components.github.io/material-components-web-catalog/static/media/photos/3x2/6.jpg"
    , "https://material-components.github.io/material-components-web-catalog/static/media/photos/3x2/7.jpg"
    ]
