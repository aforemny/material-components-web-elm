module Demo.Snackbar exposing (Model, Msg(..), defaultModel, update, view)

import Demo.CatalogPage exposing (CatalogPage)
import Html exposing (Html, text)
import Html.Attributes exposing (class, style)
import Material.Button as Button
import Material.Snackbar as Snackbar
import Platform.Cmd exposing (Cmd)


type alias Model =
    { queue : Snackbar.Queue Msg }


defaultModel : Model
defaultModel =
    { queue = Snackbar.initialQueue }


type Msg
    = ShowBaseline
    | ShowLeading
    | ShowStacked
    | SnackbarClosed Snackbar.MessageId
    | Click Snackbar.MessageId


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        ShowBaseline ->
            ( { model | queue = Snackbar.addMessage baselineMessage model.queue }
            , Cmd.none
            )

        ShowLeading ->
            ( { model | queue = Snackbar.addMessage leadingMessage model.queue }
            , Cmd.none
            )

        ShowStacked ->
            ( { model | queue = Snackbar.addMessage stackedMessage model.queue }
            , Cmd.none
            )

        SnackbarClosed messageId ->
            ( { model | queue = Snackbar.close messageId model.queue }, Cmd.none )

        Click messageId ->
            ( model, Cmd.none )


baselineMessage : Snackbar.Message Msg
baselineMessage =
    Snackbar.message "Can't send photo. Retry in 5 seconds."
        |> Snackbar.setActionButton (Just "Retry")
        |> Snackbar.setOnActionButtonClick Click
        |> Snackbar.setActionIcon (Just "close")


leadingMessage : Snackbar.Message Msg
leadingMessage =
    Snackbar.message "Your photo has been archived."
        |> Snackbar.setLeading True
        |> Snackbar.setActionButton (Just "Undo")
        |> Snackbar.setOnActionButtonClick Click
        |> Snackbar.setActionIcon (Just "close")


stackedMessage : Snackbar.Message Msg
stackedMessage =
    Snackbar.message "This item already has the label \"travel\". You can add a new label."
        |> Snackbar.setStacked True
        |> Snackbar.setActionButton (Just "Add a new label")
        |> Snackbar.setOnActionButtonClick Click
        |> Snackbar.setActionIcon (Just "close")


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
        [ Button.raised
            (Button.config
                |> Button.setOnClick ShowBaseline
                |> Button.setAttributes buttonMargin
            )
            "Baseline"
        , text " "
        , Button.raised
            (Button.config
                |> Button.setOnClick ShowLeading
                |> Button.setAttributes buttonMargin
            )
            "Leading"
        , text " "
        , Button.raised
            (Button.config
                |> Button.setOnClick ShowStacked
                |> Button.setAttributes buttonMargin
            )
            "Stacked"
        , Snackbar.snackbar
            (Snackbar.config { onClosed = SnackbarClosed }
                |> Snackbar.setCloseOnEscape True
            )
            model.queue
        ]
    }


buttonMargin : List (Html.Attribute msg)
buttonMargin =
    [ style "margin" "14px" ]


heroMessage : Html msg
heroMessage =
    Html.div
        [ class "mdc-snackbar mdc-snackbar--open"
        , style "position" "relative"
        , style "left" "0"
        , style "transform" "none"
        ]
        [ Html.div
            [ class "mdc-snackbar__surface" ]
            [ Html.div
                [ class "mdc-snackbar__label"
                , style "color" "hsla(0,0%,100%,.87)"
                , Html.Attributes.attribute "role" "status"
                , Html.Attributes.attribute "aria-live" "polite"
                ]
                [ text "Can't send photo. Retry in 5 seconds." ]
            , Html.div
                [ class "mdc-snackbar__actions" ]
                [ Html.button
                    [ class "mdc-button"
                    , class "mdc-snackbar__action"
                    , Html.Attributes.type_ "button"
                    ]
                    [ text "Retry" ]
                , Html.button
                    [ class "mdc-icon-button"
                    , class "mdc-snackbar__dismiss"
                    , class "material-icons"
                    ]
                    [ text "close" ]
                ]
            ]
        ]
