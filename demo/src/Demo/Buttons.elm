module Demo.Buttons exposing (Model, Msg, defaultModel, update, view)

import Demo.CatalogPage exposing (CatalogPage)
import Demo.Helper.ResourceLink as ResourceLink
import Html exposing (Html, text)
import Html.Attributes exposing (style)
import Material.Button as Button
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
    { title = "Button"
    , prelude = "Buttons communicate an action a user can take. They are typically placed throughout your UI, in places like dialogs, forms, cards, and toolbars."
    , resources =
        { materialDesignGuidelines = Just "https://material.io/go/design-buttons"
        , documentation = Just "https://package.elm-lang.org/packages/aforemny/material-components-web-elm/latest/Material-Button"
        , sourceCode = Just "https://github.com/material-components/material-components-web/tree/master/packages/mdc-button"
        }
    , hero = heroButtons
    , content =
        [ Html.h3 [ Typography.subtitle1 ] [ text "Text Button" ]
        , textButtons
        , Html.h3 [ Typography.subtitle1 ] [ text "Raised Button" ]
        , raisedButtons
        , Html.h3 [ Typography.subtitle1 ] [ text "Unelevated Button" ]
        , unelevatedButtons
        , Html.h3 [ Typography.subtitle1 ] [ text "Outlined Button" ]
        , outlinedButtons
        , Html.h3 [ Typography.subtitle1 ] [ text "Shaped Button" ]
        , shapedButtons
        ]
    }


heroButtons : List (Html msg)
heroButtons =
    let
        config =
            Button.config |> Button.setAttributes [ heroMargin ]
    in
    [ Button.text config "Text"
    , Button.raised config "Raised"
    , Button.unelevated config "Unelevated"
    , Button.outlined config "Outlined"
    ]


textButtons : Html msg
textButtons =
    buttonsRow Button.text []


raisedButtons : Html msg
raisedButtons =
    buttonsRow Button.raised []


unelevatedButtons : Html msg
unelevatedButtons =
    buttonsRow Button.unelevated []


outlinedButtons : Html msg
outlinedButtons =
    buttonsRow Button.outlined []


shapedButtons : Html msg
shapedButtons =
    buttonsRow Button.unelevated [ style "border-radius" "18px" ]


buttonsRow : (Button.Config msg -> String -> Html msg) -> List (Html.Attribute msg) -> Html msg
buttonsRow button additionalAttributes =
    let
        config =
            Button.config
                |> Button.setAttributes (rowMargin :: additionalAttributes)
    in
    Html.div []
        [ button config "Default"
        , button (config |> Button.setDense True) "Dense"
        , button (config |> Button.setIcon (Just "favorite")) "Icon"
        ]


heroMargin : Html.Attribute msg
heroMargin =
    style "margin" "16px 32px"


rowMargin : Html.Attribute msg
rowMargin =
    style "margin" "8px 16px"
