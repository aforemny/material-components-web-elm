module Demo.FixedTopAppBar exposing (Model, Msg(..), defaultModel, update, view)

import Demo.TopAppBarPage exposing (TopAppBarPage)
import Demo.Url as Url
import Dict exposing (Dict)
import Html exposing (Html, text)
import Html.Attributes
import Html.Events
import Material.Icon exposing (icon, iconConfig)
import Material.TopAppBar as TopAppBar exposing (prominentTopAppBar, shortCollapsedTopAppBar, shortTopAppBar, topAppBar, topAppBarConfig)
import Material.Typography as Typography


type alias Model =
    {}


type alias Example =
    {}


defaultExample : Example
defaultExample =
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
    { fixedAdjust = TopAppBar.fixedAdjust
    , topAppBar =
        topAppBar { topAppBarConfig | fixed = True }
            [ TopAppBar.row []
                [ TopAppBar.section
                    [ TopAppBar.alignStart
                    ]
                    [ icon
                        { iconConfig
                            | additionalAttributes = [ TopAppBar.navigationIcon ]
                        }
                        "menu"
                    , Html.span [ TopAppBar.title ] [ text "Fixed" ]
                    ]
                , TopAppBar.section
                    [ TopAppBar.alignEnd
                    ]
                    [ icon
                        { iconConfig | additionalAttributes = [ TopAppBar.actionItem ] }
                        "file_download"
                    , icon
                        { iconConfig | additionalAttributes = [ TopAppBar.actionItem ] }
                        "print"
                    , icon
                        { iconConfig | additionalAttributes = [ TopAppBar.actionItem ] }
                        "bookmark"
                    ]
                ]
            ]
    }
