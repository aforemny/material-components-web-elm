module Demo.Dialog exposing (Model, Msg(..), defaultModel, update, view)

import Demo.Helper.Hero as Hero
import Demo.Helper.ResourceLink as ResourceLink
import Demo.Page as Page exposing (Page)
import Html exposing (Html, text)
import Html.Attributes
import Html.Events
import Material.Button as Button exposing (button, buttonConfig)
import Material.Dialog as Dialog exposing (dialog, dialogConfig)
import Material.FormField as FormField
import Material.Icon as Icon exposing (icon, iconConfig)
import Material.List as Lists exposing (list, listConfig, listItem, listItemConfig)
import Material.Radio as Radio exposing (radio, radioConfig)
import Material.Typography as Typography


type alias Model =
    { openDialog : Maybe String
    }


defaultModel : Model
defaultModel =
    { openDialog = Nothing
    }


type Msg
    = Close
    | Show String


update : (Msg -> m) -> Msg -> Model -> ( Model, Cmd m )
update lift msg model =
    case msg of
        Close ->
            ( { model | openDialog = Nothing }, Cmd.none )

        Show index ->
            ( { model | openDialog = Just index }, Cmd.none )


heroDialog : (Msg -> m) -> String -> Model -> Html m
heroDialog lift index model =
    dialog
        { dialogConfig
            | open = True
            , additionalAttributes =
                [ Html.Attributes.style "position" "relative"
                , Html.Attributes.style "width" "320px"
                , Html.Attributes.style "z-index" "auto"
                ]
        }
        { title = "Get this party started?"
        , content =
            [ text "Turn up the jams and have a good time."
            ]
        , actions =
            [ button buttonConfig "Decline"
            , button buttonConfig "Accept"
            ]
        }


alertDialog : (Msg -> m) -> String -> Model -> Html m
alertDialog lift index model =
    dialog
        { dialogConfig
            | open = model.openDialog == Just index

            -- TODO: onClose = Just (lift Close)
        }
        { title = ""
        , content =
            [ text "Discard draft?" ]
        , actions =
            [ button { buttonConfig | onClick = Just (lift Close) } "Cancel"
            , button { buttonConfig | onClick = Just (lift Close) } "Discard"
            ]
        }


simpleDialog : (Msg -> m) -> String -> Model -> Html m
simpleDialog lift index model =
    dialog
        { dialogConfig
            | open = model.openDialog == Just index

            -- TODO: onClose = Just (lift Close)
        }
        { title = "Select an account"
        , content =
            [ list { listConfig | avatarList = True }
                [ listItem
                    { listItemConfig
                        | additionalAttributes =
                            [ Html.Attributes.tabindex 0
                            , Html.Events.onClick (lift Close)
                            ]
                    }
                    [ Lists.graphic
                        [ Html.Attributes.style "background-color" "rgba(0,0,0,.3)"
                        , Html.Attributes.style "color" "#fff"
                        ]
                        [ icon iconConfig "person" ]
                    , Lists.text [] [ text "user1@example.com" ]
                    ]
                , listItem
                    { listItemConfig
                        | additionalAttributes =
                            [ Html.Attributes.tabindex 0
                            , Html.Events.onClick (lift Close)
                            ]
                    }
                    [ Lists.graphic
                        [ Html.Attributes.style "background-color" "rgba(0,0,0,.3)"
                        , Html.Attributes.style "color" "#fff"
                        ]
                        [ icon iconConfig "person" ]
                    , Lists.text [] [ text "user2@example.com" ]
                    ]
                , listItem
                    { listItemConfig
                        | additionalAttributes =
                            [ Html.Attributes.tabindex 0
                            , Html.Events.onClick (lift Close)
                            ]
                    }
                    [ Lists.graphic
                        [ Html.Attributes.style "background-color" "rgba(0,0,0,.3)"
                        , Html.Attributes.style "color" "#fff"
                        ]
                        [ icon iconConfig "add" ]
                    , Lists.text [] [ text "Add account" ]
                    ]
                ]
            ]
        , actions = []
        }


confirmationDialog : (Msg -> m) -> String -> Model -> Html m
confirmationDialog lift index model =
    dialog
        { dialogConfig
            | open = model.openDialog == Just index

            -- TODO: onClose = Just (lift Close)
        }
        { title = "Phone ringtone"
        , content =
            [ list { listConfig | avatarList = True }
                [ listItem listItemConfig
                    [ Lists.graphic [] [ radio { radioConfig | checked = True } ]
                    , Lists.text [] [ text "Never Gonna Give You Up" ]
                    ]
                , listItem listItemConfig
                    [ Lists.graphic [] [ radio radioConfig ]
                    , Lists.text [] [ text "Hot Cross Buns" ]
                    ]
                , listItem listItemConfig
                    [ Lists.graphic [] [ radio radioConfig ]
                    , Lists.text [] [ text "None" ]
                    ]
                ]
            ]
        , actions =
            [ button { buttonConfig | onClick = Just (lift Close) } "Cancel"
            , button { buttonConfig | onClick = Just (lift Close) } "OK"
            ]
        }


