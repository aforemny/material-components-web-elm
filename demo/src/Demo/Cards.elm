module Demo.Cards exposing (Model, Msg(..), defaultModel, update, view)

import Demo.CatalogPage exposing (CatalogPage)
import Demo.Helper.ResourceLink as ResourceLink
import Html exposing (Html, text)
import Html.Attributes
import Material.Button exposing (buttonConfig)
import Material.Card as Card exposing (CardActions, CardBlock, card, cardActionButton, cardActionIcon, cardActions, cardBlock, cardConfig, cardMedia, cardMediaConfig, cardPrimaryAction, cardPrimaryActionConfig)
import Material.IconButton exposing (iconButtonConfig)
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


update : Msg -> Model -> Model
update msg model =
    model


view : Model -> CatalogPage Msg
view model =
    { title = "Card"
    , prelude = "Cards contain content and actions about a single subject."
    , resources =
        { materialDesignGuidelines = Just "https://material.io/go/design-cards"
        , documentation = Just "https://package.elm-lang.org/packages/aforemny/material-components-web-elm/latest/Material-Card"
        , sourceCode = Just "https://github.com/material-components/material-components-web/tree/master/packages/mdc-card"
        }
    , hero = heroCard
    , content =
        [ exampleCard1
        , exampleCard2
        , exampleCard3
        ]
    }


heroCard : List (Html msg)
heroCard =
    [ card
        { cardConfig
            | additionalAttributes =
                [ Html.Attributes.style "width" "350px" ]
        }
        { blocks =
            cardPrimaryAction cardPrimaryActionConfig
                [ demoMedia
                , demoTitle
                , demoBody
                ]
        , actions = Just demoActions
        }
    ]


exampleCard1 : Html msg
exampleCard1 =
    card
        { cardConfig
            | additionalAttributes =
                [ Html.Attributes.style "margin" "48px 0"
                , Html.Attributes.style "width" "350px"
                ]
        }
        { blocks =
            cardPrimaryAction cardPrimaryActionConfig
                [ demoMedia
                , demoTitle
                , demoBody
                ]
        , actions = Nothing
        }


exampleCard2 : Html msg
exampleCard2 =
    card
        { cardConfig
            | additionalAttributes =
                [ Html.Attributes.style "margin" "48px 0"
                , Html.Attributes.style "width" "350px"
                ]
        }
        { blocks =
            cardPrimaryAction cardPrimaryActionConfig
                [ demoTitle
                , demoBody
                ]
        , actions = Just demoActions
        }


exampleCard3 : Html msg
exampleCard3 =
    card
        { cardConfig
            | additionalAttributes =
                [ Html.Attributes.style "margin" "48px 0"
                , Html.Attributes.style "width" "350px"
                , Html.Attributes.style "border-radius" "24px 8px"
                ]
        }
        { blocks =
            cardPrimaryAction cardPrimaryActionConfig
                [ demoTitle
                , demoBody
                ]
        , actions = Just demoActions
        }


demoMedia : CardBlock msg
demoMedia =
    cardMedia { cardMediaConfig | aspect = Just Card.SixteenToNine }
        "images/photos/3x2/2.jpg"


demoTitle : CardBlock msg
demoTitle =
    cardBlock <|
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


demoBody : CardBlock msg
demoBody =
    cardBlock <|
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


demoActions : CardActions msg
demoActions =
    cardActions
        { buttons =
            [ cardActionButton buttonConfig "Read"
            , cardActionButton buttonConfig "Bookmark"
            ]
        , icons =
            [ cardActionIcon iconButtonConfig "favorite_border"
            , cardActionIcon iconButtonConfig "share"
            , cardActionIcon iconButtonConfig "more_vert"
            ]
        }
