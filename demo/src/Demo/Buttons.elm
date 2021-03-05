module Demo.Buttons exposing (Model, Msg, defaultModel, update, view)

import Browser.Dom
import Demo.CatalogPage exposing (CatalogPage)
import Demo.ElmLogo exposing (elmLogo)
import Html exposing (Html, text)
import Html.Attributes exposing (class, style)
import Material.Button as Button
import Material.Typography as Typography
import Svg.Attributes
import Task


type alias Model =
    {}


defaultModel : Model
defaultModel =
    {}


type Msg
    = Focus String
    | Focused (Result Browser.Dom.Error ())


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Focus id ->
            ( model, Task.attempt Focused (Browser.Dom.focus id) )

        Focused _ ->
            ( model, Cmd.none )


view : Model -> CatalogPage Msg
view model =
    { title = "Button"
    , prelude = "Buttons communicate an action a user can take. They are typically placed throughout your UI, in places like dialogs, forms, cards, and toolbars."
    , resources =
        { materialDesignGuidelines =
            Just "https://material.io/go/design-buttons"
        , documentation =
            Just "https://package.elm-lang.org/packages/aforemny/material-components-web-elm/latest/Material-Button"
        , sourceCode =
            Just "https://github.com/material-components/material-components-web/tree/master/packages/mdc-button"
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
        , Html.h3 [ Typography.subtitle1 ] [ text "Link Button" ]
        , linkButtons
        , Html.h3 [ Typography.subtitle1 ] [ text "Button with Custom Icon" ]
        , customIconButtons
        , Html.h3 [ Typography.subtitle1 ] [ text "Focus Button" ]
        , focusButton
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


linkButtons : Html msg
linkButtons =
    buttonsRow
        (\config label ->
            Button.text (config |> Button.setHref (Just "#buttons")) label
        )
        []


customIconButtons : Html msg
customIconButtons =
    let
        config icon =
            Button.config
                |> Button.setAttributes [ rowMargin ]
                |> Button.setIcon (Just icon)
    in
    Html.div []
        [ Button.raised (config (Button.icon "favorite")) "Material Icon"
        , Button.raised
            (config (Button.customIcon Html.i [ class "fab fa-font-awesome" ] []))
            "Font Awesome"
        , Button.raised
            (config
                (Button.svgIcon [ Svg.Attributes.viewBox "0 0 100 100" ] elmLogo)
            )
            "SVG"
        ]


focusButton : Html Msg
focusButton =
    Html.div []
        [ Button.raised
            (Button.config
                |> Button.setAttributes [ Html.Attributes.id "my-button" ]
            )
            "Button"
        , text "\u{00A0}"
        , Button.raised (Button.config |> Button.setOnClick (Focus "my-button"))
            "Focus"
        , text "\u{00A0}"
        , Button.raised
            (Button.config
                |> Button.setHref (Just "#buttons")
                |> Button.setAttributes [ Html.Attributes.id "my-link-button" ]
            )
            "Link button"
        , text "\u{00A0}"
        , Button.raised (Button.config |> Button.setOnClick (Focus "my-link-button"))
            "Focus"
        ]


buttonsRow :
    (Button.Config msg -> String -> Html msg)
    -> List (Html.Attribute msg)
    -> Html msg
buttonsRow button additionalAttributes =
    let
        config =
            Button.config
                |> Button.setAttributes (rowMargin :: additionalAttributes)
    in
    Html.div []
        [ button config "Default"
        , button (config |> Button.setDense True) "Dense"
        , button (config |> Button.setIcon (Just (Button.icon "favorite"))) "Icon"
        , button (config |> Button.setDisabled True) "Disabled"
        ]


heroMargin : Html.Attribute msg
heroMargin =
    style "margin" "16px 32px"


rowMargin : Html.Attribute msg
rowMargin =
    style "margin" "8px 16px"