scrollableDialog : (Msg -> m) -> String -> Model -> Html m
scrollableDialog lift index model =
    dialog
        { dialogConfig
            | open = model.openDialog == Just index

            -- TODO: onClose = Just (lift Close)
        }
        { title = "The Wonderful Wizard of Oz"
        , content =
            [ Html.p []
                [ text """
                    Dorothy lived in the midst of the great Kansas prairies,
                    with Uncle Henry, who was a farmer, and Aunt Em, who was
                    the farmer's wife. Their house was small, for the lumber to
                    build it had to be carried by wagon many miles. There were
                    four walls, a floor and a roof, which made one room; and
                    this room contained a rusty looking cookstove, a cupboard
                    for the dishes, a table, three or four chairs, and the
                    beds. Uncle Henry and Aunt Em had a big bed in one corner,
                    and Dorothy a little bed in another corner. There was no
                    garret at all, and no cellar--except a small hole dug in
                    the ground, called a cyclone cellar, where the family could
                    go in case one of those great whirlwinds arose, mighty
                    enough to crush any building in its path. It was reached by
                    a trap door in the middle of the floor, from which a ladder
                    led down into the small, dark hole.
                  """
                ]
            , Html.p []
                [ text """
                    When Dorothy stood in the doorway and looked around, she
                    could see nothing but the great gray prairie on every side.
                    Not a tree nor a house broke the broad sweep of flat
                    country that reached to the edge of the sky in all
                    directions.  The sun had baked the plowed land into a gray
                    mass, with little cracks running through it. Even the grass
                    was not green, for the sun had burned the tops of the long
                    blades until they were the same gray color to be seen
                    everywhere.  Once the house had been painted, but the sun
                    blistered the paint and the rains washed it away, and now
                    the house was as dull and gray as everything else.
                  """
                ]
            , Html.p []
                [ text """
                    When Aunt Em came there to live she was a young, pretty
                    wife. The sun and wind had changed her, too. They had taken
                    the sparkle from her eyes and left them a sober gray; they
                    had taken the red from her cheeks and lips, and they were
                    gray also. She was thin and gaunt, and never smiled now.
                    When Dorothy, who was an orphan, first came to her, Aunt Em
                    had been so startled by the child's laughter that she would
                    scream and press her hand upon her heart whenever Dorothy's
                    merry voice reached her ears; and she still looked at the
                    little girl with wonder that she could find anything to
                    laugh at.
                  """
                ]
            , Html.p []
                [ text """
                    Uncle Henry never laughed. He worked hard from morning till
                    night and did not know what joy was. He was gray also, from
                    his long beard to his rough boots, and he looked stern and
                    solemn, and rarely spoke.
                  """
                ]
            , Html.p []
                [ text """
                    It was Toto that made Dorothy laugh, and saved her from
                    growing as gray as her other surroundings. Toto was not
                    gray; he was a little black dog, with long silky hair and
                    small black eyes that twinkled merrily on either side of
                    his funny, wee nose. Toto played all day long, and Dorothy
                    played with him, and loved him dearly.
                  """
                ]
            , Html.p []
                [ text """
                    Today, however, they were not playing. Uncle Henry sat upon
                    the doorstep and looked anxiously at the sky, which was
                    even grayer than usual. Dorothy stood in the door with Toto
                    in her arms, and looked at the sky too. Aunt Em was washing
                    the dishes.
                  """
                ]
            , Html.p []
                [ text """
                    From the far north they heard a low wail of the wind, and
                    Uncle Henry and Dorothy could see where the long grass
                    bowed in waves before the coming storm.  There now came a
                    sharp whistling in the air from the south, and as they
                    turned their eyes that way they saw ripples in the grass
                    coming from that direction also.
                  """
                ]
            ]
        , actions =
            [ button { buttonConfig | onClick = Just (lift Close) } "Decline"
            , button { buttonConfig | onClick = Just (lift Close) } "Continue"
            ]
        }


view : (Msg -> m) -> Page m -> Model -> Html m
view lift page model =
    page.body "Dialog"
        "Dialogs inform users about a specific task and may contain critical information, require decisions, or involve multiple tasks."
        [ Hero.view []
            [ heroDialog lift "dialog-hero-dialog" model
            ]
        , Html.h2
            [ Typography.headline6
            , Html.Attributes.style "border-bottom" "1px solid rgba(0,0,0,.87)"
            ]
            [ text "Resources"
            ]
        , ResourceLink.view
            { link = "https://material.io/go/design-dialogs"
            , title = "Material Design Guidelines"
            , icon = "images/material.svg"
            , altText = "Material Design Guidelines icon"
            }
        , ResourceLink.view
            { link = "https://material.io/components/web/catalog/dialogs/"
            , title = "Documentation"
            , icon = "images/ic_drive_document_24px.svg"
            , altText = "Documentation icon"
            }
        , ResourceLink.view
            { link = "https://github.com/material-components/material-components-web/tree/master/packages/mdc-dialog"
            , title = "Source Code (Material Components Web)"
            , icon = "images/ic_code_24px.svg"
            , altText = "Source Code"
            }
        , Page.demos
            [ button
                { buttonConfig | onClick = Just (lift (Show "dialog-alert-dialog")) }
                "Alert"
            , text " "
            , button
                { buttonConfig | onClick = Just (lift (Show "dialog-simple-dialog")) }
                "Simple"
            , text " "
            , button
                { buttonConfig | onClick = Just (lift (Show "dialog-confirmation-dialog")) }
                "Confirmation"
            , text " "
            , button
                { buttonConfig | onClick = Just (lift (Show "dialog-scrollable-dialog")) }
                "Scrollable"
            , text " "
            , alertDialog lift "dialog-alert-dialog" model
            , simpleDialog lift "dialog-simple-dialog" model
            , confirmationDialog lift "dialog-confirmation-dialog" model
            , scrollableDialog lift "dialog-scrollable-dialog" model
            ]
        ]
