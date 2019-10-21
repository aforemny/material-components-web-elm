module Demo.Buttons exposing (Model, Msg, defaultModel, update, view)

import Demo.CatalogPage exposing (CatalogPage)
import Demo.Helper.ResourceLink as ResourceLink
import Html exposing (Html, text)
import Html.Attributes
import Material.Button exposing (ButtonConfig, buttonConfig, outlinedButton, raisedButton, textButton, unelevatedButton)
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
    [ textButton { buttonConfig | additionalAttributes = heroMargin } "Text"
    , raisedButton { buttonConfig | additionalAttributes = heroMargin } "Raised"
    , unelevatedButton { buttonConfig | additionalAttributes = heroMargin } "Unelevated"
    , outlinedButton { buttonConfig | additionalAttributes = heroMargin } "Outlined"
    ]


textButtons : Html msg
textButtons =
    buttonsRow textButton buttonConfig


raisedButtons : Html msg
raisedButtons =
    buttonsRow raisedButton buttonConfig


unelevatedButtons : Html msg
unelevatedButtons =
    buttonsRow unelevatedButton buttonConfig


outlinedButtons : Html msg
outlinedButtons =
    buttonsRow outlinedButton buttonConfig


shapedButtons : Html msg
shapedButtons =
    buttonsRow unelevatedButton
        { buttonConfig
            | additionalAttributes = [ Html.Attributes.style "border-radius" "18px" ]
        }


buttonsRow : (ButtonConfig msg -> String -> Html msg) -> ButtonConfig msg -> Html msg
buttonsRow button buttonConfig =
    Html.div []
        [ button
            { buttonConfig
                | additionalAttributes = buttonConfig.additionalAttributes ++ rowMargin
            }
            "Default"
        , button
            { buttonConfig
                | dense = True
                , additionalAttributes = buttonConfig.additionalAttributes ++ rowMargin
            }
            "Dense"
        , button
            { buttonConfig
                | icon = Just "favorite"
                , additionalAttributes = buttonConfig.additionalAttributes ++ rowMargin
            }
            "Icon"
        ]


heroMargin : List (Html.Attribute msg)
heroMargin =
    [ Html.Attributes.style "margin" "16px 32px" ]


rowMargin : List (Html.Attribute msg)
rowMargin =
    [ Html.Attributes.style "margin" "8px 16px" ]
