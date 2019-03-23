module Demo.Cards exposing (Model, Msg(..), defaultModel, update, view)

import Demo.Helper.Hero as Hero
import Demo.Helper.ResourceLink as ResourceLink
import Demo.Page as Page exposing (Page)
import Html exposing (Html, text)
import Html.Attributes
import Material.Button as Button
import Material.Card as Card
import Material.Checkbox as Checkbox
import Material.FormField as FormField
import Material.Icon as Icon
import Material.IconToggle as IconToggle
import Material.Ripple as Ripple
import Material.Theme as Theme
import Material.Typography as Typography
import Platform.Cmd exposing (Cmd, none)


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


cardMedia : Html m
cardMedia =
    Card.media
        [ Card.aspect16To9
        , Card.backgroundImage "images/16-9.jpg"
        ]
        []


cardTitle : Html m
cardTitle =
    Html.div
        [ Html.Attributes.style "padding" "1rem"
        ]
        [ Html.h2
            [ Typography.headline6
            , Html.Attributes.style "margin" "0"
            ]
            [ text "Our Changing Planet"
            ]
        , Html.h3
            [ Typography.subtitle2
            , Theme.textSecondaryOnBackground
            , Html.Attributes.style "margin" "0"
            ]
            [ text "by Kurt Wagner"
            ]
        ]


cardBody : Html m
cardBody =
    Html.div
        [ Html.Attributes.style "padding" "0 1rem 0.5rem 1rem"
        , Typography.body2
        , Theme.textSecondaryOnBackground
        ]
        [ text """
            Visit ten places on our planet that are undergoing the biggest
            changes today.
          """
        ]


cardActions : (Msg -> m) -> String -> Model -> Html m
cardActions lift index model =
    Card.actions []
        [ Card.actionButtons []
            [ Button.view lift
                (index ++ "-action-button-read")
                model.mdc
                [ Card.actionButton
                , Button.ripple
                ]
                [ text "Read"
                ]
            , Button.view lift
                (index ++ "-action-button-bookmark")
                model.mdc
                [ Card.actionButton
                , Button.ripple
                ]
                [ text "Bookmark"
                ]
            ]
        , Card.actionIcons []
            [ IconToggle.view lift
                (index ++ "-action-icon-favorite")
                model.mdc
                [ Card.actionIcon
                , IconToggle.icon
                    { on = "favorite"
                    , off = "favorite_border"
                    }
                , IconToggle.label
                    { on = "Remove from favorites"
                    , off = "Add to favorites"
                    }
                ]
                []
            , IconToggle.view lift
                (index ++ "-action-icon-share")
                model.mdc
                [ Card.actionIcon
                , IconToggle.icon { on = "share", off = "share" }
                , IconToggle.label { on = "Share", off = "Share" }
                ]
                []
            , IconToggle.view lift
                (index ++ "-action-icon-more-options")
                model.mdc
                [ Card.actionIcon
                , IconToggle.icon { on = "more_vert", off = "more_vert" }
                , IconToggle.label { on = "More options", off = "More options" }
                ]
                []
            ]
        ]


heroCard : (Msg -> m) -> String -> Model -> Html m
heroCard lift index model =
    let
        ripple =
            Ripple.bounded lift (index ++ "-ripple") model.mdc []
    in
    Card.view
        [ Html.Attributes.style "width" "350px"
        ]
        [ Card.primaryAction
            [ ripple.properties
            , ripple.interactionHandler
            ]
            [ cardMedia
            , cardTitle
            , cardBody
            , ripple.style
            ]
        , cardActions lift index model
        ]


exampleCard1 : (Msg -> m) -> String -> Model -> Html m
exampleCard1 lift index model =
    let
        ripple =
            Ripple.bounded lift (index ++ "-ripple") model.mdc []
    in
    Card.view
        [ Html.Attributes.style "margin" "48px 0"
        , Html.Attributes.style "width" "350px"
        ]
        [ Card.primaryAction
            [ ripple.properties
            , ripple.interactionHandler
            ]
            [ cardMedia
            , cardTitle
            , cardBody
            , ripple.style
            ]
        , cardActions lift index model
        ]


exampleCard2 : (Msg -> m) -> String -> Model -> Html m
exampleCard2 lift index model =
    let
        ripple =
            Ripple.bounded lift (index ++ "-ripple") model.mdc []
    in
    Card.view
        [ Html.Attributes.style "margin" "48px 0"
        , Html.Attributes.style "width" "350px"
        ]
        [ Card.primaryAction
            [ ripple.properties
            , ripple.interactionHandler
            ]
            [ cardTitle
            , cardBody
            , ripple.style
            ]
        , cardActions lift index model
        ]


exampleCard3 : (Msg -> m) -> String -> Model -> Html m
exampleCard3 lift index model =
    let
        ripple =
            Ripple.bounded lift (index ++ "-ripple") model.mdc []
    in
    Card.view
        [ Html.Attributes.style "margin" "48px 0"
        , Html.Attributes.style "width" "350px"
        , Html.Attributes.style "border-radius" "24px 8px"
        ]
        [ Card.primaryAction
            [ ripple.properties
            , ripple.interactionHandler
            ]
            [ cardTitle
            , cardBody
            , ripple.style
            ]
        , cardActions lift index model
        ]


view : (Msg -> m) -> Page m -> Model -> Html m
view lift page model =
    page.body "Card"
        "Cards contain content and actions about a single subject."
        [ Hero.view []
            [ heroCard lift "card-hero-card" model
            ]
        , Html.h2
            [ Typography.headline6
            , Html.Attributes.style "border-bottom" "1px solid rgba(0,0,0,.87)"
            ]
            [ text "Resources"
            ]
        , ResourceLink.view
            { link = "https://material.io/go/design-cards"
            , title = "Material Design Guidelines"
            , icon = "images/material.svg"
            , altText = "Material Design Guidelines"
            }
        , ResourceLink.view
            { link = "https://material.io/components/web/catalog/cards/"
            , title = "Documentation"
            , icon = "images/ic_drive_document_24px.svg"
            , altText = "Documentation"
            }
        , ResourceLink.view
            { link = "https://github.com/material-components/material-components-web/tree/master/packages/mdc-card"
            , title = "Source Code (Material Components Web)"
            , icon = "images/ic_code_24px.svg"
            , altText = "Source Code"
            }
        , Page.demos
            [ exampleCard1 lift "cards-example-card-1" model
            , exampleCard2 lift "cards-example-card-2" model
            , exampleCard3 lift "cards-example-card-3" model
            ]
        ]
