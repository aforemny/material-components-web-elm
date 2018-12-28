module Material.Card exposing (Config, card, cardConfig)

import Html exposing (Html, text)
import Html.Attributes exposing (class)
import Html.Events
import Material.Button exposing (buttonConfig)
import Material.Icon exposing (iconConfig)


type alias Config msg =
    { outlined : Bool
    , additionalAttributes : List (Html.Attribute msg)
    }


cardConfig : Config msg
cardConfig =
    { outlined = False
    , additionalAttributes = []
    }


card : Config msg -> Content msg -> Html msg
card config content =
    Html.div
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
                            (List.map (\(Icon icon) -> icon) icons)
                        ]

                      else
                        []
                    , if not (List.isEmpty icons) then
                        [ Html.div [ class "mdc-card__action-icons" ]
                            (List.map (\(Button button) -> button) buttons)
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
outlinedCs { outlined } =
    if outlined then
        Just (class "mdc-card--outlined")

    else
        Nothing


type alias Content msg =
    { blocks : List (Block msg)
    , actions : Maybe (Actions msg)
    }


type Block msg
    = Block (Html msg)


type alias MediaConfig msg =
    { aspect : Maybe Aspect
    , additionalAttributes : List (Html.Attribute msg)
    }


mediaConfig : MediaConfig msg
mediaConfig =
    { aspect = Nothing
    , additionalAttributes = []
    }


type Aspect
    = Square
    | SixteenToNine


media : MediaConfig msg -> String -> Block msg
media config backgroundImage =
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


aspectCs : MediaConfig msg -> Maybe (Html.Attribute msg)
aspectCs { aspect } =
    case aspect of
        Just Square ->
            Just (class "mdc-card__media--square")

        Just SixteenToNine ->
            Just (class "mdc-card__media--16-9")

        Nothing ->
            Nothing


type alias PrimaryActionConfig msg =
    { onClick : Maybe msg
    , additionalAttributes : List (Html.Attribute msg)
    }


primaryActionConfig : PrimaryActionConfig msg
primaryActionConfig =
    { onClick = Nothing
    , additionalAttributes = []
    }


primaryAction : PrimaryActionConfig msg -> List (Block msg) -> List (Block msg)
primaryAction config blocks =
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


type Actions msg
    = Actions
        { buttons : List (Button msg)
        , icons : List (Icon msg)
        , fullBleed : Bool
        }


actions : { buttons : List (Button msg), icons : List (Icon msg) } -> Actions msg
actions { buttons, icons } =
    Actions { buttons = buttons, icons = icons, fullBleed = False }


fullBleedActions : Button msg -> Actions msg
fullBleedActions button =
    Actions { buttons = [ button ], icons = [], fullBleed = True }


type Button msg
    = Button (Html msg)


actionButton : Material.Button.Config msg -> String -> Button msg
actionButton buttonConfig label =
    Button <|
        Material.Button.button
            { buttonConfig
                | additionalAttributes =
                    class "mdc-card__action"
                        :: class "mdc-card__action--button"
                        :: buttonConfig.additionalAttributes
            }
            label


type Icon msg
    = Icon (Html msg)


actionIcon : Material.Icon.Config msg -> String -> Icon msg
actionIcon iconConfig iconName =
    Icon <|
        Material.Icon.icon
            { iconConfig
                | additionalAttributes =
                    class "mdc-card__action"
                        :: class "mdc-card__action--icon"
                        :: iconConfig.additionalAttributes
            }
            iconName
