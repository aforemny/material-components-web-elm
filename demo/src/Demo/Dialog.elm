module Demo.Dialog exposing (Model, Msg(..), defaultModel, update, view)

import Demo.CatalogPage exposing (CatalogPage)
import Html exposing (Html, text)
import Html.Attributes exposing (class, style)
import Material.Button as Button
import Material.Dialog as Dialog
import Material.Icon as Icon
import Material.List as List
import Material.List.Item as ListItem
import Material.Radio as Radio
import Material.Select as Select
import Material.Select.Item as SelectItem
import Material.TextField as TextField


type Dialog
    = AlertDialog
    | ConfirmationDialog
    | ScrollableDialog
    | SimpleDialog
    | FullscreenDialog


type alias Model =
    { open : Maybe Dialog }


defaultModel : Model
defaultModel =
    { open = Nothing }


type Msg
    = Close
    | Show Dialog


update : Msg -> Model -> Model
update msg model =
    case msg of
        Close ->
            { model | open = Nothing }

        Show id ->
            { model | open = Just id }


view : Model -> CatalogPage Msg
view model =
    { title = "Dialog"
    , prelude = "Dialogs inform users about a specific task and may contain critical information, require decisions, or involve multiple tasks."
    , resources =
        { materialDesignGuidelines = Just "https://material.io/go/design-dialogs"
        , documentation = Just "https://package.elm-lang.org/packages/aforemny/material-components-web-elm/latest/Material-Dialog"
        , sourceCode = Just "https://github.com/material-components/material-components-web/tree/master/packages/mdc-dialog"
        }
    , hero = heroDialog
    , content =
        [ Button.text
            (Button.config |> Button.setOnClick (Show AlertDialog))
            "Alert"
        , text " "
        , Button.text
            (Button.config |> Button.setOnClick (Show SimpleDialog))
            "Simple"
        , text " "
        , Button.text
            (Button.config |> Button.setOnClick (Show ConfirmationDialog))
            "Confirmation"
        , text " "
        , Button.text
            (Button.config |> Button.setOnClick (Show ScrollableDialog))
            "Scrollable"
        , text " "
        , Button.text
            (Button.config |> Button.setOnClick (Show FullscreenDialog))
            "Fullscreen"
        , alertDialog model
        , simpleDialog model
        , confirmationDialog model
        , scrollableDialog model
        , fullscreenDialog model
        ]
    }


alertDialog : Model -> Html Msg
alertDialog model =
    Dialog.alert
        (Dialog.config
            |> Dialog.setOpen (model.open == Just AlertDialog)
            |> Dialog.setOnClose Close
        )
        { content = [ text "Discard draft?" ]
        , actions =
            [ Button.text
                (Button.config
                    |> Button.setOnClick Close
                    |> Button.setAttributes [ Dialog.defaultAction ]
                )
                "Cancel"
            , Button.text (Button.config |> Button.setOnClick Close) "Discard"
            ]
        }


simpleDialog : Model -> Html Msg
simpleDialog model =
    let
        listItem ( icon, label ) =
            ListItem.listItem
                (ListItem.config |> ListItem.setOnClick Close)
                [ ListItem.graphic
                    [ style "background-color" "rgba(0,0,0,.3)"
                    , style "color" "#fff"
                    ]
                    [ Icon.icon [] icon ]
                , text label
                ]
    in
    Dialog.simple
        (Dialog.config
            |> Dialog.setOpen (model.open == Just SimpleDialog)
            |> Dialog.setOnClose Close
        )
        { title = "Select an account"
        , content =
            [ List.list (List.config |> List.setAvatarList True)
                (listItem ( "person", "user1@example.com" ))
                (List.map listItem
                    [ ( "person", "user2@example.com" )
                    , ( "add", "Add account" )
                    ]
                )
            ]
        }


