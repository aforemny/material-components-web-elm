module Demo.DenseTopAppBar exposing (Model, Msg(..), defaultModel, update, view)

import Demo.TopAppBarPage exposing (TopAppBarPage)
import Demo.Url as Url
import Dict exposing (Dict)
import Html exposing (Html, text)
import Html.Attributes
import Html.Events
import Material.IconButton as IconButton
import Material.TopAppBar as TopAppBar
import Material.Typography as Typography


type alias Model =
    {}


defaultModel : Model
defaultModel =
    {}


type Msg
    = NoOp


update : Msg -> Model -> Model
update msg model =
    model


view : Model -> TopAppBarPage Msg
view model =
    { fixedAdjust = TopAppBar.denseFixedAdjust
    , topAppBar =
        TopAppBar.regular (TopAppBar.config |> TopAppBar.setDense True)
            [ TopAppBar.row []
                [ TopAppBar.section
                    [ TopAppBar.alignStart ]
                    [ IconButton.iconButton
                        (IconButton.config
                            |> IconButton.setAttributes [ TopAppBar.navigationIcon ]
                        )
                        "menu"
                    , Html.span [ TopAppBar.title ] [ text "Dense" ]
                    ]
                , TopAppBar.section
                    [ TopAppBar.alignEnd ]
                    [ IconButton.iconButton
                        (IconButton.config
                            |> IconButton.setAttributes [ TopAppBar.actionItem ]
                        )
                        "file_download"
                    , IconButton.iconButton
                        (IconButton.config
                            |> IconButton.setAttributes [ TopAppBar.actionItem ]
                        )
                        "print"
                    , IconButton.iconButton
                        (IconButton.config
                            |> IconButton.setAttributes [ TopAppBar.actionItem ]
                        )
                        "bookmark"
                    ]
                ]
            ]
    }
