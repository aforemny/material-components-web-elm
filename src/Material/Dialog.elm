module Material.Dialog exposing (Config, Content, dialog, dialogConfig)

import Html exposing (Html, text)
import Html.Attributes exposing (class)
import Html.Events
import Json.Decode as Decode


type alias Config msg =
    { open : Bool
    , additionalAttributes : List (Html.Attribute msg)
    , onClose : Maybe msg
    }


dialogConfig : Config msg
dialogConfig =
    { open = False
    , additionalAttributes = []
    , onClose = Nothing
    }


type alias Content msg =
    { title : Maybe String
    , content : List (Html msg)
    , actions : List (Html msg)
    }


dialog : Config msg -> Content msg -> Html msg
dialog config content =
    Html.node "mdc-dialog"
        (List.filterMap identity
            [ rootCs
            , openAttr config
            , roleAttr
            , ariaModalAttr
            , closeHandler config
            ]
        )
        [ containerElt content
        , scrimElt
        ]


rootCs : Maybe (Html.Attribute msg)
rootCs =
    Just (class "mdc-dialog")


openAttr : Config msg -> Maybe (Html.Attribute msg)
openAttr { open } =
    if open then
        Just (Html.Attributes.attribute "open" "")

    else
        Nothing


roleAttr : Maybe (Html.Attribute msg)
roleAttr =
    Just (Html.Attributes.attribute "role" "alertdialog")


ariaModalAttr : Maybe (Html.Attribute msg)
ariaModalAttr =
    Just (Html.Attributes.attribute "aria-modal" "true")


closeHandler : Config msg -> Maybe (Html.Attribute msg)
closeHandler { onClose } =
    Maybe.map (Html.Events.on "MDCDialog:close" << Decode.succeed) onClose


containerElt : Content msg -> Html msg
containerElt content =
    Html.div [ class "mdc-dialog__container" ] [ surfaceElt content ]


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
