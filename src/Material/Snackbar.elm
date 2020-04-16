module Material.Snackbar exposing
    ( Config, config
    , setCloseOnEscape
    , setAttributes
    , snackbar
    , Queue, initialQueue, Msg, update
    , addMessage
    , message, Message
    , setLabel
    , setActionButton
    , setOnActionButtonClick
    , setActionIcon
    , setOnActionIconClick
    , setLeading
    , setStacked
    , setTimeoutMs
    )

{-| Snackbars provide brief messages about app processes at the bottom of the
screen.


# Table of Contents

  - [Resources](#resources)
  - [Basic Usage](#basic-usage)
  - [Configuration](#configuration)
      - [Configuration Options](#configuration-options)
  - [Snackbar](#snackbar)
  - [Queue](#queue)
      - [Adding Messages](#adding-messages)
  - [Messages](#messages)


# Resources

  - [Demo: Snackbars](https://aforemny.github.io/material-components-web-elm/#snackbar)
  - [Material Design Guidelines: Snackbars](https://material.io/go/design-snackbar)
  - [MDC Web: Snackbar](https://github.com/material-components/material-components-web/tree/master/packages/mdc-snackbar)
  - [Sass Mixins (MDC Web)](https://github.com/material-components/material-components-web/tree/master/packages/mdc-snackbar#sass-mixins)


# Basic Usage

    import Material.Snackbar as Snackbar

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
        Snackbar.snackbar SnackbarMsg Snackbar.config model.queue


# Configuration

@docs Config, config


## Configuration Options

@docs setCloseOnEscape
@docs setAttributes


# Snackbar

@docs snackbar


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
                        (\newQueue -> { model | queue = newQueue })

Now you are ready to call `addMessage` from your application update function.

@docs Queue, initialQueue, Msg, update


## Adding Messages

Note that `addMessage` takes `SnackbarMsg` as first parameter.

    update : Msg -> ( Model, Cmd Msg )
    update msg model =
        SomethingHappened ->
            let
                message =
                  Snackbar.message
                      |> Snackbar.setLabel "Something happened"
            in
            ( model, addMessage SnackbarMsg message )

@docs addMessage


# Messages

At the minimum, a message contains only a label. To specify the label, set the
`label` configuration field to a `String`.

    Snackbar.message
        |> Snackbar.addLabel "Something happened"

@docs message, Message

@docs setLabel
@docs setActionButton
@docs setOnActionButtonClick
@docs setActionIcon
@docs setOnActionIconClick
@docs setLeading
@docs setStacked
@docs setTimeoutMs


## Message with action button

Messages may contain an action button that the user can click. To display an
action button, set the message's `actionButton` configuration field to a
`String`, and handle the event in `onActionButtonClick`.

    Snackbar.message
        |> Snackbar.setLabel "Something happened"
        |> Snackbar.setActionButton "Take action"
        |> Snackbar.setOnActionButtonClick ActionButtonClicked


## Message with action icon

Messages may contain an action icon that the user can click. To display an
action icon, set the message's `actionIcon` configuration field to a
`String`, and handle the event in `onActionIconClick`.

    Snackbar.message
        |> Snackbar.setLabel "Something happened"
        |> Snackbar.setActionIcon "close"
        |> Snackbar.setOnActionIconClick Dismissed


## Stacked messages

Messages with a long label and action button should display the action button
below the label. To archieve this, set the message's `stacked` configuration
field to `True`.

    Snackbar.message
        |> Snackbar.setLabel "Something happened"
        |> Snackbar.setActionButton "Take action"
        |> Snackbar.setStacked True


## Leading messages

Messages are by default centered within the viewport. On larger screens, they
can optionally be displyed on the _leading_ edge of the screen. To display a
message as leading, set its `leading` configuration field to `True`.

    Snackbar.message
        |> Snackbar.setLabel "Something happened"
        |> Snackbar.setLeading


## Custom timeout

To set a custom timeout for a message, set its `timeoutMs` configuration field
to a `Float`, representing the on-screen time in milliseconds.

    Snackbar.message
        |> Snackbar.setLabel "Something happened"
        |> Snackbar.setTimeoutMs 5000

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
        AddMessage message_ ->
            let
                nextMessageId =
                    if List.isEmpty queue.messages then
                        queue.messageId + 1

                    else
                        queue.messageId
            in
            ( { queue
                | messages = queue.messages ++ [ message_ ]
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
addMessage lift message_ =
    Task.perform lift (Task.succeed (AddMessage message_))


{-| Configuration of a snackbar
-}
type Config msg
    = Config
        { closeOnEscape : Bool
        , additionalAttributes : List (Html.Attribute msg)
        }


{-| Default configuration of a snackbar
-}
config : Config msg
config =
    Config
        { closeOnEscape = False
        , additionalAttributes = []
        }


{-| Set the snackbar to close the current message when the user presses escape
-}
setCloseOnEscape : Bool -> Config msg -> Config msg
setCloseOnEscape closeOnEscape (Config config_) =
    Config { config_ | closeOnEscape = closeOnEscape }


{-| Specify additional attributes
-}
setAttributes : List (Html.Attribute msg) -> Config msg -> Config msg
setAttributes additionalAttributes (Config config_) =
    Config { config_ | additionalAttributes = additionalAttributes }


{-| Snackbar view function
-}
snackbar : (Msg msg -> msg) -> Config msg -> Queue msg -> Html msg
snackbar lift ((Config { additionalAttributes }) as config_) queue =
    let
        message_ =
            Maybe.withDefault message (List.head queue.messages)
    in
    Html.node "mdc-snackbar"
        (List.filterMap identity
            [ rootCs
            , closeOnEscapeProp config_
            , leadingCs message
            , stackedCs message
            , messageIdProp queue
            , timeoutMsProp message
            , closedHandler lift
            ]
            ++ additionalAttributes
        )
        [ surfaceElt message ]


{-| Snackbar message
-}
type Message msg
    = Message
        { label : String
        , actionButton : Maybe String
        , onActionButtonClick : Maybe msg
        , actionIcon : Maybe String
        , onActionIconClick : Maybe msg
        , leading : Bool
        , stacked : Bool
        , timeoutMs : Int
        }


{-| Set a message's label
-}
setLabel : String -> Message msg -> Message msg
setLabel label (Message message_) =
    Message { message_ | label = label }


{-| Set a message's action button
-}
setActionButton : String -> Message msg -> Message msg
setActionButton actionButton (Message message_) =
    Message { message_ | actionButton = Just actionButton }


{-| Specify a message when the user clicks on a message's action button
-}
setOnActionButtonClick : msg -> Message msg -> Message msg
setOnActionButtonClick onActionButtonClick (Message message_) =
    Message { message_ | onActionButtonClick = Just onActionButtonClick }


{-| Set a message's action icon
-}
setActionIcon : String -> Message msg -> Message msg
setActionIcon actionIcon (Message message_) =
    Message { message_ | actionIcon = Just actionIcon }


{-| Specify a message when the user clicks on a message's action icon
-}
setOnActionIconClick : msg -> Message msg -> Message msg
setOnActionIconClick onActionIconClick (Message message_) =
    Message { message_ | onActionIconClick = Just onActionIconClick }


{-| Set a message to be leading
-}
setLeading : Message msg -> Message msg
setLeading (Message message_) =
    Message { message_ | leading = True }


{-| Set a message to be stacked
-}
setStacked : Bool -> Message msg -> Message msg
setStacked stacked (Message message_) =
    Message { message_ | stacked = stacked }


{-| Set a message's timeout in milliseconds
-}
setTimeoutMs : Int -> Message msg -> Message msg
setTimeoutMs timeoutMs (Message message_) =
    Message { message_ | timeoutMs = timeoutMs }


{-| Default snackbar message (empty label)
-}
message : Message msg
message =
    Message
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


closeOnEscapeProp : Config msg -> Maybe (Html.Attribute msg)
closeOnEscapeProp (Config { closeOnEscape }) =
    Just (Html.Attributes.property "closeOnEscape" (Encode.bool closeOnEscape))


leadingCs : Message msg -> Maybe (Html.Attribute msg)
leadingCs (Message { leading }) =
    if leading then
        Just (class "mdc-snackbar--leading")

    else
        Nothing


stackedCs : Message msg -> Maybe (Html.Attribute msg)
stackedCs (Message { stacked }) =
    if stacked then
        Just (class "mdc-snackbar--stacked")

    else
        Nothing


messageIdProp : Queue msg -> Maybe (Html.Attribute msg)
messageIdProp { messageId } =
    Just (Html.Attributes.property "messageId" (Encode.int messageId))


timeoutMsProp : Message msg -> Maybe (Html.Attribute msg)
timeoutMsProp (Message { timeoutMs }) =
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
surfaceElt message_ =
    Html.div [ class "mdc-snackbar__surface" ]
        [ labelElt message_
        , actionsElt message_
        ]


labelElt : Message msg -> Html msg
labelElt (Message { label }) =
    Html.div [ class "mdc-snackbar__label", ariaStatusRoleAttr, ariaPoliteLiveAttr ]
        [ text label ]


actionsElt : Message msg -> Html msg
actionsElt message_ =
    Html.div [ class "mdc-snackbar__actions" ]
        (List.filterMap identity
            [ actionButtonElt message_
            , actionIconElt message_
            ]
        )


actionButtonElt : Message msg -> Maybe (Html msg)
actionButtonElt ((Message { actionButton }) as message_) =
    Maybe.map
        (\actionButtonLabel ->
            Html.button
                (List.filterMap identity
                    [ actionButtonCs
                    , actionButtonClickHandler message_
                    ]
                )
                [ text actionButtonLabel ]
        )
        actionButton


actionButtonCs : Maybe (Html.Attribute msg)
actionButtonCs =
    Just (class "mdc-button mdc-snackbar__action")


actionButtonClickHandler : Message msg -> Maybe (Html.Attribute msg)
actionButtonClickHandler (Message { onActionButtonClick }) =
    Maybe.map Html.Events.onClick onActionButtonClick


actionIconElt : Message msg -> Maybe (Html msg)
actionIconElt ((Message { actionIcon }) as message_) =
    Maybe.map
        (\actionIconLabel ->
            Html.i
                (List.filterMap identity
                    [ actionIconCs
                    , actionIconClickHandler message_
                    ]
                )
                [ text actionIconLabel ]
        )
        actionIcon


actionIconCs : Maybe (Html.Attribute msg)
actionIconCs =
    Just (class "mdc-icon-button mdc-snackbar__dismiss material-icons")


actionIconClickHandler : Message msg -> Maybe (Html.Attribute msg)
actionIconClickHandler (Message { onActionIconClick }) =
    Maybe.map Html.Events.onClick onActionIconClick
