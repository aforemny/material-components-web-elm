module Demo.LinearProgress exposing (view)

import Demo.Helper.ResourceLink as ResourceLink
import Demo.Page as Page exposing (Page)
import Html exposing (Html, text)
import Html.Attributes
import Material.LinearProgress as LinearProgress exposing (bufferedLinearProgress, determinateLinearProgress, indeterminateLinearProgress, linearProgressConfig)
import Material.Typography as Typography


view : Page m -> Html m
view page =
    page.body "Linear Progress Indicator"
        "Progress indicators display the length of a process or express an unspecified wait time."
        [ Page.hero []
            [ determinateLinearProgress linearProgressConfig { progress = 0.5 }
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
            , bufferedLinearProgress linearProgressConfig
                { progress = 0.5, buffered = 0.75 }
            , Html.h3 [ Typography.subtitle1 ] [ text "Indeterminate" ]
            , indeterminateLinearProgress linearProgressConfig
            , Html.h3 [ Typography.subtitle1 ] [ text "Reversed" ]
            , determinateLinearProgress { linearProgressConfig | reverse = True }
                { progress = 0.5 }
            , Html.h3 [ Typography.subtitle1 ] [ text "Reversed Buffered" ]
            , bufferedLinearProgress { linearProgressConfig | reverse = True }
                { progress = 0.5, buffered = 0.75 }
            ]
        ]
