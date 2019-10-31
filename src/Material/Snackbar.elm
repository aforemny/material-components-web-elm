module Material.Snackbar exposing
    ( snackbar, snackbarConfig, SnackbarConfig
    , Queue, initialQueue, Msg, update
    , addMessage
    , snackbarMessage, Message
    )

{-| Snackbars provide brief messages about app processes at the bottom of the
screen.


# Table of Contents

  - [Resources](#resources)
  - [Basic Usage](#basic-usage)
  - [Snackbar](#snackbar)
  - [Queue](#queue)
      - [Adding Messages](#adding-messages)
  - [Messages](#messages)


# Resources

  - [Demo: Snackbars](https://aforemny.github.io/material-components-web-elm/#snackbars)
  - [Material Design Guidelines: Snackbars](https://material.io/go/design-snackbar)
  - [MDC Web: Snackbar](https://github.com/material-components/material-components-web/tree/master/packages/mdc-snackbar)
  - [Sass Mixins (MDC Web)](https://github.com/material-components/material-components-web/tree/master/packages/mdc-snackbar#sass-mixins)


# Basic Usage

    import Material.Snackbar as Snackbar
        exposing
            ( snackbar
            , snackbarConfig
            )

    type alias Model =
        { queue : Snackbar.Queue }

    type Msg
        = SnackbarMsg Snackbar.Msg

    update : Msg -> Model -> ( Model, Cmd Msg )
    update msg model =
        case msg of
            SnackbarMsg snackbarMsg ->
                let
                    ( newQueue, cmd ) =
                        Snackbar.update SnackbarMsg
                            snackbarMsg
                            model.queue
                in
                ( { model | queue = newQueue }, cmd )

    main =
        snackbar SnackbarMsg snackbarConfig model.queue


# Snackbar

@docs snackbar, snackbarConfig, SnackbarConfig


# Queue

You will have to maintain a queue of snackbar messages inside your
application's model. To do so, add a field `queue : Queue` and initialize it to
`initialQueue`.

    type alias Model =
        { queue : Snackbar.Queue }

    initialModel =
        { queue = Snackbar.initialQueue }

To add messages to the queue, you have to tag `Snackbar.Msg`s within your
application's `Msg` type.

    type Msg
        = SnackbarMsg Snackbar.Msg

Then from your application's update function, call `update` to handle
`Snackbar.Msg`. Note that the first argument to `update` is `SnackbarMsg`.

    update msg model =
        case msg of
            SnackbarMsg snackbarMsg ->
                Snackbar.update SnackbarMsg snackbarMsg model
                    |> Tuple.mapFirst
                        (\newQueue ->
                            { model | queue = newQueue }
                        )

Now you are ready to call `addMessage` from your application update function.

@docs Queue, initialQueue, Msg, update


## Adding Messages

Note that `addMessage` takes `SnackbarMsg` as first parameter.

    update : Msg -> ( Model, Cmd Msg )
    update msg model =
        SomethingHappened ->
            let
                message =
                    { snackbarMessage
                        | label = "Something happened"
                    }
            in
            ( model, addMessage SnackbarMsg message )

@docs addMessage


# Messages

At the minimum, a message contains only a label. To specify the label, set the
`label` configuration field to a `String`.

    { snackbarMessage | label = "Something happened" }

@docs snackbarMessage, Message


## Message with action button

Messages may contain an action button that the user can click. To display an
action button, set the message's `actionButton` configuration field to a
`String`, and handle the event in `onActionButtonClick`.

    { snackbarMessage
        | label = "Something happened"
        , actionButton = Just "Take action"
        , onActionButtonClick = Just ActionButtonClicked
    }


## Message with action icon

Messages may contain an action icon that the user can click. To display an
action icon, set the message's `actionIcon` configuration field to a
`String`, and handle the event in `onActionIconClick`.

    { snackbarMessage
        | label = "Something happened"
        , actionIcon = Just "close"
        , onActionIconClick = Just Dismissed
    }


## Stacked messages

Messages with a long label and action button should display the action button
below the label. To archieve this, set the message's `stacked` configuration
field to `True`.

    { snackbarMessage
        | label = "Something happened"
        , actionButton = Just "Take action"
        , stacked = True
    }


## Leading messages

Messages are by default centered within the viewport. On larger screens, they
can optionally be displyed on the _leading_ edge of the screen. To display a
message as leading, set its `leading` configuration field to `True`.

    { snackbarMessage
        | label = "Something happened"
        , leading = True
    }


## Custom timeout

To set a custom timeout for a message, set its `timeoutMs` configuration field
to a `Float`, representing the on-screen time in milliseconds.

    { snackbarMessage
        | label = "Something happened"
        , timeoutMs = 5000
    }

-}

import Html exposing (Html, text)
import Html.Attributes exposing (class)
import Html.Events
import Json.Decode as Decode
import Json.Encode as Encode
import Process
import Task


{-| Queue of messages
-}
type alias Queue msg =
    { messages : List (Message msg)
    , messageId : MessageId
    }


type alias MessageId =
    Int


{-| Initial empty queue
-}
initialQueue : Queue msg
initialQueue =
    { messages = []
    , messageId = 0
    }


{-| Queue update function
-}
update : (Msg msg -> msg) -> Msg msg -> Queue msg -> ( Queue msg, Cmd msg )
update lift msg queue =
    case msg of
        AddMessage message ->
            let
                nextMessageId =
                    if List.isEmpty queue.messages then
                        queue.messageId + 1

                    else
                        queue.messageId
            in
            ( { queue
                | messages = queue.messages ++ [ message ]
                , messageId = nextMessageId
              }
            , Cmd.none
            )

        Close ->
            let
                messages =
                    List.drop 1 queue.messages

                nextMessageId =
                    if not (List.isEmpty messages) then
                        queue.messageId + 1

                    else
                        queue.messageId
            in
            ( { queue
                | messages = messages
                , messageId = nextMessageId
              }
            , Cmd.none
            )


{-| Snackbar message type
-}
type Msg msg
    = AddMessage (Message msg)
    | Close


{-| Adds a message to the queue
-}
addMessage : (Msg msg -> msg) -> Message msg -> Cmd msg
addMessage lift message =
    Task.perform lift (Task.succeed (AddMessage message))


{-| Configuration of a snackbar
-}
type alias SnackbarConfig msg =
    { closeOnEscape : Bool
    , additionalAttributes : List (Html.Attribute msg)
    }


{-| Default configuration of a snackbar
-}
snackbarConfig : SnackbarConfig msg
snackbarConfig =
    { closeOnEscape = False
    , additionalAttributes = []
    }


{-| Snackbar view function
-}
snackbar : (Msg msg -> msg) -> SnackbarConfig msg -> Queue msg -> Html msg
snackbar lift config queue =
    let
        message =
            Maybe.withDefault snackbarMessage (List.head queue.messages)
    in
    Html.node "mdc-snackbar"
        (List.filterMap identity
            [ rootCs
            , closeOnEscapeProp config
            , leadingCs message
            , stackedCs message
            , messageIdProp queue
            , timeoutMsProp message
            , closedHandler lift
            ]
            ++ config.additionalAttributes
        )
        [ surfaceElt message ]


{-| Snackbar message
-}
type alias Message msg =
    { label : String
    , actionButton : Maybe String
    , onActionButtonClick : Maybe msg
    , actionIcon : Maybe String
    , onActionIconClick : Maybe msg
    , leading : Bool
    , stacked : Bool
    , timeoutMs : Int
    }


{-| Default snackbar message (empty label)
-}
snackbarMessage : Message msg
snackbarMessage =
    { label = ""
    , actionButton = Nothing
    , onActionButtonClick = Nothing
    , actionIcon = Nothing
    , onActionIconClick = Nothing
    , leading = False
    , stacked = False
    , timeoutMs = 5000
    }


rootCs : Maybe (Html.Attribute msg)
rootCs =
    Just (class "mdc-snackbar")


closeOnEscapeProp : SnackbarConfig msg -> Maybe (Html.Attribute msg)
closeOnEscapeProp { closeOnEscape } =
    Just (Html.Attributes.property "closeOnEscape" (Encode.bool closeOnEscape))


leadingCs : Message msg -> Maybe (Html.Attribute msg)
leadingCs { leading } =
    if leading then
        Just (class "mdc-snackbar--leading")

    else
        Nothing


stackedCs : Message msg -> Maybe (Html.Attribute msg)
stackedCs { stacked } =
    if stacked then
        Just (class "mdc-snackbar--stacked")

    else
        Nothing


messageIdProp : Queue msg -> Maybe (Html.Attribute msg)
messageIdProp { messageId } =
    Just (Html.Attributes.property "messageId" (Encode.int messageId))


timeoutMsProp : Message msg -> Maybe (Html.Attribute msg)
timeoutMsProp { timeoutMs } =
    let
        normalizedTimeoutMs =
            clamp 4000 10000 timeoutMs
    in
    Just (Html.Attributes.property "timeoutMs" (Encode.int normalizedTimeoutMs))


closedHandler : (Msg msg -> msg) -> Maybe (Html.Attribute msg)
closedHandler lift =
    Just (Html.Events.on "MDCSnackbar:closed" (Decode.succeed (lift Close)))


ariaStatusRoleAttr : Html.Attribute msg
ariaStatusRoleAttr =
    Html.Attributes.attribute "aria-role" "status"


ariaPoliteLiveAttr : Html.Attribute msg
ariaPoliteLiveAttr =
    Html.Attributes.attribute "aria-live" "polite"


surfaceElt : Message msg -> Html msg
surfaceElt message =
    Html.div [ class "mdc-snackbar__surface" ]
        [ labelElt message
        , actionsElt message
        ]


labelElt : Message msg -> Html msg
labelElt { label } =
    Html.div [ class "mdc-snackbar__label", ariaStatusRoleAttr, ariaPoliteLiveAttr ]
        [ text label ]


actionsElt : Message msg -> Html msg
actionsElt message =
    Html.div [ class "mdc-snackbar__actions" ]
        (List.filterMap identity
            [ actionButtonElt message
            , actionIconElt message
            ]
        )


actionButtonElt : Message msg -> Maybe (Html msg)
actionButtonElt ({ actionButton } as message) =
    Maybe.map
        (\actionButtonLabel ->
            Html.button
                (List.filterMap identity
                    [ actionButtonCs
                    , actionButtonClickHandler message
                    ]
                )
                [ text actionButtonLabel ]
        )
        actionButton


actionButtonCs : Maybe (Html.Attribute msg)
actionButtonCs =
    Just (class "mdc-button mdc-snackbar__action")


actionButtonClickHandler : Message msg -> Maybe (Html.Attribute msg)
actionButtonClickHandler { onActionButtonClick } =
    Maybe.map Html.Events.onClick onActionButtonClick


actionIconElt : Message msg -> Maybe (Html msg)
actionIconElt ({ actionIcon } as message) =
    Maybe.map
        (\actionIconLabel ->
            Html.i
                (List.filterMap identity
                    [ actionIconCs
                    , actionIconClickHandler message
                    ]
                )
                [ text actionIconLabel ]
        )
        actionIcon


actionIconCs : Maybe (Html.Attribute msg)
actionIconCs =
    Just (class "mdc-icon-button mdc-snackbar__dismiss material-icons")


actionIconClickHandler : Message msg -> Maybe (Html.Attribute msg)
actionIconClickHandler { onActionIconClick } =
    Maybe.map Html.Events.onClick onActionIconClick
