module Material.Snackbar exposing
    ( Config, config
    , setCloseOnEscape
    , setAttributes
    , snackbar
    , Queue, initialQueue, MessageId, close
    , addMessage
    , message, Message
    , setActionButton
    , setOnActionButtonClick
    , setActionIcon
    , setOnActionIconClick
    , setLeading
    , setStacked
    , setTimeoutMs
    , Icon, icon
    , customIcon
    , svgIcon
    )

{-| Snackbars provide brief messages about the application's processes at the
bottom of the screen.


# Table of Contents

  - [Resources](#resources)
  - [Basic Usage](#basic-usage)
  - [Configuration](#configuration)
      - [Configuration Options](#configuration-options)
  - [Snackbar](#snackbar)
  - [Queue](#queue)
      - [Adding Messages](#adding-messages)
  - [Messages](#messages)
      - [Message with Action Icon](#message-with-action-icon)
      - [Stacked Messages](#stacked-messages)
      - [Leading Messages](#leading-messages)
      - [Custom Timeout](#custom-timeout)
      - [Message with Custom Icon](#message-with-custom-icon)


# Resources

  - [Demo: Snackbars](https://aforemny.github.io/material-components-web-elm/#snackbar)
  - [Material Design Guidelines: Snackbars](https://material.io/go/design-snackbar)
  - [MDC Web: Snackbar](https://github.com/material-components/material-components-web/tree/master/packages/mdc-snackbar)
  - [Sass Mixins (MDC Web)](https://github.com/material-components/material-components-web/tree/master/packages/mdc-snackbar#sass-mixins)


# Basic Usage

    import Browser
    import Material.Snackbar as Snackbar

    type alias Model =
        { queue : Snackbar.Queue Msg }

    type Msg
        = SnackbarClosed Snackbar.MessageId

    init =
        { queue = Snackbar.initialQueue }

    update msg model =
        case msg of
            SnackbarClosed messageId ->
                { model | queue = Snackbar.close messageId model.queue }

    view model =
        Snackbar.snackbar
            (Snackbar.config { onClosed = SnackbarClosed })
            model.queue

    main =
        Browser.sandbox
            { init = init, update = update, view = view }


# Configuration

@docs Config, config


## Configuration Options

@docs setCloseOnEscape
@docs setAttributes


# Snackbar

@docs snackbar


# Queue

You will have to maintain a queue of snackbar messages inside your
application's model. To do so, add a field `queue : Queue msg` and initialize
it to `initialQueue`.

    type alias Model =
        { queue : Snackbar.Queue Msg }

    initialModel =
        { queue = Snackbar.initialQueue }

    type Msg
        = SnackbarClosed Snackbar.MessageId

Then from your application's update function, call `update` to handle
`Snackbar.Msg`. Note that the first argument to `update` is `SnackbarMsg`.

    type Msg
        = SnackbarClosed Snackbar.MessageId

    update msg model =
        case msg of
            SnackbarClosed messageId ->
                { model | queue = Snackbar.close messageId model.queue }

Now you are ready to add messages from your application's update function.

@docs Queue, initialQueue, MessageId, close


## Adding Messages

    type Msg
        = SnackbarClosed Snackbar.MessageId
        | SomethingHappened

    update msg model =
        case msg of
            SomethingHappened ->
                let
                    message =
                        Snackbar.message "Something happened"

                    newQueue =
                        Snackbar.addMessage message model.queue
                in
                { model | queue = newQueue }

            SnackbarClosed messageId ->
                let
                    newQueue =
                        Snackbar.close messageId model.queue
                in
                { model | queue = newQueue }

@docs addMessage


# Messages

At the minimum, a message contains only a label.

    Snackbar.message "Something happened"

@docs message, Message

@docs setActionButton
@docs setOnActionButtonClick
@docs setActionIcon
@docs setOnActionIconClick
@docs setLeading
@docs setStacked
@docs setTimeoutMs


## Message with Action Button

Messages may contain an action button that the user can click. To display an
action button, set the message's `setActionButton` configuration option to a
string, and handle the event in `onActionButtonClick`.

    Snackbar.message "Something happened"
        |> Snackbar.setActionButton (Just "Take action")
        |> Snackbar.setOnActionButtonClick ActionButtonClicked


## Message with Action Icon

Messages may contain an action icon that the user can click. To display an
action icon, set the message's `setActionIcon` configuration option to a string
representing a Material Icon, and handle the event in `onActionIconClick`.

    Snackbar.message "Something happened"
        |> Snackbar.setActionIcon
            (Just (Snackbar.icon "close"))
        |> Snackbar.setOnActionIconClick Dismissed


## Stacked Messages

Messages with a long label and action button should display the action button
below the label. To archieve this, set the message's `setStacked` configuration
option to `True`.

    Snackbar.message "Something happened"
        |> Snackbar.setActionButton (Just "Take action")
        |> Snackbar.setStacked True


## Leading Messages

Messages are by default centered within the viewport. On larger screens, they
can optionally be displyed on the _leading_ edge of the screen. To display a
message as leading, set its `setLeading` configuration option to `True`.

    Snackbar.message "Something happened"
        |> Snackbar.setLeading True


## Custom Timeout

To set a custom timeout for a message, set its `setTimeoutMs` configuration
option to a floating point value, representing the on-screen time in
milliseconds.

This value must be between 4 and 10 seconds, and it defaults to 5 seconds. You
may specify an indefinite timeout by setting it to `Nothing`.

    Snackbar.message "Something happened"
        |> Snackbar.setTimeoutMs (Just 4000)


## Message with Custom Icon

This library natively supports [Material Icons](https://material.io/icons).
However, you may also include SVG or custom icons such as FontAwesome.

@docs Icon, icon
@docs customIcon
@docs svgIcon

-}

import Html exposing (Html, text)
import Html.Attributes exposing (class)
import Html.Events
import Json.Decode as Decode
import Json.Encode as Encode
import Svg exposing (Svg)


{-| Queue of messages
-}
type Queue msg
    = Queue
        { messages : List ( MessageId, Message msg )
        , nextMessageId : MessageId
        }


{-| Message identifier type
-}
type MessageId
    = MessageId Int


inc : MessageId -> MessageId
inc (MessageId messageId) =
    MessageId (messageId + 1)


{-| Initial empty queue
-}
initialQueue : Queue msg
initialQueue =
    Queue
        { messages = []
        , nextMessageId = MessageId 0
        }


{-| Hide the currently showing message
-}
close : MessageId -> Queue msg -> Queue msg
close messageId (Queue queue) =
    Queue <|
        { queue
            | messages =
                case queue.messages of
                    [] ->
                        []

                    ( currentMessageId, _ ) :: otherMessages ->
                        if currentMessageId == messageId then
                            otherMessages

                        else
                            queue.messages
        }


{-| Adds a message to the queue
-}
addMessage : Message msg -> Queue msg -> Queue msg
addMessage message_ (Queue queue) =
    Queue
        { queue
            | messages = queue.messages ++ [ ( queue.nextMessageId, message_ ) ]
            , nextMessageId = inc queue.nextMessageId
        }


{-| Configuration of a snackbar
-}
type Config msg
    = Config
        { closeOnEscape : Bool
        , additionalAttributes : List (Html.Attribute msg)
        , onClosed : MessageId -> msg
        }


{-| Default configuration of a snackbar
-}
config : { onClosed : MessageId -> msg } -> Config msg
config { onClosed } =
    Config
        { closeOnEscape = False
        , additionalAttributes = []
        , onClosed = onClosed
        }


{-| Specify whether the snackbar's messages should close when the user presses
escape
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
snackbar : Config msg -> Queue msg -> Html msg
snackbar ((Config { additionalAttributes }) as config_) ((Queue { messages, nextMessageId }) as queue) =
    let
        ( currentMessageId, currentMessage ) =
            List.head messages
                |> Maybe.map (Tuple.mapSecond Just)
                |> Maybe.withDefault ( MessageId -1, Nothing )
    in
    Html.node "mdc-snackbar"
        (List.filterMap identity
            [ rootCs
            , closeOnEscapeProp config_
            , leadingCs currentMessage
            , stackedCs currentMessage
            , messageIdProp currentMessageId
            , timeoutMsProp currentMessage
            , closedHandler currentMessageId config_
            ]
            ++ additionalAttributes
        )
        [ surfaceElt currentMessageId (Maybe.withDefault (message "") currentMessage) ]


{-| Snackbar message
-}
type Message msg
    = Message
        { label : String
        , actionButton : Maybe String
        , onActionButtonClick : Maybe (MessageId -> msg)
        , actionIcon : Maybe (Icon msg)
        , onActionIconClick : Maybe (MessageId -> msg)
        , leading : Bool
        , stacked : Bool
        , timeoutMs : Maybe Int
        }


{-| Specify a message's action button label
-}
setActionButton : Maybe String -> Message msg -> Message msg
setActionButton actionButton (Message message_) =
    Message { message_ | actionButton = actionButton }


{-| Specify a message when the user clicks on a message's action button
-}
setOnActionButtonClick : (MessageId -> msg) -> Message msg -> Message msg
setOnActionButtonClick onActionButtonClick (Message message_) =
    Message { message_ | onActionButtonClick = Just onActionButtonClick }


{-| Specify a message's action icon
-}
setActionIcon : Maybe (Icon msg) -> Message msg -> Message msg
setActionIcon actionIcon (Message message_) =
    Message { message_ | actionIcon = actionIcon }


{-| Specify a message when the user clicks on a message's action icon
-}
setOnActionIconClick : (MessageId -> msg) -> Message msg -> Message msg
setOnActionIconClick onActionIconClick (Message message_) =
    Message { message_ | onActionIconClick = Just onActionIconClick }


{-| Specify whether a message should display _leading_

Messages are by default centered within the viewport. On larger screens, they
can optionally be displyed on the _leading_ edge of the screen. To display a
message as leading, set its `setLeading` configuration option to `True`.

-}
setLeading : Bool -> Message msg -> Message msg
setLeading leading (Message message_) =
    Message { message_ | leading = leading }


{-| Specify whether a message should be stacked

Stacked messages display their label above their action button or icon. This
works best for messages with a long label.

-}
setStacked : Bool -> Message msg -> Message msg
setStacked stacked (Message message_) =
    Message { message_ | stacked = stacked }


{-| Specify a message's timeout in milliseconds
-}
setTimeoutMs : Maybe Int -> Message msg -> Message msg
setTimeoutMs timeoutMs (Message message_) =
    Message { message_ | timeoutMs = timeoutMs }


{-| Default snackbar message (empty label)
-}
message : String -> Message msg
message label =
    Message
        { label = label
        , actionButton = Nothing
        , onActionButtonClick = Nothing
        , actionIcon = Nothing
        , onActionIconClick = Nothing
        , leading = False
        , stacked = False
        , timeoutMs = Just 5000
        }


rootCs : Maybe (Html.Attribute msg)
rootCs =
    Just (class "mdc-snackbar")


closeOnEscapeProp : Config msg -> Maybe (Html.Attribute msg)
closeOnEscapeProp (Config { closeOnEscape }) =
    Just (Html.Attributes.property "closeOnEscape" (Encode.bool closeOnEscape))


leadingCs : Maybe (Message msg) -> Maybe (Html.Attribute msg)
leadingCs message_ =
    Maybe.andThen
        (\(Message { leading }) ->
            if leading then
                Just (class "mdc-snackbar--leading")

            else
                Nothing
        )
        message_


stackedCs : Maybe (Message msg) -> Maybe (Html.Attribute msg)
stackedCs message_ =
    Maybe.andThen
        (\(Message { stacked }) ->
            if stacked then
                Just (class "mdc-snackbar--stacked")

            else
                Nothing
        )
        message_


messageIdProp : MessageId -> Maybe (Html.Attribute msg)
messageIdProp (MessageId messageId) =
    Just (Html.Attributes.property "messageId" (Encode.int messageId))


timeoutMsProp : Maybe (Message msg) -> Maybe (Html.Attribute msg)
timeoutMsProp message_ =
    let
        normalizedTimeoutMs =
            message_
                |> Maybe.andThen
                    (\(Message { timeoutMs }) -> Maybe.map (clamp 4000 10000) timeoutMs)
                |> Maybe.withDefault indefiniteTimeout

        indefiniteTimeout =
            -1
    in
    Just (Html.Attributes.property "timeoutMs" (Encode.int normalizedTimeoutMs))


closedHandler : MessageId -> Config msg -> Maybe (Html.Attribute msg)
closedHandler messageId (Config { onClosed }) =
    Just (Html.Events.on "MDCSnackbar:closed" (Decode.succeed (onClosed messageId)))


ariaStatusRoleAttr : Html.Attribute msg
ariaStatusRoleAttr =
    Html.Attributes.attribute "aria-role" "status"


ariaPoliteLiveAttr : Html.Attribute msg
ariaPoliteLiveAttr =
    Html.Attributes.attribute "aria-live" "polite"


surfaceElt : MessageId -> Message msg -> Html msg
surfaceElt messageId message_ =
    Html.div [ class "mdc-snackbar__surface" ]
        [ labelElt message_
        , actionsElt messageId message_
        ]


labelElt : Message msg -> Html msg
labelElt (Message { label }) =
    Html.div [ class "mdc-snackbar__label", ariaStatusRoleAttr, ariaPoliteLiveAttr ]
        [ text label ]


actionsElt : MessageId -> Message msg -> Html msg
actionsElt messageId message_ =
    Html.div [ class "mdc-snackbar__actions" ]
        (List.filterMap identity
            [ actionButtonElt messageId message_
            , actionIconElt messageId message_
            ]
        )


actionButtonElt : MessageId -> Message msg -> Maybe (Html msg)
actionButtonElt messageId ((Message { actionButton }) as message_) =
    Maybe.map
        (\actionButtonLabel ->
            Html.button
                (List.filterMap identity
                    [ actionButtonCs
                    , actionButtonClickHandler messageId message_
                    ]
                )
                [ text actionButtonLabel ]
        )
        actionButton


actionButtonCs : Maybe (Html.Attribute msg)
actionButtonCs =
    Just (class "mdc-button mdc-snackbar__action")


actionButtonClickHandler : MessageId -> Message msg -> Maybe (Html.Attribute msg)
actionButtonClickHandler messageId (Message { onActionButtonClick }) =
    Maybe.map (Html.Events.onClick << (|>) messageId) onActionButtonClick


actionIconElt : MessageId -> Message msg -> Maybe (Html msg)
actionIconElt messageId ((Message { actionIcon }) as message_) =
    case actionIcon of
        Just (Icon { node, attributes, nodes }) ->
            Just
                (node
                    (List.filterMap identity
                        [ Just (class "mdc-icon-button")
                        , Just (class "mdc-snackbar__dismiss")
                        , actionIconClickHandler messageId message_
                        ]
                        ++ attributes
                    )
                    nodes
                )

        Just (SvgIcon { node, attributes, nodes }) ->
            Just
                (node
                    (List.filterMap identity
                        [ Just (class "mdc-icon-button")
                        , Just (class "mdc-snackbar__dismiss")
                        , actionIconClickHandler messageId message_
                        ]
                        ++ attributes
                    )
                    nodes
                )

        Nothing ->
            Nothing


actionIconClickHandler : MessageId -> Message msg -> Maybe (Html.Attribute msg)
actionIconClickHandler messageId (Message { onActionIconClick }) =
    Maybe.map (Html.Events.onClick << (|>) messageId) onActionIconClick


{-| Icon type
-}
type Icon msg
    = Icon
        { node : List (Html.Attribute msg) -> List (Html msg) -> Html msg
        , attributes : List (Html.Attribute msg)
        , nodes : List (Html msg)
        }
    | SvgIcon
        { node : List (Svg.Attribute msg) -> List (Svg msg) -> Svg msg
        , attributes : List (Svg.Attribute msg)
        , nodes : List (Svg msg)
        }


{-| Material Icon

    Snackbar.message "Something happened"
        |> Snackbar.setActionIcon
            (Just (Snackbar.icon "favorite"))

-}
icon : String -> Icon msg
icon iconName =
    customIcon Html.i [ class "material-icons" ] [ text iconName ]


{-| Custom icon

    Snackbar.message "Something happened"
        |> Snackbar.setActionIcon
            (Just
                (Snackbar.customIcon Html.i
                    [ class "fab fa-font-awesome" ]
                    []
                )
            )

-}
customIcon :
    (List (Html.Attribute msg) -> List (Html msg) -> Html msg)
    -> List (Html.Attribute msg)
    -> List (Html msg)
    -> Icon msg
customIcon node attributes nodes =
    Icon { node = node, attributes = attributes, nodes = nodes }


{-| SVG icon

    Snackbar.message "Something happened"
        |> Snackbar.setActionIcon
            (Just
                (Snackbar.svgIcon
                    [ Svg.Attributes.viewBox "…" ]
                    [-- …
                    ]
                )
            )

-}
svgIcon : List (Svg.Attribute msg) -> List (Svg msg) -> Icon msg
svgIcon attributes nodes =
    SvgIcon { node = Svg.svg, attributes = attributes, nodes = nodes }
