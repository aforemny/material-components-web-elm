module Demo.Typography exposing (Model, Msg, defaultModel, update, view)

import Demo.CatalogPage exposing (CatalogPage)
import Demo.Helper.ResourceLink as ResourceLink
import Html exposing (Html, text)
import Html.Attributes
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


view : Model -> CatalogPage Msg
view model =
    { title = "Typography"
    , prelude = "Roboto is the standard typeface on Android and Chrome."
    , resources =
        { materialDesignGuidelines = Just "https://material.io/go/design-typography"
        , documentation = Just "https://package.elm-lang.org/packages/aforemny/material-components-web-elm/latest/Material-Typography"
        , sourceCode = Just "https://github.com/material-components/material-components-web/tree/master/packages/mdc-typography"
        }
    , hero = [ Html.h1 [ Typography.headline1 ] [ text "Typography" ] ]
    , content =
        [ Html.h1 [ Typography.headline1 ] [ text "Headline 1" ]
        , Html.h2 [ Typography.headline2 ] [ text "Headline 2" ]
        , Html.h3 [ Typography.headline3 ] [ text "Headline 3" ]
        , Html.h4 [ Typography.headline4 ] [ text "Headline 4" ]
        , Html.h5 [ Typography.headline5 ] [ text "Headline 5" ]
        , Html.h6 [ Typography.headline6 ] [ text "Headline 6" ]
        , Html.h6 [ Typography.subtitle1 ] [ text "Subtitle 1" ]
        , Html.h6 [ Typography.subtitle2 ] [ text "Subtitle 2" ]
        , Html.p [ Typography.body1 ] [ text body1Paragraph ]
        , Html.p [ Typography.body2 ] [ text body2Paragraph ]
        , Html.div [ Typography.button ] [ text "Button text" ]
        , Html.div [ Typography.caption ] [ text "Caption text" ]
        , Html.div [ Typography.overline ] [ text "Overline text" ]
        ]
    }


body1Paragraph =
    "Body 1. Lorem ipsum dolor sit amet, consectetur adipisicing elit. Quos blanditiis tenetur unde suscipit, quam beatae rerum inventore consectetur, neque doloribus, cupiditate numquam dignissimos laborum fugiat deleniti? Eum quasi quidem quibusdam."


body2Paragraph =
    "Body 2. Lorem ipsum dolor sit amet consectetur adipisicing elit. Cupiditate aliquid ad quas sunt voluptatum officia dolorum cumque, possimus nihil molestias sapiente necessitatibus dolor saepe inventore, soluta id accusantium voluptas beatae."
