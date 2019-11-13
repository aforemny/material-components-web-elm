module Material.Dialog exposing (dialog, dialogConfig, DialogConfig, DialogContent)

{-| Dialogs inform users about a task and can contain critical information, require decisions, or involve multiple tasks.


# Table of Contents

  - [Resources](#resources)
  - [Basic Usage](#basic-usage)
  - [Dialog](#dialog)


# Resources

  - [Demo: Dialogs](https://aforemny.github.io/material-components-web-elm/#dialogs)
  - [Material Design Guidelines: Dialogs](https://material.io/go/design-dialogs)
  - [MDC Web: Dialog](https://github.com/material-components/material-components-web/tree/master/packages/mdc-dialog)
  - [Sass Mixins (MDC Web)](https://github.com/material-components/material-components-web/tree/master/packages/mdc-dialog#sass-mixins)


# Basic Usage

    import Material.Button exposing (buttonConfig, textButton)
    import Material.Dialog exposing (dialog, dialogConfig)

    type Msg
        = DialogClosed

    main =
        dialog
            { dialogConfig
                | open = True
                , onClose = Just DialogClosed
            }
            { title = Nothing
            , content =
                [ text "Discard draft?" ]
            , actions =
                [ textButton
                    { buttonConfig
                        | onClick = Just DialogClosed
                    }
                    "Cancel"
                , textButton
                    { buttonConfig
                        | onClick = Just DialogClosed
                    }
                    "Discard"
                ]
            }


# Dialog

@docs dialog, dialogConfig, DialogConfig, DialogContent

-}

import Html exposing (Html, text)
import Html.Attributes exposing (class)
import Html.Events
import Json.Decode as Decode
import Json.Encode as Encode


{-| Configuration of a dialog
-}
type alias DialogConfig msg =
    { open : Bool
    , additionalAttributes : List (Html.Attribute msg)
    , onClose : Maybe msg
    }


{-| Default configuration of a dialog
-}
dialogConfig : DialogConfig msg
dialogConfig =
    { open = False
    , additionalAttributes = []
    , onClose = Nothing
    }


{-| Dialog content
-}
type alias DialogContent msg =
    { title : Maybe String
    , content : List (Html msg)
    , actions : List (Html msg)
    }


{-| Dialog view function
-}
dialog : DialogConfig msg -> DialogContent msg -> Html msg
dialog config content =
    Html.node "mdc-dialog"
        (List.filterMap identity
            [ rootCs
            , openProp config
            , roleAttr
            , ariaModalAttr
            , closeHandler config
            ]
            ++ config.additionalAttributes
        )
        [ containerElt content
        , scrimElt
        ]


rootCs : Maybe (Html.Attribute msg)
rootCs =
    Just (class "mdc-dialog")


openProp : DialogConfig msg -> Maybe (Html.Attribute msg)
openProp { open } =
    Just (Html.Attributes.property "open" (Encode.bool open))


roleAttr : Maybe (Html.Attribute msg)
roleAttr =
    Just (Html.Attributes.attribute "role" "alertdialog")


ariaModalAttr : Maybe (Html.Attribute msg)
ariaModalAttr =
    Just (Html.Attributes.attribute "aria-modal" "true")


closeHandler : DialogConfig msg -> Maybe (Html.Attribute msg)
closeHandler { onClose } =
    Maybe.map (Html.Events.on "MDCDialog:close" << Decode.succeed) onClose


containerElt : DialogContent msg -> Html msg
containerElt content =
    Html.div [ class "mdc-dialog__container" ] [ surfaceElt content ]


surfaceElt : DialogContent msg -> Html msg
surfaceElt content =
    Html.div
        [ class "mdc-dialog__surface" ]
        (List.filterMap identity
            [ titleElt content
            , contentElt content
            , actionsElt content
            ]
        )


titleElt : DialogContent msg -> Maybe (Html msg)
titleElt { title } =
    case title of
        Just title_ ->
            Just (Html.div [ class "mdc-dialog__title" ] [ text title_ ])

        Nothing ->
            Nothing


contentElt : DialogContent msg -> Maybe (Html msg)
contentElt { content } =
    Just (Html.div [ class "mdc-dialog__content" ] content)


actionsElt : DialogContent msg -> Maybe (Html msg)
actionsElt { actions } =
    if List.isEmpty actions then
        Nothing

    else
        Just (Html.div [ class "mdc-dialog__actions" ] actions)


scrimElt : Html msg
scrimElt =
    Html.div [ class "mdc-dialog__scrim" ] []
