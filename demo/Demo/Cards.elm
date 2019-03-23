module Demo.Cards exposing (Model, Msg(..), defaultModel, update, view)

import Demo.Helper.Hero as Hero
import Demo.Helper.ResourceLink as ResourceLink
import Demo.Page as Page exposing (Page)
import Html exposing (Html, text)
import Html.Attributes
import Material.Button as Button exposing (button, buttonConfig)
import Material.Card as Card exposing (card, cardConfig, mediaConfig, primaryActionConfig)
import Material.Checkbox as Checkbox
import Material.FormField as FormField
import Material.Icon as Icon exposing (icon, iconConfig)
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


cardMedia : Card.Block m
cardMedia =
    Card.media { mediaConfig | aspect = Just Card.SixteenToNine } "images/16-9.jpg"


cardTitle : Card.Block m
cardTitle =
    Card.custom <|
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
                , Theme.secondaryBg
                , Html.Attributes.style "margin" "0"
                ]
                [ text "by Kurt Wagner"
                ]
            ]


cardBody : Card.Block m
cardBody =
    Card.custom <|
        Html.div
            [ Html.Attributes.style "padding" "0 1rem 0.5rem 1rem"
            , Typography.body2
            , Theme.secondaryBg
            ]
            [ text """
            Visit ten places on our planet that are undergoing the biggest
            changes today.
          """
            ]


cardActions : Card.Actions m
cardActions =
    Card.actions
        { buttons =
            [ Card.actionButton buttonConfig "Read"
            , Card.actionButton buttonConfig "Bookmark"
            ]
        , icons =
            [ Card.actionIcon iconConfig "favorite"
            , Card.actionIcon iconConfig "share"
            , Card.actionIcon iconConfig "more_vert"
            ]
        }


heroCard : (Msg -> m) -> String -> Model -> Html m
heroCard lift index model =
    card
        { cardConfig
            | additionalAttributes =
                [ Html.Attributes.style "width" "350px" ]
        }
        { blocks =
            Card.primaryAction primaryActionConfig
                [ cardMedia
                , cardTitle
                , cardBody
                ]
        , actions = Just cardActions
        }


exampleCard1 : (Msg -> m) -> String -> Model -> Html m
exampleCard1 lift index model =
    card
        { cardConfig
            | additionalAttributes =
                [ Html.Attributes.style "margin" "48px 0"
                , Html.Attributes.style "width" "350px"
                ]
        }
        { blocks =
            Card.primaryAction primaryActionConfig
                [ cardMedia
                , cardTitle
                , cardBody
                ]
        , actions = Just cardActions
        }


exampleCard2 : (Msg -> m) -> String -> Model -> Html m
exampleCard2 lift index model =
    card
        { cardConfig
            | additionalAttributes =
                [ Html.Attributes.style "margin" "48px 0"
                , Html.Attributes.style "width" "350px"
                ]
        }
        { blocks =
            Card.primaryAction primaryActionConfig
                [ cardTitle
                , cardBody
                ]
        , actions = Just cardActions
        }


exampleCard3 : (Msg -> m) -> String -> Model -> Html m
exampleCard3 lift index model =
    card
        { cardConfig
            | additionalAttributes =
                [ Html.Attributes.style "margin" "48px 0"
                , Html.Attributes.style "width" "350px"
                , Html.Attributes.style "border-radius" "24px 8px"
                ]
        }
        { blocks =
            Card.primaryAction primaryActionConfig
                [ cardTitle
                , cardBody
                ]
        , actions = Just cardActions
        }


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
