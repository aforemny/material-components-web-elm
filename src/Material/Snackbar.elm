module Material.Snackbar exposing
    ( Config
    , Message
    , Msg
    , Queue
    , addMessage
    , initialQueue
    , snackbar
    , snackbarConfig
    , snackbarMessage
    , update
    )

import Html exposing (Html, text)
import Html.Attributes exposing (class)
import Html.Events
import Json.Decode as Decode
import Process
import Task


type alias Queue msg =
    { messages : List (Message msg)
    , messageId : MessageId
    }


type alias MessageId =
    Int


initialQueue : Queue msg
initialQueue =
    { messages = []
    , messageId = 0
    }


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


type Msg msg
    = AddMessage (Message msg)
    | Close


addMessage : (Msg msg -> msg) -> Message msg -> Cmd msg
addMessage lift message =
    Task.perform lift (Task.succeed (AddMessage message))


type alias Config msg =
    { additionalAttributes : List (Html.Attribute msg)
    }


snackbarConfig : Config msg
snackbarConfig =
    { additionalAttributes = []
    }


snackbar : (Msg msg -> msg) -> Config msg -> Queue msg -> Html msg
snackbar lift config queue =
    let
        message =
            Maybe.withDefault snackbarMessage (List.head queue.messages)
    in
    Html.node "mdc-snackbar"
        (List.filterMap identity
            [ rootCs
            , messageAttr queue
            , leadingCs message
            , stackedCs message
            , timeoutAttr message
            , closedHandler lift
            ]
            ++ config.additionalAttributes
        )
        [ surfaceElt message ]


type alias Message msg =
    { label : String
    , actionButton : Maybe String
    , onActionButtonClick : Maybe msg
    , actionIcon : Maybe String
    , onActionIconClick : Maybe msg
    , leading : Bool
    , stacked : Bool
    , timeoutMs : Float
    }


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


messageAttr : Queue msg -> Maybe (Html.Attribute msg)
messageAttr { messageId } =
    Just (Html.Attributes.attribute "message" (String.fromInt messageId))


timeoutAttr : Message msg -> Maybe (Html.Attribute msg)
timeoutAttr { timeoutMs } =
    let
        normalizedTimeoutMs =
            String.fromFloat (clamp 4000 10000 timeoutMs)
    in
    Just (Html.Attributes.attribute "timeout" normalizedTimeoutMs)


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
