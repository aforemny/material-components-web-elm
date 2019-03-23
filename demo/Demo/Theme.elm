module Demo.Theme exposing (Model, Msg, defaultModel, update, view)

import Demo.Page as Page exposing (Page)
import Html exposing (Html, text)
import Html.Attributes
import Material.Button as Button exposing (button, buttonConfig)
import Material.Theme as Theme
import Material.Typography as Typography


type alias Model =
    {}


defaultModel : Model
defaultModel =
    {}


type Msg
    = NoOp


update : (Msg -> m) -> Msg -> Model -> ( Model, Cmd m )
update lift msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )


view : (Msg -> m) -> Page m -> Model -> Html m
view lift page model =
    page.body "Theme"
        "Color in Material Design is inspired by bold hues juxtaposed with muted environments, deep shadows, and bright highlights."
        [ Page.hero []
            [ button
                { buttonConfig
                    | variant = Button.Raised
                    , additionalAttributes =
                        [ Html.Attributes.style "margin" "24px" ]
                }
                "Primary"
            , button
                { buttonConfig
                    | variant = Button.Raised
                    , additionalAttributes =
                        [ Html.Attributes.style "margin" "24px" ]
                }
                "Secondary"
            ]
        ]