confirmationDialog : Model -> Html Msg
confirmationDialog model =
    let
        listItem ( checked, label ) =
            ListItem.listItem ListItem.config
                [ ListItem.graphic []
                    [ Radio.radio (Radio.config |> Radio.setChecked checked) ]
                , text label
                ]
    in
    Dialog.confirmation
        (Dialog.config
            |> Dialog.setOpen (model.open == Just ConfirmationDialog)
            |> Dialog.setOnClose Close
        )
        { title = "Phone ringtone"
        , content =
            [ List.list (List.config |> List.setAvatarList True)
                (listItem ( True, "Never Gonna Give You Up" ))
                (List.map listItem
                    [ ( False, "Hot Cross Buns" )
                    , ( False, "None" )
                    ]
                )
            ]
        , actions =
            [ Button.text
                (Button.config
                    |> Button.setOnClick Close
                    |> Button.setAttributes [ Dialog.defaultAction ]
                )
                "Cancel"
            , Button.text (Button.config |> Button.setOnClick Close) "OK"
            ]
        }


scrollableDialog : Model -> Html Msg
scrollableDialog model =
    Dialog.confirmation
        (Dialog.config
            |> Dialog.setOpen (model.open == Just ScrollableDialog)
            |> Dialog.setOnClose Close
        )
        { title = "The Wonderful Wizard of Oz"
        , content =
            [ Html.p []
                [ text """
Dorothy lived in the midst of the great Kansas prairies, with Uncle Henry, who
was a farmer, and Aunt Em, who was the farmer's wife. Their house was small,
for the lumber to build it had to be carried by wagon many miles. There were
four walls, a floor and a roof, which made one room; and this room contained a
rusty looking cookstove, a cupboard for the dishes, a table, three or four
chairs, and the beds. Uncle Henry and Aunt Em had a big bed in one corner, and
Dorothy a little bed in another corner. There was no garret at all, and no
cellar--except a small hole dug in the ground, called a cyclone cellar, where
the family could go in case one of those great whirlwinds arose, mighty enough
to crush any building in its path. It was reached by a trap door in the middle
of the floor, from which a ladder led down into the small, dark hole."""
                ]
            , Html.p []
                [ text """
When Dorothy stood in the doorway and looked around, she could see nothing but
the great gray prairie on every side.  Not a tree nor a house broke the broad
sweep of flat country that reached to the edge of the sky in all directions.
The sun had baked the plowed land into a gray mass, with little cracks running
through it. Even the grass was not green, for the sun had burned the tops of
the long blades until they were the same gray color to be seen everywhere.
Once the house had been painted, but the sun blistered the paint and the rains
washed it away, and now the house was as dull and gray as everything else."""
                ]
            , Html.p []
                [ text """
When Aunt Em came there to live she was a young, pretty wife. The sun and wind
had changed her, too. They had taken the sparkle from her eyes and left them a
sober gray; they had taken the red from her cheeks and lips, and they were gray
also. She was thin and gaunt, and never smiled now.  When Dorothy, who was an
orphan, first came to her, Aunt Em had been so startled by the child's laughter
that she would scream and press her hand upon her heart whenever Dorothy's
merry voice reached her ears; and she still looked at the little girl with
wonder that she could find anything to laugh at."""
                ]
            , Html.p []
                [ text """
Uncle Henry never laughed. He worked hard from morning till night and did not
know what joy was. He was gray also, from his long beard to his rough boots,
and he looked stern and solemn, and rarely spoke."""
                ]
            , Html.p []
                [ text """
It was Toto that made Dorothy laugh, and saved her from growing as gray as her
other surroundings. Toto was not gray; he was a little black dog, with long
silky hair and small black eyes that twinkled merrily on either side of his
funny, wee nose. Toto played all day long, and Dorothy played with him, and
loved him dearly."""
                ]
            , Html.p []
                [ text """
Today, however, they were not playing. Uncle Henry sat upon the doorstep and
looked anxiously at the sky, which was even grayer than usual. Dorothy stood in
the door with Toto in her arms, and looked at the sky too. Aunt Em was washing
the dishes."""
                ]
            , Html.p []
                [ text """
From the far north they heard a low wail of the wind, and Uncle Henry and
Dorothy could see where the long grass bowed in waves before the coming storm.
There now came a sharp whistling in the air from the south, and as they turned
their eyes that way they saw ripples in the grass coming from that direction
also."""
                ]
            ]
        , actions =
            [ Button.text (Button.config |> Button.setOnClick Close) "Decline"
            , Button.text
                (Button.config
                    |> Button.setOnClick Close
                    |> Button.setAttributes [ Dialog.defaultAction ]
                )
                "Continue"
            ]
        }


