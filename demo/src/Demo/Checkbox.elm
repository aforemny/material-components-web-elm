module Demo.Checkbox exposing (Model, Msg(..), defaultModel, update, view)

import Demo.CatalogPage as Page exposing (CatalogPage)
import Demo.Helper.ResourceLink as ResourceLink
import Dict exposing (Dict)
import Html exposing (Html, text)
import Html.Attributes exposing (style)
import Material.Checkbox as Checkbox
import Material.Typography as Typography
import Platform.Cmd exposing (Cmd, none)


type alias Model =
    { checkboxes : Dict String Checkbox.State }


defaultModel : Model
defaultModel =
    { checkboxes =
        Dict.fromList
            [ ( "checked-hero-checkbox", Checkbox.checked )
            , ( "unchecked-hero-checkbox", Checkbox.unchecked )
            , ( "unchecked-checkbox", Checkbox.unchecked )
            , ( "checked-checkbox", Checkbox.checked )
            ]
    }


type Msg
    = Changed String


update : Msg -> Model -> Model
update msg model =
    case msg of
        Changed index ->
            let
                checkboxes =
                    Dict.update index
                        (\state ->
                            if state == Just Checkbox.checked then
                                Just Checkbox.unchecked

                            else
                                Just Checkbox.checked
                        )
                        model.checkboxes
            in
            { model | checkboxes = checkboxes }


view : Model -> CatalogPage Msg
view model =
    { title = "Checkbox"
    , prelude = "Checkboxes allow the user to select multiple options from a set."
    , resources =
        { materialDesignGuidelines = Just "https://material.io/go/design-checkboxes"
        , documentation = Just "https://package.elm-lang.org/packages/aforemny/material-components-web-elm/latest/Material-Checkbox"
        , sourceCode = Just "https://github.com/material-components/material-components-web/tree/master/packages/mdc-checkbox"
        }
    , hero = heroCheckboxes model
    , content =
        [ Html.h3 [ Typography.subtitle1 ] [ text "Unchecked" ]
        , checkbox "unchecked-checkbox" model []
        , Html.h3 [ Typography.subtitle1 ] [ text "Indeterminate" ]
        , checkbox "indeterminate-checkbox" model []
        , Html.h3 [ Typography.subtitle1 ] [ text "Checked" ]
        , checkbox "checked-checkbox" model []
        ]
    }


heroCheckboxes : Model -> List (Html Msg)
heroCheckboxes model =
    [ checkbox "checked-hero-checkbox" model heroMargin
    , checkbox "unchecked-hero-checkbox" model heroMargin
    ]


checkbox : String -> Model -> List (Html.Attribute Msg) -> Html Msg
checkbox index model attributes =
    let
        state =
            Dict.get index model.checkboxes
                |> Maybe.withDefault Checkbox.indeterminate
    in
    Checkbox.checkbox
        (Checkbox.config
            |> Checkbox.setState (Just state)
            |> Checkbox.setOnChange (Changed index)
            |> Checkbox.setAttributes attributes
        )


heroMargin : List (Html.Attribute msg)
heroMargin =
    [ style "margin" "8px 16px" ]
