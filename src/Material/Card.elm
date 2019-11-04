module Material.Card exposing
    ( card, cardConfig, CardConfig, CardContent
    , CardBlock
    , cardBlock
    , cardMedia, cardMediaConfig, CardMediaConfig, CardMediaAspect(..)
    , cardPrimaryActionConfig, cardPrimaryAction
    , cardActions, CardActions, cardActionButton, cardActionIcon
    , cardFullBleedActions
    )

{-| Cards contain content and actions about a single subject.


# Table of Contents

  - [Resources](#resources)
  - [Basic Usage](#basic-usage)
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
    import Material.Button exposing (buttonConfig)
    import Material.Card
        exposing
            ( card
            , cardActionButton
            , cardActionIcon
            , cardActions
            , cardBlock
            , cardConfig
            )
    import Material.IconButton exposing (iconButtonConfig)

    main =
        card cardConfig
            { blocks =
                [ cardBlock <|
                    Html.div []
                        [ Html.h2 [] [ text "Title" ]
                        , Html.h3 [] [ text "Subtitle" ]
                        ]
                , cardBlock <|
                    Html.div []
                        [ Html.p [] [ text "Lorem ipsum…" ] ]
                ]
            , actions =
                Just <|
                    cardActions
                        { buttons =
                            [ cardActionButton buttonConfig
                                "Visit"
                            ]
                        , icons =
                            [ cardActionIcon iconButtonConfig
                                "favorite"
                            ]
                        }
            }


# Card

@docs card, cardConfig, CardConfig, CardContent


## Outlined Card

A card may have a border by settings its `outlined` configuration field to
`True`.

    card { cardConfig | outlined = True }
        { blocks =
            [ cardBlock <|
                Html.div [] [ Html.h1 [] [ text "Card" ] ]
            ]
        , actions = Nothing
        }


# Card Blocks

A card's content is primary comprised of blocks. Blocks may be comprised of
arbitrary HTML (generic `cardBlock`) or a media element (`cardMedia`).
Optionally, a group of card blocks can be marked as the card's primary action
which makes the group of card blocks interactable.

@docs CardBlock


## Generic Block

Generic card blocks are the most common and allow you to specify card content
using arbitrary HTML. Note that you will have to carefully adjust styling such
as padding and typography yourself.

    cardBlock <|
        Html.div []
            [ Html.h2 [] [ text "Title" ]
            , Html.h3 [] [ text "Subtitle" ]
            ]

@docs cardBlock


## Media Block

Card may contain a media block usually as the first content block. The media
will be displayed using a background image, and you may chose from square or a
16 to 9 aspect ratio.

@docs cardMedia, cardMediaConfig, CardMediaConfig, CardMediaAspect


## Primary Action Block

A group of card blocks can be marked as the primary action of the card. A
primary action block may be clicked upon and displays a visual interaction
effect.

    cardPrimaryAction
        { cardPrimaryActionConfig
            | onClick = Just CardClicked
        }
        [ cardBlock <|
            Html.h2 [] [ text "Title" ]
        , cardBlock <|
            Html.p [] [ text "Lorem ipsum…" ]
        ]

@docs cardPrimaryActionConfig, cardPrimaryAction


# Card Actions

Card actions are comprised of buttons and icons. These are exposed as variants
to the standard buttons and icons, but they do share the same configuration.

    cardActions
        { buttons =
            [ cardActionButton buttonConfig "View" ]
        , actions =
            [ cardActionIcon iconButtonConfig "favorite" ]
        }

@docs cardActions, CardActions, cardActionButton, cardActionIcon


## Card Full Bleed Actions

While a card's action buttons are usually left-aligned, a special case exists
when there is only a single button as card action.

@docs cardFullBleedActions

-}

import Html exposing (Html, text)
import Html.Attributes exposing (class)
import Html.Events
import Material.Button exposing (ButtonConfig, buttonConfig)
import Material.IconButton exposing (IconButtonConfig, iconButton)


{-| Configuration of a card
-}
type alias CardConfig msg =
    { outlined : Bool
    , additionalAttributes : List (Html.Attribute msg)
    }


{-| Card view function
-}
cardConfig : CardConfig msg
cardConfig =
    { outlined = False
    , additionalAttributes = []
    }


{-| Card view function
-}
card : CardConfig msg -> CardContent msg -> Html msg
card config content =
    Html.node "mdc-card"
        (List.filterMap identity
            [ rootCs
            , outlinedCs config
            ]
            ++ config.additionalAttributes
        )
        (List.concat
            [ blocksElt content
            , actionsElt content
            ]
        )


blocksElt : CardContent msg -> List (Html msg)
blocksElt { blocks } =
    List.map (\(Block html) -> html) blocks


actionsElt : CardContent msg -> List (Html msg)
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


outlinedCs : CardConfig msg -> Maybe (Html.Attribute msg)
outlinedCs { outlined } =
    if outlined then
        Just (class "mdc-card--outlined")

    else
        Nothing


{-| The content of a card is comprised of _blocks_ and _actions_.
-}
type alias CardContent msg =
    { blocks : List (CardBlock msg)
    , actions : Maybe (CardActions msg)
    }


{-| Card's content block
-}
type CardBlock msg
    = Block (Html msg)


{-| An arbitrary card block

    cardBlock <|
        Html.div [] [ text "Lorem ipsum…" ]

-}
cardBlock : Html msg -> CardBlock msg
cardBlock =
    Block


{-| Configuration of a card's media block
-}
type alias CardMediaConfig msg =
    { aspect : Maybe CardMediaAspect
    , additionalAttributes : List (Html.Attribute msg)
    }


{-| Default configuration of a card's media block
-}
cardMediaConfig : CardMediaConfig msg
cardMediaConfig =
    { aspect = Nothing
    , additionalAttributes = []
    }


{-| Card media block's aspect ratio
-}
type CardMediaAspect
    = Square
    | SixteenToNine


{-| Card media block view function

    cardMedia cardMediaConfig "media-image.jpg"

-}
cardMedia : CardMediaConfig msg -> String -> CardBlock msg
cardMedia config backgroundImage =
    Block <|
        Html.div
            (List.filterMap identity
                [ mediaCs
                , backgroundImageAttr backgroundImage
                , aspectCs config
                ]
                ++ config.additionalAttributes
            )
            []


mediaCs : Maybe (Html.Attribute msg)
mediaCs =
    Just (class "mdc-card__media")


backgroundImageAttr : String -> Maybe (Html.Attribute msg)
backgroundImageAttr url =
    Just (Html.Attributes.style "background-image" ("url(\"" ++ url ++ "\")"))


aspectCs : CardMediaConfig msg -> Maybe (Html.Attribute msg)
aspectCs { aspect } =
    case aspect of
        Just Square ->
            Just (class "mdc-card__media--square")

        Just SixteenToNine ->
            Just (class "mdc-card__media--16-9")

        Nothing ->
            Nothing


{-| Configuration of a card's primary action block
-}
type alias PrimaryActionConfig msg =
    { additionalAttributes : List (Html.Attribute msg)
    , onClick : Maybe msg
    }


{-| Default configuration of a card's primary action block
-}
cardPrimaryActionConfig : PrimaryActionConfig msg
cardPrimaryActionConfig =
    { additionalAttributes = []
    , onClick = Nothing
    }


{-| A card's primary action block

    cardPrimaryAction
        { cardPrimaryActionConfig
            | onClick = Just CardClicked
        }
        [ cardBlock <|
            Html.div []
                [ Html.h1 [] [ text "Title" ] ]
        , cardBlock <|
            Html.div []
                [ Html.p [] [ text "Lorem ipsum…" ] ]
        ]

-}
cardPrimaryAction : PrimaryActionConfig msg -> List (CardBlock msg) -> List (CardBlock msg)
cardPrimaryAction config blocks =
    [ Block <|
        Html.div
            (List.filterMap identity
                [ primaryActionCs
                , primaryActionClickHandler config
                ]
                ++ config.additionalAttributes
            )
            (List.map (\(Block html) -> html) blocks)
    ]


primaryActionCs : Maybe (Html.Attribute msg)
primaryActionCs =
    Just (class "mdc-card__primary-action")


primaryActionClickHandler : PrimaryActionConfig msg -> Maybe (Html.Attribute msg)
primaryActionClickHandler { onClick } =
    Maybe.map Html.Events.onClick onClick


{-| Card actions type
-}
type CardActions msg
    = Actions
        { buttons : List (Button msg)
        , icons : List (Icon msg)
        , fullBleed : Bool
        }


{-| Card actions

A card may contain as actions buttons as well as icons.

-}
cardActions : { buttons : List (Button msg), icons : List (Icon msg) } -> CardActions msg
cardActions { buttons, icons } =
    Actions { buttons = buttons, icons = icons, fullBleed = False }


{-| Card full bleed action

If a card's action is comprised of a single button, that button can be made
full width by using `cardFullBleedActions`.

    cardFullBleedActions
        (cardActionButton buttonConfig [ text "Visit" ])

-}
cardFullBleedActions : Button msg -> CardActions msg
cardFullBleedActions button =
    Actions { buttons = [ button ], icons = [], fullBleed = True }


{-| Card action's button type
-}
type Button msg
    = Button (Html msg)


{-| A card action button

    cardActionButton buttonConfig "Visit"

-}
cardActionButton : ButtonConfig msg -> String -> Button msg
cardActionButton buttonConfig label =
    Button <|
        Material.Button.textButton
            { buttonConfig
                | additionalAttributes =
                    class "mdc-card__action"
                        :: class "mdc-card__action--button"
                        :: buttonConfig.additionalAttributes
            }
            label


type Icon msg
    = Icon (Html msg)


{-| Card action icon

    cardActionIcon iconButtonConfig "favorite"

-}
cardActionIcon : IconButtonConfig msg -> String -> Icon msg
cardActionIcon iconButtonConfig iconName =
    Icon <|
        Material.IconButton.iconButton
            { iconButtonConfig
                | additionalAttributes =
                    class "mdc-card__action"
                        :: class "mdc-card__action--icon"
                        :: iconButtonConfig.additionalAttributes
            }
            iconName
