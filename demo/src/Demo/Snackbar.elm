module Demo.Snackbar exposing (Model, Msg(..), defaultModel, update, view)

import Demo.CatalogPage exposing (CatalogPage)
import Demo.Helper.ResourceLink as ResourceLink
import Html exposing (Html, text)
import Html.Attributes
import Html.Events
import Json.Decode as Json
import Material.Button exposing (buttonConfig, raisedButton)
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


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
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
            ( model, Snackbar.addMessage SnackbarMsg baselineMessage )

        ShowLeading ->
            ( model, Snackbar.addMessage SnackbarMsg leadingMessage )

        ShowStacked ->
            ( model, Snackbar.addMessage SnackbarMsg stackedMessage )

        SnackbarMsg snackbarMsg ->
            Snackbar.update SnackbarMsg snackbarMsg model.queue
                |> Tuple.mapFirst (\queue -> { model | queue = queue })

        Click ->
            ( model, Cmd.none )


view : Model -> CatalogPage Msg
view model =
    { title = "Snackbar"
    , prelude = "Snackbars provide brief feedback about an operation through a message at the bottom of the screen."
    , resources =
        { materialDesignGuidelines = Just "https://material.io/go/design-snackbar"
        , documentation = Just "https://package.elm-lang.org/packages/aforemny/material-components-web-elm/latest/Material-Snackbar"
        , sourceCode = Just "https://github.com/material-components/material-components-web/tree/master/packages/mdc-snackbar"
        }
    , hero = [ heroMessage ]
    , content =
        [ raisedButton
            { buttonConfig
                | onClick = Just ShowBaseline
                , additionalAttributes = buttonMargin
            }
            "Baseline"
        , text " "
        , raisedButton
            { buttonConfig
                | onClick = Just ShowLeading
                , additionalAttributes = buttonMargin
            }
            "Leading"
        , text " "
        , raisedButton
            { buttonConfig
                | onClick = Just ShowStacked
                , additionalAttributes = buttonMargin
            }
            "Stacked"
        , snackbar SnackbarMsg snackbarConfig model.queue
        ]
    }


heroMessage : Html msg
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


buttonMargin : List (Html.Attribute msg)
buttonMargin =
    [ Html.Attributes.style "margin" "14px" ]
