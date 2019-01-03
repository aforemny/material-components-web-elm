module Material.Snackbar exposing
    ( Button
    , Config
    , Icon
    , Message
    , actionButton
    , actionIcon
    , snackbar
    , snackbarConfig
    )

import Html exposing (Html, text)
import Html.Attributes exposing (class)
import Material.Button
import Material.Icon


type alias Config msg =
    { leading : Bool
    , additionalAttributes : List (Html.Attribute msg)
    }


snackbarConfig : Config msg
snackbarConfig =
    { leading = False
    , additionalAttributes = []
    }


snackbar : Config msg -> Maybe (Message msg) -> Html msg
snackbar config message =
    Html.node "mdc-snackbar"
        (List.filterMap identity
            [ rootCs
            , leadingCs config
            , stackedCs message
            ]
            ++ config.additionalAttributes
        )
        (surfaceElt message)


rootCs : Maybe (Html.Attribute msg)
rootCs =
    Just (class "mdc-snackbar")


leadingCs : Config msg -> Maybe (Html.Attribute msg)
leadingCs { leading } =
    if leading then
        Just (class "mdc-snackbar--leading")

    else
        Nothing


stackedCs : Maybe (Message msg) -> Maybe (Html.Attribute msg)
stackedCs message =
    message
        |> Maybe.andThen
            (\{ stacked } ->
                if stacked then
                    Just (class "mdc-snackbar--stacked")

                else
                    Nothing
            )


surfaceElt : Maybe (Message msg) -> List (Html msg)
surfaceElt maybeMessage =
    maybeMessage
        |> Maybe.map
            (\message ->
                [ Html.div [ class "mdc-snackbar__surface" ]
                    [ labelElt message
                    , actionsElt message
                    ]
                ]
            )
        |> Maybe.withDefault []


labelElt : Message msg -> Html msg
labelElt { label } =
    Html.div [ class "mdc-snackbar__label" ] [ text label ]


actionsElt : Message msg -> Html msg
actionsElt message =
    Html.div [ class "mdc-snackbar__actions" ]
        (List.filterMap identity
            [ actionButtonElt message
            , actionIconElt message
            ]
        )


actionButtonElt : Message msg -> Maybe (Html msg)
actionButtonElt message =
    Maybe.map (\(Button html) -> html) message.actionButton


actionIconElt : Message msg -> Maybe (Html msg)
actionIconElt message =
    Maybe.map (\(Icon html) -> html) message.actionIcon


type alias Message msg =
    { label : String
    , actionButton : Maybe (Button msg)
    , actionIcon : Maybe (Icon msg)
    , stacked : Bool
    }


type Button msg
    = Button (Html msg)


actionButton : Material.Button.Config msg -> String -> Button msg
actionButton config label =
    Button
        (Material.Button.button
            { config
                | additionalAttributes =
                    actionButtonCs :: config.additionalAttributes
            }
            label
        )


actionButtonCs : Html.Attribute msg
actionButtonCs =
    class "mdc-snackbar__action-button"


type Icon msg
    = Icon (Html msg)


actionIcon : Material.Icon.Config msg -> String -> Button msg
actionIcon config iconName =
    Button
        (Material.Icon.icon
            { config
                | additionalAttributes =
                    actionIconCs :: config.additionalAttributes
            }
            iconName
        )


actionIconCs : Html.Attribute msg
actionIconCs =
    class "mdc-snackbar__action-icon"
