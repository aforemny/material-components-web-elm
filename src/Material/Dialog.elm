module Material.Dialog exposing
    ( Config, config
    , setOnClose
    , setOpen
    , setScrimCloses
    , setAttributes
    , alert
    , simple
    , confirmation
    , fullscreen
    , defaultAction
    , initialFocus
    )

{-| Dialogs inform users about a task and can contain critical information,
require decisions, or involve multiple tasks.


# Table of Contents

  - [Resources](#resources)
  - [Basic Usage](#basic-usage)
  - [Configuration](#configuration)
      - [Configuration Options](#configuration-options)
  - [Alert Dialog](#alert-dialog)
  - [Simple Dialog](#simple-dialog)
  - [Confirmation Dialog](#confirmation-dialog)
  - [Fullscreen Dialog](#fullscreen-dialog)
  - [Default Action](#default-action)
  - [Initial Focus](#initial-focus)


# Resources

  - [Demo: Dialogs](https://aforemny.github.io/material-components-web-elm/#dialog)
  - [Material Design Guidelines: Dialogs](https://material.io/go/design-dialogs)
  - [MDC Web: Dialog](https://github.com/material-components/material-components-web/tree/master/packages/mdc-dialog)
  - [Sass Mixins (MDC Web)](https://github.com/material-components/material-components-web/tree/master/packages/mdc-dialog#sass-mixins)


# Basic Usage

    import Material.Button as Button
    import Material.Dialog as Dialog

    type Msg
        = Closed

    main =
        Dialog.alert
            (Dialog.config
                |> Dialog.setOpen True
                |> Dialog.setOnClose Closed
            )
            { content = [ text "Discard draft?" ]
            , actions =
                [ Button.text
                    (Button.config |> Button.setOnClick Closed)
                    "Cancel"
                , Button.text
                    (Button.config
                        |> Button.setOnClick Closed
                        |> Button.setAttributes [ Dialog.defaultAction ]
                    )
                    "Discard"
                ]
            }


# Configuration

@docs Config, config


## Configuration Options

@docs setOnClose
@docs setOpen
@docs setScrimCloses
@docs setAttributes


# Alert Dialog

@docs alert


# Simple Dialog

@docs simple


# Confirmation Dialog

@docs confirmation


# Fullscreen Dialog

@docs fullscreen


# Default Action

@docs defaultAction


# Initial Focus

@docs initialFocus

-}

import Html exposing (Html, text)
import Html.Attributes exposing (class, style)
import Html.Events
import Json.Decode as Decode
import Json.Encode as Encode
import Material.IconButton as IconButton


{-| Configuration of a dialog
-}
type Config msg
    = Config
        { open : Bool
        , fullscreen : Bool
        , additionalAttributes : List (Html.Attribute msg)
        , onClose : Maybe msg
        , scrimCloses : Bool
        }


{-| Default configuration of a dialog
-}
config : Config msg
config =
    Config
        { open = False
        , fullscreen = False
        , additionalAttributes = []
        , onClose = Nothing
        , scrimCloses = True
        }


{-| Specify whether a dialog is open
-}
setOpen : Bool -> Config msg -> Config msg
setOpen open (Config config_) =
    Config { config_ | open = open }


{-| Specify whether click the dialog's scrim should close the dialog

If set to `True`, clicking on the dialog's scrim results in the dialog's
`setOnClose` mege. Defaults to `True`.

-}
setScrimCloses : Bool -> Config msg -> Config msg
setScrimCloses scrimCloses (Config config_) =
    Config { config_ | scrimCloses = scrimCloses }


{-| Specify additional attributes
-}
setAttributes : List (Html.Attribute msg) -> Config msg -> Config msg
setAttributes additionalAttributes (Config config_) =
    Config { config_ | additionalAttributes = additionalAttributes }


{-| Specify a message when the user closes the dialog
-}
setOnClose : msg -> Config msg -> Config msg
setOnClose onClose (Config config_) =
    Config { config_ | onClose = Just onClose }


{-| Alert dialog view function
-}
alert :
    Config msg
    ->
        { content : List (Html msg)
        , actions : List (Html msg)
        }
    -> Html msg
alert config_ { content, actions } =
    generic config_ { title = Nothing, content = content, actions = actions }


{-| Simple dialog view function
-}
simple :
    Config msg
    ->
        { title : String
        , content : List (Html msg)
        }
    -> Html msg
simple ((Config { additionalAttributes }) as config_) { title, content } =
    generic config_ { title = Just title, content = content, actions = [] }


{-| Confirmation dialog view function
-}
confirmation :
    Config msg
    ->
        { title : String
        , content : List (Html msg)
        , actions : List (Html msg)
        }
    -> Html msg
confirmation config_ { title, content, actions } =
    generic config_ { title = Just title, content = content, actions = actions }


{-| Fullscreen view function
-}
fullscreen :
    Config msg
    ->
        { title : String
        , content : List (Html msg)
        , actions : List (Html msg)
        }
    -> Html msg
fullscreen (Config config_) { title, content, actions } =
    generic (Config { config_ | fullscreen = True })
        { title = Just title, content = content, actions = actions }


{-| A button that is marked with this attribute is automatically activated by
the containing dialog on pressing the `Enter` key.
-}
defaultAction : Html.Attribute msg
defaultAction =
    Html.Attributes.attribute "data-mdc-dialog-button-default" ""


{-| An element that is marked with this attribute is automatically focus on
opening the containing dialog.
-}
initialFocus : Html.Attribute msg
initialFocus =
    Html.Attributes.attribute "data-mdc-dialog-initial-focus" ""


type alias Content msg =
    { title : Maybe String
    , content : List (Html msg)
    , actions : List (Html msg)
    }


generic :
    Config msg
    -> Content msg
    -> Html msg
generic ((Config { additionalAttributes }) as config_) content =
    Html.node "mdc-dialog"
        (List.filterMap identity
            [ rootCs
            , fullscreenCs config_
            , openProp config_
            , scrimClickActionProp config_
            , closeHandler config_
            ]
            ++ additionalAttributes
        )
        [ containerElt config_ content
        , scrimElt
        ]


rootCs : Maybe (Html.Attribute msg)
rootCs =
    Just (class "mdc-dialog")


fullscreenCs : Config msg -> Maybe (Html.Attribute msg)
fullscreenCs (Config config_) =
    if config_.fullscreen then
        Just (class "mdc-dialog--fullscreen")

    else
        Nothing


openProp : Config msg -> Maybe (Html.Attribute msg)
openProp (Config { open }) =
    Just (Html.Attributes.property "open" (Encode.bool open))


scrimClickActionProp : Config msg -> Maybe (Html.Attribute msg)
scrimClickActionProp (Config { scrimCloses }) =
    Just
        (Html.Attributes.property "scrimClickAction"
            (Encode.string
                (if scrimCloses then
                    "close"

                 else
                    ""
                )
            )
        )


closeHandler : Config msg -> Maybe (Html.Attribute msg)
closeHandler (Config { onClose }) =
    Maybe.map (Html.Events.on "MDCDialog:close" << Decode.succeed) onClose


containerElt : Config msg -> Content msg -> Html msg
containerElt config_ content =
    Html.div [ class "mdc-dialog__container" ] [ surfaceElt config_ content ]


surfaceElt : Config msg -> Content msg -> Html msg
surfaceElt ((Config config_) as config__) content =
    Html.div
        [ dialogSurfaceCs
        , alertDialogRoleAttr
        , ariaModalAttr
        ]
        (List.filterMap identity
            [ if config_.fullscreen then
                headerElt config__ content

              else
                titleElt content
            , contentElt content
            , actionsElt content
            ]
        )


dialogSurfaceCs : Html.Attribute msg
dialogSurfaceCs =
    class "mdc-dialog__surface"


alertDialogRoleAttr : Html.Attribute msg
alertDialogRoleAttr =
    Html.Attributes.attribute "role" "alertdialog"


ariaModalAttr : Html.Attribute msg
ariaModalAttr =
    Html.Attributes.attribute "aria-modal" "true"


headerElt : Config msg -> Content msg -> Maybe (Html msg)
headerElt (Config { onClose }) content =
    Just <|
        Html.div [ class "mdc-dialog__header" ]
            (List.filterMap identity
                [ titleElt content
                , Just <|
                    Html.div
                        [ class "mdc-dialog__close"
                        , style "position" "relative"
                        ]
                        [ IconButton.iconButton
                            (IconButton.config
                                |> (case onClose of
                                        Just onClose_ ->
                                            IconButton.setOnClick onClose_

                                        Nothing ->
                                            identity
                                   )
                            )
                            (IconButton.icon "close")
                        ]
                ]
            )


titleElt : Content msg -> Maybe (Html msg)
titleElt { title } =
    case title of
        Just title_ ->
            Just (Html.div [ class "mdc-dialog__title" ] [ text title_ ])

        Nothing ->
            Nothing


contentElt : Content msg -> Maybe (Html msg)
contentElt { content } =
    Just (Html.div [ class "mdc-dialog__content" ] content)


actionsElt : Content msg -> Maybe (Html msg)
actionsElt { actions } =
    if List.isEmpty actions then
        Nothing

    else
        Just (Html.div [ class "mdc-dialog__actions" ] actions)


scrimElt : Html msg
scrimElt =
    Html.div [ class "mdc-dialog__scrim" ] []
