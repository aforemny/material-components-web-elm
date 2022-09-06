module Material.Card exposing
    ( Config, config
    , setOutlined
    , setOnClick
    , setHref, setTarget
    , setAttributes
    , card, Content
    , Block
    , block
    , squareMedia, sixteenToNineMedia, media
    , Actions, actions
    , Button, button
    , Icon, icon
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
  - [Link Card](#link-card)
  - [Focus a Card](#focus-a-card)


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
                            [ Card.button Button.config "Visit" ]
                        , icons =
                            [ Card.icon IconButton.config
                                (IconButton.icon "favorite")
                            ]
                        }
            }


# Configuration

@docs Config, config


## Configuration Options

@docs setOutlined
@docs setOnClick
@docs setHref, setTarget
@docs setAttributes


# Card

@docs card, Content


## Outlined Card

A card may display a border by setting its `setOutlined` configuration option
to `True`.

    Card.card
        (Card.config |> Card.setOutlined True)
        { blocks =
            [ Card.block <|
                Html.div [] [ Html.h1 [] [ text "Card" ] ]
            ]
        , actions = Nothing
        }


# Card Blocks

A card's primary content is comprised of _blocks_. Blocks may be comprised of
arbitrary HTML or a media element.

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

Cards may contain a media block usually as the first content block. The media
will be displayed using a background image, and you may chose from square or a
16 to 9 aspect ratio.

@docs squareMedia, sixteenToNineMedia, media


# Card Actions

Card actions are comprised of buttons and icons. These are exposed as variants
to the standard buttons and icons, but they do share the same configuration.

    Card.actions
        { buttons =
            [ Card.button Button.config "View" ]
        , icons =
            [ Card.icon IconButton.config
                (IconButton.icon "favorite")
            ]
        }

@docs Actions, actions
@docs Button, button
@docs Icon, icon


## Card Full Bleed Actions

While a card's action buttons are usually left-aligned, a special case exists
when there is only a single button as card action.

@docs fullBleedActions


# Link Card

To make a button essentially behave like a HTML anchor element, use its
`setHref` configuration option. You may use its `setTarget` configuration
option to specify a target.

    Card.card
        (Card.config
            |> Card.setHref (Just "#")
            |> Card.setTarget (Just "_blank")
        )
        { blocks = []
        , actions = Nothing
        }


# Focus a Card

You may programatically focus a card by assigning an id attribute to it and use
`Browser.Dom.focus`.

Note that cards must have a primary action element to be focusable.

    Card.card
        (Card.config
            |> Card.setAttributes
                [ Html.Attributes.id "my-card" ]
        )
        { blocks = []
        , actions = Nothing
        }

-}

import Html exposing (Html)
import Html.Attributes exposing (class, style)
import Html.Events
import Json.Encode as Encode
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
        , href : Maybe String
        , target : Maybe String
        , onClick : Maybe msg
        }


{-| Default configuration of a card
-}
config : Config msg
config =
    Config
        { outlined = False
        , additionalAttributes = []
        , href = Nothing
        , target = Nothing
        , onClick = Nothing
        }


{-| Specify whether a card should have a visual outline
-}
setOutlined : Bool -> Config msg -> Config msg
setOutlined outlined (Config config_) =
    Config { config_ | outlined = outlined }


{-| Specify a message when the user clicks a card
-}
setOnClick : msg -> Config msg -> Config msg
setOnClick onClick (Config config_) =
    Config { config_ | onClick = Just onClick }


{-| Specify whether a card is a _link card_.

Link cards' primary action behave like normal HTML5 anchor tags

-}
setHref : Maybe String -> Config msg -> Config msg
setHref href (Config config_) =
    Config { config_ | href = href }


{-| Specify the target for a link card.

Note that this configuration option will be ignored by cards that do not also
set `setHref`.

-}
setTarget : Maybe String -> Config msg -> Config msg
setTarget target (Config config_) =
    Config { config_ | target = target }


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
            [ blocksElt config_ content
            , actionsElt content
            ]
        )


blocksElt : Config msg -> Content msg -> List (Html msg)
blocksElt ((Config { onClick, href }) as config_) { blocks } =
    List.map (\(Block html) -> html)
        ((if onClick /= Nothing || href /= Nothing then
            primaryAction config_

          else
            identity
         )
            blocks
        )


clickHandler : Config msg -> Maybe (Html.Attribute msg)
clickHandler (Config { onClick }) =
    Maybe.map Html.Events.onClick onClick


hrefAttr : Config msg -> Maybe (Html.Attribute msg)
hrefAttr (Config { href }) =
    Maybe.map Html.Attributes.href href


targetAttr : Config msg -> Maybe (Html.Attribute msg)
targetAttr (Config { target }) =
    Maybe.map Html.Attributes.target target


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
                            (List.map (\(Button button_) -> button_) buttons)
                        ]

                      else
                        []
                    , if not (List.isEmpty icons) then
                        [ Html.div [ class "mdc-card__action-icons" ]
                            (List.map (\(Icon icon_) -> icon_) icons)
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


{-| A card's content block
-}
type Block msg
    = Block (Html msg)


{-| Card block containing arbitrary HTML

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
-}
primaryAction : Config msg -> List (Block msg) -> List (Block msg)
primaryAction ((Config { href }) as config_) blocks =
    [ Block <|
        (if href /= Nothing then
            Html.a

         else
            Html.div
        )
            (List.filterMap identity
                [ primaryActionCs
                , tabIndexProp 0
                , clickHandler config_
                , hrefAttr config_
                , targetAttr config_
                ]
            )
            (List.map (\(Block html) -> html) blocks)
    ]


primaryActionCs : Maybe (Html.Attribute msg)
primaryActionCs =
    Just (class "mdc-card__primary-action")


tabIndexProp : Int -> Maybe (Html.Attribute msg)
tabIndexProp tabIndex =
    Just (Html.Attributes.property "tabIndex" (Encode.int tabIndex))


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

    Card.fullBleedActions
        (Card.button Button.config "Visit")

-}
fullBleedActions : Button msg -> Actions msg
fullBleedActions button_ =
    Actions { buttons = [ button_ ], icons = [], fullBleed = True }


{-| Card action's button type
-}
type Button msg
    = Button (Html msg)


{-| A card action button

    Card.button Button.config "Visit"

-}
button : Button.Config msg -> String -> Button msg
button (Material.Button.Internal.Config buttonConfig) label =
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


{-| Card action's icon type
-}
type Icon msg
    = Icon (Html msg)


{-| Card action icon

    Card.icon IconButton.config
        (IconButton.icon "favorite")

-}
icon : IconButton.Config msg -> IconButton.Icon -> Icon msg
icon (Material.IconButton.Internal.Config iconButtonConfig) icon_ =
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
            icon_
