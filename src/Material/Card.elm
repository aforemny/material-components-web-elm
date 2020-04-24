module Material.Card exposing
    ( Config, config
    , setOutlined
    , setAttributes
    , card, Content
    , Block
    , block
    , squareMedia, sixteenToNineMedia, media
    , primaryAction
    , actions, Actions, actionButton, actionIcon
    , fullBleedActions
    )

{-| Cards contain content and actions about a single subject.


# Table of Contents

  - [Resources](#resources)
  - [Basic Usage](#basic-usage)
  - [Configuration](#configuration)
      - [Configuration Options](#configuration-options)
  - [Card](#card)
      - [Outlined card](#outlined-card)
  - [Card Blocks](#card-blocks)
      - [Generic Block](#generic-block)
      - [Media Block](#media-block)
      - [Primary Action Block](#primary-action-block)
  - [Card Actions](#card-actions)
      - [Full Bleed Actions](#full-bleed-actions)


# Resources

  - [Demo: Cards](https://aforemny.github.io/material-components-web-elm/#cards)
  - [Material Design Guidelines: Cards](https://material.io/go/design-cards)
  - [MDC Web: Card](https://github.com/material-components/material-components-web/tree/master/packages/mdc-card)
  - [Sass Mixins (MDC Web)](https://github.com/material-components/material-components-web/tree/master/packages/mdc-card#sass-mixins)


# Basic Usage

    import Html exposing (Html, text)
    import Material.Button as Button
    import Material.Card as Card
    import Material.IconButton as IconButton

    main =
        Card.card Card.config
            { blocks =
                [ Card.block <|
                    Html.div []
                        [ Html.h2 [] [ text "Title" ]
                        , Html.h3 [] [ text "Subtitle" ]
                        ]
                , Card.block <|
                    Html.div []
                        [ Html.p [] [ text "Lorem ipsum…" ] ]
                ]
            , actions =
                Just <|
                    Card.actions
                        { buttons =
                            [ Card.actionButton Button.config
                                "Visit"
                            ]
                        , icons =
                            [ Card.actionIcon IconButton.config
                                "favorite"
                            ]
                        }
            }


# Configuration

@docs Config, config


## Configuration Options

@docs setOutlined
@docs setAttributes


# Card

@docs card, Content


## Outlined Card

A card may have a border by settings its `outlined` configuration field to
`True`.

    Card.card
        (Card.config
            |> Card.setOutlined True
        )
        { blocks =
            [ Card.block <|
                Html.div [] [ Html.h1 [] [ text "Card" ] ]
            ]
        , actions = Nothing
        }


# Card Blocks

A card's content is primary comprised of blocks. Blocks may be comprised of
arbitrary HTML (generic `cardBlock`) or a media element (`cardMedia`).
Optionally, a group of card blocks can be marked as the card's primary action
which makes the group of card blocks interactable.

@docs Block


## Generic Block

Generic card blocks are the most common and allow you to specify card content
using arbitrary HTML. Note that you will have to carefully adjust styling such
as padding and typography yourself.

    Card.block <|
        Html.div []
            [ Html.h2 [] [ text "Title" ]
            , Html.h3 [] [ text "Subtitle" ]
            ]

@docs block


## Media Block

Card may contain a media block usually as the first content block. The media
will be displayed using a background image, and you may chose from square or a
16 to 9 aspect ratio.

@docs squareMedia, sixteenToNineMedia, media


## Primary Action Block

A group of card blocks can be marked as the primary action of the card. A
primary action block may be clicked upon and displays a visual interaction
effect.

    Card.primaryAction
        [ Html.Events.onClick CardClicked ]
        [ Card.block <|
            Html.h2 [] [ text "Title" ]
        , Card.block <|
            Html.p [] [ text "Lorem ipsum…" ]
        ]

@docs primaryAction


# Card Actions

Card actions are comprised of buttons and icons. These are exposed as variants
to the standard buttons and icons, but they do share the same configuration.

    Card.actions
        { buttons =
            [ Card.actionButton Button.config "View" ]
        , actions =
            [ Card.actionIcon IconButton.config "favorite" ]
        }

@docs actions, Actions, actionButton, actionIcon


## Card Full Bleed Actions

While a card's action buttons are usually left-aligned, a special case exists
when there is only a single button as card action.

@docs fullBleedActions

-}

import Html exposing (Html, text)
import Html.Attributes exposing (class, style)
import Html.Events
import Material.Button as Button
import Material.Button.Internal
import Material.IconButton as IconButton
import Material.IconButton.Internal


{-| Configuration of a card
-}
type Config msg
    = Config
        { outlined : Bool
        , additionalAttributes : List (Html.Attribute msg)
        }


{-| Card view function
-}
config : Config msg
config =
    Config
        { outlined = False
        , additionalAttributes = []
        }


{-| Set a card to be outlined
-}
setOutlined : Bool -> Config msg -> Config msg
setOutlined outlined (Config config_) =
    Config { config_ | outlined = outlined }


{-| Specify additional attributes
-}
setAttributes : List (Html.Attribute msg) -> Config msg -> Config msg
setAttributes additionalAttributes (Config config_) =
    Config { config_ | additionalAttributes = additionalAttributes }


{-| Card view function
-}
card : Config msg -> Content msg -> Html msg
card ((Config { additionalAttributes }) as config_) content =
    Html.node "mdc-card"
        (List.filterMap identity
            [ rootCs
            , outlinedCs config_
            ]
            ++ additionalAttributes
        )
        (List.concat
            [ blocksElt content
            , actionsElt content
            ]
        )


blocksElt : Content msg -> List (Html msg)
blocksElt { blocks } =
    List.map (\(Block html) -> html) blocks


actionsElt : Content msg -> List (Html msg)
actionsElt content =
    case content.actions of
        Just (Actions { buttons, icons, fullBleed }) ->
            [ Html.div
                (List.filterMap identity
                    [ Just (class "mdc-card__actions")
                    , if fullBleed then
                        Just (class "mdc-card__actions--full-bleed")

                      else
                        Nothing
                    ]
                )
                (List.concat
                    [ if not (List.isEmpty buttons) then
                        [ Html.div [ class "mdc-card__action-buttons" ]
                            (List.map (\(Button button) -> button) buttons)
                        ]

                      else
                        []
                    , if not (List.isEmpty icons) then
                        [ Html.div [ class "mdc-card__action-icons" ]
                            (List.map (\(Icon icon) -> icon) icons)
                        ]

                      else
                        []
                    ]
                )
            ]

        Nothing ->
            []


rootCs : Maybe (Html.Attribute msg)
rootCs =
    Just (class "mdc-card")


outlinedCs : Config msg -> Maybe (Html.Attribute msg)
outlinedCs (Config { outlined }) =
    if outlined then
        Just (class "mdc-card--outlined")

    else
        Nothing


{-| The content of a card is comprised of _blocks_ and _actions_.
-}
type alias Content msg =
    { blocks : List (Block msg)
    , actions : Maybe (Actions msg)
    }


{-| Card's content block
-}
type Block msg
    = Block (Html msg)


{-| An arbitrary card block

    Card.block <|
        Html.div [] [ text "Lorem ipsum…" ]

-}
block : Html msg -> Block msg
block =
    Block


type Aspect
    = Square
    | SixteenToNine


mediaView : Maybe Aspect -> List (Html.Attribute msg) -> String -> Block msg
mediaView aspect additionalAttributes backgroundImage =
    Block <|
        Html.div
            (List.filterMap identity
                [ mediaCs
                , backgroundImageAttr backgroundImage
                , aspectCs aspect
                ]
                ++ additionalAttributes
            )
            []


{-| Card media block with a square aspect ratio
-}
squareMedia : List (Html.Attribute msg) -> String -> Block msg
squareMedia additionalAttributes backgroundImage =
    mediaView (Just Square) additionalAttributes backgroundImage


{-| Card media block with a 16:9 aspect ratio
-}
sixteenToNineMedia : List (Html.Attribute msg) -> String -> Block msg
sixteenToNineMedia additionalAttributes backgroundImage =
    mediaView (Just SixteenToNine) additionalAttributes backgroundImage


{-| Card media block of unspecified aspect ratio
-}
media : List (Html.Attribute msg) -> String -> Block msg
media additionalAttributes backgroundImage =
    mediaView Nothing additionalAttributes backgroundImage


mediaCs : Maybe (Html.Attribute msg)
mediaCs =
    Just (class "mdc-card__media")


backgroundImageAttr : String -> Maybe (Html.Attribute msg)
backgroundImageAttr url =
    Just (style "background-image" ("url(\"" ++ url ++ "\")"))


aspectCs : Maybe Aspect -> Maybe (Html.Attribute msg)
aspectCs aspect =
    case aspect of
        Just Square ->
            Just (class "mdc-card__media--square")

        Just SixteenToNine ->
            Just (class "mdc-card__media--16-9")

        Nothing ->
            Nothing


{-| A card's primary action block

    Card.primaryAction
        [ Html.Events.onClick CardClicked ]
        [ Card.block <|
            Html.div []
                [ Html.h1 [] [ text "Title" ] ]
        , Card.block <|
            Html.div []
                [ Html.p [] [ text "Lorem ipsum…" ] ]
        ]

-}
primaryAction : List (Html.Attribute msg) -> List (Block msg) -> List (Block msg)
primaryAction additionalAttributes blocks =
    [ Block <|
        Html.div
            (List.filterMap identity [ primaryActionCs ]
                ++ additionalAttributes
            )
            (List.map (\(Block html) -> html) blocks)
    ]


primaryActionCs : Maybe (Html.Attribute msg)
primaryActionCs =
    Just (class "mdc-card__primary-action")


{-| Card actions type
-}
type Actions msg
    = Actions
        { buttons : List (Button msg)
        , icons : List (Icon msg)
        , fullBleed : Bool
        }


{-| Card actions

A card may contain as actions buttons as well as icons.

-}
actions : { buttons : List (Button msg), icons : List (Icon msg) } -> Actions msg
actions { buttons, icons } =
    Actions { buttons = buttons, icons = icons, fullBleed = False }


{-| Card full bleed action

If a card's action is comprised of a single button, that button can be made
full width by using `cardFullBleedActions`.

    fullBleedActions
        (Card.actionButton Button.config "Visit")

-}
fullBleedActions : Button msg -> Actions msg
fullBleedActions button =
    Actions { buttons = [ button ], icons = [], fullBleed = True }


{-| Card action's button type
-}
type Button msg
    = Button (Html msg)


{-| A card action button

    cardActionButton buttonConfig "Visit"

-}
actionButton : Button.Config msg -> String -> Button msg
actionButton (Material.Button.Internal.Config buttonConfig) label =
    Button <|
        Button.text
            (Material.Button.Internal.Config
                { buttonConfig
                    | additionalAttributes =
                        class "mdc-card__action"
                            :: class "mdc-card__action--button"
                            :: buttonConfig.additionalAttributes
                }
            )
            label


type Icon msg
    = Icon (Html msg)


{-| Card action icon

    cardActionIcon iconButtonConfig "favorite"

-}
actionIcon : IconButton.Config msg -> String -> Icon msg
actionIcon (Material.IconButton.Internal.Config iconButtonConfig) iconName =
    Icon <|
        IconButton.iconButton
            (Material.IconButton.Internal.Config
                { iconButtonConfig
                    | additionalAttributes =
                        class "mdc-card__action"
                            :: class "mdc-card__action--icon"
                            :: iconButtonConfig.additionalAttributes
                }
            )
            iconName
