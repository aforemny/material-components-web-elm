module Demo.Fabs exposing (Model, Msg(..), defaultModel, update, view)

import Demo.Helper.ResourceLink as ResourceLink
import Demo.Page as Page exposing (Page)
import Html exposing (Html, text)
import Html.Attributes
import Html.Events
import Material.Fab as Fab exposing (fab, fabConfig)
import Material.Fab.Extended as ExtendedFab exposing (extendedFab, extendedFabConfig)
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


view : (Msg -> m) -> Page m -> Model -> Html m
view lift page model =
    page.body "Floating Action Button"
        "Floating action buttons represents the primary action in an application. Only one floating action button is recommended per screen to represent the most common action."
        [ Page.hero [] [ fab fabConfig "favorite_border" ]
        , Html.h2
            [ Typography.headline6
            , Html.Attributes.style "border-bottom" "1px solid rgba(0,0,0,.87)"
            ]
            [ text "Resources"
            ]
        , ResourceLink.view
            { link = "https://material.io/go/design-fab"
            , title = "Material Design Guidelines"
            , icon = "images/material.svg"
            , altText = "Material Design Guidelines icon"
            }
        , ResourceLink.view
            { link = "https://material.io/components/web/catalog/buttons/floating-action-buttons/"
            , title = "Documentation"
            , icon = "images/ic_drive_document_24px.svg"
            , altText = "Documentation icon"
            }
        , ResourceLink.view
            { link = "https://github.com/material-components/material-components-web/blob/master/packages/mdc-fab/"
            , title = "Source Code (Material Components Web)"
            , icon = "images/ic_code_24px.svg"
            , altText = "Source Code"
            }
        , Page.demos
            [ Html.h3
                [ Typography.subtitle1 ]
                [ text "Standard Floating Action Button" ]
            , fab fabConfig "favorite_border"
            , Html.h3
                [ Typography.subtitle1 ]
                [ text "Mini Floating Action Button" ]
            , fab { fabConfig | mini = True } "favorite_border"
            , Html.h3 [ Typography.subtitle1 ] [ text "Extended FAB" ]
            , extendedFab { extendedFabConfig | icon = Just "add" } "Create"
            , Html.h3
                [ Typography.subtitle1 ]
                [ text "Extended FAB (Text label followed by icon)" ]
            , extendedFab { extendedFabConfig | icon = Just "add", trailingIcon = True }
                "Create"
            , Html.h3
                [ Typography.subtitle1 ]
                [ text "Extended FAB (without icon)" ]
            , extendedFab extendedFabConfig "Create"
            , Html.h3
                [ Typography.subtitle1 ]
                [ text "FAB (Shaped)" ]
            , Html.div [ Html.Attributes.style "display" "flex" ]
                [ fab
                    { fabConfig
                        | additionalAttributes =
                            [ Html.Attributes.style "border-radius" "50% 0"
                            , Html.Attributes.style "margin-right" "24px"
                            ]
                    }
                    "favorite_border"
                , fab
                    { fabConfig
                        | mini = True
                        , additionalAttributes =
                            [ Html.Attributes.style "border-radius" "8px"
                            , Html.Attributes.style "margin-right" "24px"
                            ]
                    }
                    "favorite_border"
                , extendedFab { extendedFabConfig | icon = Just "add" } "Create"
                ]
            ]
        ]
