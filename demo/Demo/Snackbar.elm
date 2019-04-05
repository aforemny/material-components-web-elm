module Demo.Snackbar exposing (Model, Msg(..), defaultModel, update, view)

import Demo.Helper.ResourceLink as ResourceLink
import Demo.Page as Page exposing (Page)
import Html exposing (Html, text)
import Html.Attributes
import Html.Events
import Json.Decode as Json
import Material.Button as Button exposing (buttonConfig, raisedButton)
import Material.Snackbar as Snackbar exposing (snackbar, snackbarConfig, snackbarMessage)
import Platform.Cmd exposing (Cmd, none)


type alias Model =
    { queue : Snackbar.Queue Msg }


defaultModel : Model
defaultModel =
    { queue = Snackbar.initialQueue }


type Msg
    = ShowBaseline
    | ShowLeading
    | ShowStacked
    | SnackbarMsg (Snackbar.Msg Msg)
    | Click


update : (Msg -> m) -> Msg -> Model -> ( Model, Cmd m )
update lift msg model =
    let
        baselineMessage =
            { snackbarMessage
                | label = "Can't send photo. Retry in 5 seconds."
                , actionButton = Just "Retry"
                , onActionButtonClick = Just Click
                , actionIcon = Just "close"
                , onActionIconClick = Just Click
            }

        leadingMessage =
            { snackbarMessage
                | label = "Your photo has been archived."
                , leading = True
                , actionButton = Just "Undo"
                , onActionButtonClick = Just Click
                , actionIcon = Just "close"
                , onActionIconClick = Just Click
            }

        stackedMessage =
            { snackbarMessage
                | label =
                    "This item already has the label \"travel\". You can add a new label."
                , stacked = True
                , actionButton = Just "Add a new label"
                , onActionButtonClick = Just Click
                , actionIcon = Just "close"
                , onActionIconClick = Just Click
            }
    in
    case msg of
        ShowBaseline ->
            ( model, Cmd.map lift (Snackbar.addMessage SnackbarMsg baselineMessage) )

        ShowLeading ->
            ( model, Cmd.map lift (Snackbar.addMessage SnackbarMsg leadingMessage) )

        ShowStacked ->
            ( model, Cmd.map lift (Snackbar.addMessage SnackbarMsg stackedMessage) )

        SnackbarMsg snackbarMsg ->
            let
                ( queue, cmds ) =
                    Snackbar.update SnackbarMsg snackbarMsg model.queue
            in
            ( { model | queue = queue }, Cmd.map lift cmds )

        Click ->
            ( model, Cmd.none )


view : (Msg -> m) -> Page m -> Model -> Html m
view lift page model =
    page.body "Snackbar"
        "Snackbars provide brief feedback about an operation through a message at the bottom of the screen."
        [ Page.hero [] [ heroMessage ]
        , Html.h2
            [ Html.Attributes.class "mdc-typography--headline6"
            , Html.Attributes.style "border-bottom" "1px solid rgba(0,0,0,.87)"
            ]
            [ text "Resources"
            ]
        , ResourceLink.view
            { link = "https://material.io/go/design-snackbar"
            , title = "Material Design Guidelines"
            , icon = "images/material.svg"
            , altText = "Material Design Guidelines icon"
            }
        , ResourceLink.view
            { link = "https://material.io/components/web/catalog/snackbars/"
            , title = "Documentation"
            , icon = "images/ic_drive_document_24px.svg"
            , altText = "Documentation icon"
            }
        , ResourceLink.view
            { link = "https://github.com/material-components/material-components-web/tree/master/packages/mdc-snackbar"
            , title = "Source Code (Material Components Web)"
            , icon = "images/ic_code_24px.svg"
            , altText = "Source Code"
            }
        , Page.demos
            [ raisedButton
                { buttonConfig
                    | onClick = Just (lift ShowBaseline)
                    , additionalAttributes = buttonMargin
                }
                "Baseline"
            , text " "
            , raisedButton
                { buttonConfig
                    | onClick = Just (lift ShowLeading)
                    , additionalAttributes = buttonMargin
                }
                "Leading"
            , text " "
            , raisedButton
                { buttonConfig
                    | onClick = Just (lift ShowStacked)
                    , additionalAttributes = buttonMargin
                }
                "Stacked"
            , Html.map lift (snackbar SnackbarMsg snackbarConfig model.queue)
            ]
        ]


heroMessage : Html m
heroMessage =
    Html.div
        [ Html.Attributes.style "position" "relative"
        , Html.Attributes.style "left" "0"
        , Html.Attributes.style "transform" "none"
        , Html.Attributes.class "mdc-snackbar mdc-snackbar--open"
        ]
        [ Html.div
            [ Html.Attributes.class "mdc-snackbar__surface" ]
            [ Html.div
                [ Html.Attributes.class "mdc-snackbar__label"
                , Html.Attributes.attribute "role" "status"
                , Html.Attributes.attribute "aria-live" "polite"
                , Html.Attributes.style "color" "hsla(0,0%,100%,.87)"
                ]
                [ text "Can't send photo. Retry in 5 seconds." ]
            , Html.div
                [ Html.Attributes.class "mdc-snackbar__actions" ]
                [ Html.button
                    [ Html.Attributes.type_ "button"
                    , Html.Attributes.class "mdc-button"
                    , Html.Attributes.class "mdc-snackbar__action"
                    ]
                    [ text "Retry"
                    ]
                , Html.button
                    [ Html.Attributes.class "mdc-icon-button"
                    , Html.Attributes.class "mdc-snackbar__dismiss"
                    , Html.Attributes.class "material-icons"
                    ]
                    [ text "close" ]
                ]
            ]
        ]


buttonMargin : List (Html.Attribute m)
buttonMargin =
    [ Html.Attributes.style "margin" "14px" ]
