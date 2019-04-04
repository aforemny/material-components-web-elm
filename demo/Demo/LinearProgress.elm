module Demo.LinearProgress exposing (view)

import Demo.Helper.ResourceLink as ResourceLink
import Demo.Page as Page exposing (Page)
import Html exposing (Html, text)
import Html.Attributes
import Material.LinearProgress as LinearProgress exposing (linearProgress, linearProgressConfig)
import Material.Typography as Typography


view : Page m -> Html m
view page =
    page.body "Linear Progress Indicator"
        "Progress indicators display the length of a process or express an unspecified wait time."
        [ Page.hero []
            [ linearProgress
                { linearProgressConfig | variant = LinearProgress.Determinate 0.5 }
            ]
        , Html.h2
            [ Typography.headline6
            , Html.Attributes.style "border-bottom" "1px solid rgba(0,0,0,.87)"
            ]
            [ text "Resources"
            ]
        , ResourceLink.view
            { link = "https://material.io/go/design-progress-indicators"
            , title = "Material Design Guidelines"
            , icon = "images/material.svg"
            , altText = "Material Design Guidelines icon"
            }
        , ResourceLink.view
            { link = "https://material.io/components/web/catalog/linear-progress/"
            , title = "Documentation"
            , icon = "images/ic_drive_document_24px.svg"
            , altText = "Documentation icon"
            }
        , ResourceLink.view
            { link = "https://github.com/material-components/material-components-web/tree/master/packages/mdc-linear-progress"
            , title = "Source Code (Material Components Web)"
            , icon = "images/ic_code_24px.svg"
            , altText = "Source Code"
            }
        , Page.demos
            [ Html.h3 [ Typography.subtitle1 ] [ text "Buffered" ]
            , linearProgress
                { linearProgressConfig | variant = LinearProgress.Buffered 0.5 0.75 }
            , Html.h3 [ Typography.subtitle1 ] [ text "Indeterminate" ]
            , linearProgress linearProgressConfig
            , Html.h3 [ Typography.subtitle1 ] [ text "Reversed" ]
            , linearProgress
                { linearProgressConfig
                    | variant = LinearProgress.Determinate 0.5
                    , reverse = True
                }
            , Html.h3 [ Typography.subtitle1 ] [ text "Reversed Buffered" ]
            , linearProgress
                { linearProgressConfig
                    | variant = LinearProgress.Buffered 0.5 0.75
                    , reverse = True
                }
            ]
        ]
