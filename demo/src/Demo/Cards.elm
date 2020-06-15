module Demo.Cards exposing (Model, Msg(..), defaultModel, update, view)

import Browser.Dom
import Demo.CatalogPage exposing (CatalogPage)
import Html exposing (Html, text)
import Html.Attributes exposing (style)
import Material.Button as Button
import Material.Card as Card
import Material.IconButton as IconButton
import Material.Theme as Theme
import Material.Typography as Typography
import Task


type alias Model =
    {}


defaultModel : Model
defaultModel =
    {}


type Msg
    = Focus String
    | Focused (Result Browser.Dom.Error ())


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Focus id ->
            ( model, Task.attempt Focused (Browser.Dom.focus id) )

        Focused _ ->
            ( model, Cmd.none )


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
        , focusCard
        ]
    }


heroCard : List (Html msg)
heroCard =
    [ Card.card
        (Card.config
            |> Card.setAttributes [ style "width" "350px" ]
        )
        { blocks =
            Card.primaryAction []
                [ demoMedia
                , demoTitle
                , demoBody
                ]
        , actions = Just demoActions
        }
    ]


exampleCard1 : Html msg
exampleCard1 =
    Card.card
        (Card.config
            |> Card.setAttributes
                [ style "margin" "48px 0"
                , style "width" "350px"
                ]
        )
        { blocks =
            Card.primaryAction []
                [ demoMedia
                , demoTitle
                , demoBody
                ]
        , actions = Nothing
        }


exampleCard2 : Html msg
exampleCard2 =
    Card.card
        (Card.config
            |> Card.setAttributes
                [ style "margin" "48px 0"
                , style "width" "350px"
                ]
        )
        { blocks =
            Card.primaryAction []
                [ demoTitle
                , demoBody
                ]
        , actions = Just demoActions
        }


exampleCard3 : Html msg
exampleCard3 =
    Card.card
        (Card.config
            |> Card.setAttributes
                [ style "margin" "48px 0"
                , style "width" "350px"
                , style "border-radius" "24px 8px"
                ]
        )
        { blocks =
            Card.primaryAction []
                [ demoTitle
                , demoBody
                ]
        , actions = Just demoActions
        }


focusCard : Html Msg
focusCard =
    Html.div []
        [ Card.card
            (Card.config
                |> Card.setAttributes
                    [ Html.Attributes.id "my-card"
                    , style "margin" "48px 0"
                    , style "width" "350px"
                    ]
            )
            { blocks =
                Card.primaryAction []
                    [ demoTitle
                    , demoBody
                    ]
            , actions = Just demoActions
            }
        , text "\u{00A0}"
        , Button.raised
            (Button.config |> Button.setOnClick (Focus "my-card"))
            "Focus"
        ]


demoMedia : Card.Block msg
demoMedia =
    Card.sixteenToNineMedia [] "images/photos/3x2/2.jpg"


demoTitle : Card.Block msg
demoTitle =
    Card.block <|
        Html.div
            [ style "padding" "1rem" ]
            [ Html.h2
                [ Typography.headline6
                , style "margin" "0"
                ]
                [ text "Our Changing Planet" ]
            , Html.h3
                [ Typography.subtitle2
                , Theme.textSecondaryOnBackground
                , style "margin" "0"
                ]
                [ text "by Kurt Wagner" ]
            ]


demoBody : Card.Block msg
demoBody =
    Card.block <|
        Html.div
            [ Typography.body2
            , Theme.textSecondaryOnBackground
            , style "padding" "0 1rem 0.5rem 1rem"
            ]
            [ text
                """
                Visit ten places on our planet that are undergoing the biggest
                changes today.
                """
            ]


demoActions : Card.Actions msg
demoActions =
    Card.actions
        { buttons =
            [ Card.button Button.config "Read"
            , Card.button Button.config "Bookmark"
            ]
        , icons =
            [ Card.icon IconButton.config "favorite_border"
            , Card.icon IconButton.config "share"
            , Card.icon IconButton.config "more_vert"
            ]
        }
