module Material.Dialog exposing (Config, Content, dialog, dialogConfig)

import Html exposing (Html, text)
import Html.Attributes exposing (class)



-- TODO: noScrim config?
-- TODO: onClose config?
-- TODO: dialog w/o title?


type alias Config msg =
    { open : Bool
    , additionalAttributes : List (Html.Attribute msg)
    }


dialogConfig : Config msg
dialogConfig =
    { open = False
    , additionalAttributes = []
    }


type alias Content msg =
    { title : String
    , content : List (Html msg)
    , actions : List (Html msg)
    }


dialog : Config msg -> Content msg -> Html msg
dialog config content =
    Html.node "mdc-dialog"
        (List.filterMap identity
            [ rootCs
            , openCs config
            , roleAttr
            , ariaModalAttr
            ]
        )
        [ surfaceElt content
        , scrimElt
        ]


rootCs : Maybe (Html.Attribute msg)
rootCs =
    Just (class "mdc-dialog")


openCs : Config msg -> Maybe (Html.Attribute msg)
openCs { open } =
    if open then
        Just (class "mdc-dialog--open")

    else
        Nothing


roleAttr : Maybe (Html.Attribute msg)
roleAttr =
    Just (Html.Attributes.attribute "role" "alertdialog")


ariaModalAttr : Maybe (Html.Attribute msg)
ariaModalAttr =
    Just (Html.Attributes.attribute "aria-modal" "true")


surfaceElt : Content msg -> Html msg
surfaceElt content =
    Html.div
        [ class "mdc-dialog__surface" ]
        (List.filterMap identity
            [ titleElt content
            , contentElt content
            , actionsElt content
            ]
        )


titleElt : Content msg -> Maybe (Html msg)
titleElt { title } =
    Just (Html.div [ class "mdc-dialog__title" ] [ text title ])


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