fullscreenDialog : Model -> Html Msg
fullscreenDialog model =
    Dialog.fullscreen
        (Dialog.config
            |> Dialog.setOpen (model.open == Just FullscreenDialog)
            |> Dialog.setOnClose Close
            |> Dialog.setAttributes [ class "fullscreen-dialog" ]
        )
        { title = "Create New Event"
        , content =
            Html.node "style"
                [ Html.Attributes.type_ "text/css" ]
                [ text """
.fullscreen-dialog .mdc-dialog__surface {
  width: 560px; }
.fullscreen-dialog .mdc-dialog__content {
  flex-flow; colum;
  align-items: stretch; }
.fullscreen-dialog .mdc-select__anchor {
  width: 100%; }
.fullscreen-dialog .mdc-dialog__content > * {
  margin-bottom: 20px; }
.fullscreen-dialog .mdc-dialog__content > *:last-child {
  margin-bottom: 0; }
.fullscreen-dialog .mdc-dialog__content > div {
  display: flex;
  flex-flow: row nowrap; }
.fullscreen-dialog .mdc-dialog__content > div > :nth-child(1) {
  flex: 2 1 0; }
.fullscreen-dialog .mdc-dialog__content > div > :nth-child(2) {
  flex: 1 1 0;
  margin-left: 20px;}
}
""" ]
                :: List.map (Html.div [])
                    [ [ Select.outlined
                            (Select.config
                                |> Select.setSelected (Just "")
                                |> Select.setAttributes [ Dialog.initialFocus ]
                            )
                            (SelectItem.selectItem
                                (SelectItem.config { value = "" })
                                "heyfromelizabeth@gmail.com"
                            )
                            []
                      ]
                    , [ TextField.outlined
                            (TextField.config
                                |> TextField.setLabel (Just "Event Name")
                                |> TextField.setValue (Just "Liam's B-day Party")
                            )
                      ]
                    , [ TextField.outlined
                            (TextField.config
                                |> TextField.setLabel (Just "Location")
                                |> TextField.setValue
                                    (Just "123 Main Street, San Francisco, CA 94107")
                            )
                      ]
                    , [ Select.outlined
                            (Select.config
                                |> Select.setLabel (Just "From")
                                |> Select.setSelected (Just "")
                            )
                            (SelectItem.selectItem (SelectItem.config { value = "" })
                                "Mon, March 26"
                            )
                            []
                      , Select.outlined
                            (Select.config
                                |> Select.setSelected (Just "")
                            )
                            (SelectItem.selectItem (SelectItem.config { value = "" })
                                ""
                            )
                            []
                      ]
                    , [ Select.outlined
                            (Select.config
                                |> Select.setLabel (Just "To")
                                |> Select.setSelected (Just "")
                            )
                            (SelectItem.selectItem (SelectItem.config { value = "" })
                                ""
                            )
                            []
                      , Select.outlined
                            (Select.config
                                |> Select.setSelected (Just "")
                            )
                            (SelectItem.selectItem (SelectItem.config { value = "" })
                                ""
                            )
                            []
                      ]
                    , [ Select.outlined
                            (Select.config
                                |> Select.setLabel (Just "Timezone")
                                |> Select.setSelected (Just "")
                            )
                            (SelectItem.selectItem
                                (SelectItem.config { value = "" })
                                "Pacific Standard Time"
                            )
                            []
                      ]
                    ]
        , actions =
            [ Button.text (Button.config |> Button.setOnClick Close)
                "Cancel"
            , Button.text
                (Button.config
                    |> Button.setOnClick Close
                    |> Button.setAttributes [ Dialog.defaultAction ]
                )
                "Save"
            ]
        }


heroDialog : List (Html Msg)
heroDialog =
    [ Html.div
        [ class "mdc-dialog mdc-dialog--open"
        , style "position" "relative"
        , style "z-index" "0"
        ]
        [ Html.div
            [ class "mdc-dialog__surface" ]
            [ Html.div [ class "mdc-dialog__title" ]
                [ text "Get this party started?" ]
            , Html.div [ class "mdc-dialog__content" ]
                [ text "Turn up the jams and have a good time." ]
            , Html.div [ class "mdc-dialog__actions" ]
                [ Button.text Button.config "Decline"
                , Button.text Button.config "Accept"
                ]
            ]
        ]
    ]
