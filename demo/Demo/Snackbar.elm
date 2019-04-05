module Demo.Snackbar exposing (Model, Msg(..), defaultModel, update, view)

import Demo.Helper.ResourceLink as ResourceLink
import Demo.Page as Page exposing (Page)
import Html exposing (Html, text)
import Html.Attributes
import Html.Events
import Json.Decode as Json
import Material.Button as Button exposing (buttonConfig, raisedButton)
import Material.Checkbox as Checkbox exposing (checkbox, checkboxConfig)
import Material.FormField as FormField exposing (formField, formFieldConfig)
import Material.Snackbar as Snackbar exposing (snackbar, snackbarConfig)
import Material.TextField as TextField exposing (textField, textFieldConfig)
import Material.Typography as Typography
import Platform.Cmd exposing (Cmd, none)


type alias Model =
    { stacked : Bool
    , dismissOnAction : Bool
    , messageText : String
    , actionText : String
    }


defaultModel : Model
defaultModel =
    { stacked = False
    , dismissOnAction = True
    , messageText = "Message deleted"
    , actionText = "Undo"
    }


type Msg
    = ToggleStacked
    | ToggleDismissOnAction
    | SetMessageText String
    | SetActionText String
    | Show String
    | Dismiss String
    | NoOp


update : (Msg -> m) -> Msg -> Model -> ( Model, Cmd m )
update lift msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )

        ToggleStacked ->
            ( { model | stacked = not model.stacked }, Cmd.none )

        ToggleDismissOnAction ->
            ( { model | dismissOnAction = not model.dismissOnAction }, Cmd.none )

        SetMessageText messageText ->
            ( { model | messageText = messageText }, Cmd.none )

        SetActionText actionText ->
            ( { model | actionText = actionText }, Cmd.none )

        Show idx ->
            -- TODO:
            -- let
            --     contents =
            --         if model.stacked then
            --             let
            --                 snack =
            --                     Snackbar.snack
            --                         (Just (lift (Dismiss model.messageText)))
            --                         model.messageText
            --                         model.actionText
            --             in
            --             { snack
            --                 | dismissOnAction = model.dismissOnAction
            --                 , stacked = model.stacked
            --             }
            --
            --         else
            --             let
            --                 toast =
            --                     Snackbar.toast
            --                         (Just (lift (Dismiss model.messageText)))
            --                         model.messageText
            --             in
            --             { toast
            --                 | dismissOnAction = model.dismissOnAction
            --                 , action = Just "Hide"
            --             }
            --
            --     ( mdc, effects ) =
            --         Snackbar.add lift idx contents model.mdc
            -- in
            -- ( { model | mdc = mdc }, effects )
            ( model, Cmd.none )

        Dismiss str ->
            ( model, Cmd.none )


view : (Msg -> m) -> Page m -> Model -> Html m
view lift page model =
    let
        example options =
            Html.div
                (Html.Attributes.style "margin-top" "24px"
                    :: options
                )
    in
    page.body "Snackbar"
        "Snackbars provide brief feedback about an operation through a message at the bottom of the screen."
        [ Page.hero []
            [ Html.div
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
            ]
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
            [ example []
                [ Html.h2 [ Typography.headline6 ] [ text "Basic Example" ]
                , formField { formFieldConfig | label = "Stacked" }
                    [ checkbox
                        { checkboxConfig
                            | state =
                                if model.stacked then
                                    Checkbox.Checked

                                else
                                    Checkbox.Unchecked
                            , onClick = Just (lift ToggleStacked)
                        }
                    ]
                , Html.br [] []
                , formField { formFieldConfig | label = "Dismiss On Action" }
                    [ checkbox
                        { checkboxConfig
                            | state =
                                if model.dismissOnAction then
                                    Checkbox.Checked

                                else
                                    Checkbox.Unchecked
                            , onClick = Just (lift ToggleDismissOnAction)
                        }
                    ]
                , Html.br [] []
                , -- TODO: Html.Events.onInput (lift << SetMessageText)
                  -- TODO: value = model.messageText
                  textField
                    { textFieldConfig
                        | label = "Message Text"
                    }
                , Html.br [] []
                , -- TODO: Html.Events.onInput (lift << SetActionText)
                  -- TODO: value = model.actionText
                  textField
                    { textFieldConfig
                        | label = "Action Text"
                    }
                , Html.br [] []
                , raisedButton
                    { buttonConfig
                        | onClick = Just (lift (Show "snackbar-default-snackbar"))
                        , additionalAttributes =
                            [ Html.Attributes.style "margin-top" "14px" ]
                    }
                    "Show"
                , text " "
                , raisedButton
                    { buttonConfig
                        | onClick = Just (lift (Show "snackbar-dismissible-snackbar"))
                        , additionalAttributes =
                            [ Html.Attributes.style "margin-top" "14px" ]
                    }
                    "Show dismissible"
                , text " "
                , raisedButton
                    { buttonConfig
                        | onClick = Just (lift (Show "snackbar-leading-snackbar"))
                        , additionalAttributes =
                            [ Html.Attributes.style "margin-top" "14px" ]
                    }
                    "Show leading"
                , text " "
                , raisedButton
                    { buttonConfig
                        | onClick = Just (lift (Show "snackbar-leading-snackbar-rtl"))
                        , additionalAttributes =
                            [ Html.Attributes.style "margin-top" "14px" ]
                    }
                    "Show leading rtl"
                , snackbar snackbarConfig Nothing
                , snackbar snackbarConfig Nothing
                , snackbar { snackbarConfig | leading = True } Nothing
                , Html.div
                    [ Html.Attributes.attribute "dir" "rtl"
                    ]
                    [ snackbar { snackbarConfig | leading = True } Nothing
                    ]
                ]
            ]
        ]
