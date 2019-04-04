module Demo.Checkbox exposing (Model, Msg(..), defaultModel, update, view)

import Demo.Helper.ResourceLink as ResourceLink
import Demo.Page as Page exposing (Page)
import Dict exposing (Dict)
import Html exposing (Html, text)
import Html.Attributes
import Material.Button as Button
import Material.Checkbox as Checkbox exposing (checkbox, checkboxConfig)
import Material.Typography as Typography
import Platform.Cmd exposing (Cmd, none)


type alias Model =
    { checkboxes : Dict String Checkbox.State
    }


defaultModel : Model
defaultModel =
    { checkboxes =
        Dict.fromList
            [ ( "checkbox-checked-hero-checkbox", Checkbox.Checked )
            , ( "checkbox-unchecked-hero-checkbox", Checkbox.Unchecked )
            , ( "checkbox-unchecked-checkbox", Checkbox.Unchecked )
            , ( "checkbox-checked-checkbox", Checkbox.Checked )
            ]
    }


type Msg
    = Click String


update : (Msg -> m) -> Msg -> Model -> ( Model, Cmd m )
update lift msg model =
    case msg of
        Click index ->
            let
                checkboxes =
                    Dict.update index
                        (\state ->
                            if state == Just Checkbox.Checked then
                                Just Checkbox.Unchecked

                            else
                                Just Checkbox.Checked
                        )
                        model.checkboxes
            in
            ( { model | checkboxes = checkboxes }, Cmd.none )


controlledCheckbox : (Msg -> m) -> String -> Model -> List (Html.Attribute m) -> Html m
controlledCheckbox lift index model additionalAttributes =
    let
        state =
            Maybe.withDefault Checkbox.Indeterminate (Dict.get index model.checkboxes)
    in
    checkbox
        { checkboxConfig
            | state = state
            , onClick = Just (lift (Click index))
            , additionalAttributes = additionalAttributes
        }


heroMargin : List (Html.Attribute m)
heroMargin =
    [ Html.Attributes.style "margin" "8px" ]


view : (Msg -> m) -> Page m -> Model -> Html m
view lift page model =
    page.body "Checkbox"
        "Checkboxes allow the user to select multiple options from a set."
        [ Page.hero []
            [ controlledCheckbox lift "checkbox-checked-hero-checkbox" model heroMargin
            , controlledCheckbox lift "checkbox-unchecked-hero-checkbox" model heroMargin
            ]
        , Html.h2
            [ Typography.headline6
            , Html.Attributes.style "border-bottom" "1px solid rgba(0,0,0,.87)"
            ]
            [ text "Resources"
            ]
        , ResourceLink.view
            { link = "https://material.io/go/design-checkboxes"
            , title = "Material Design Guidelines"
            , icon = "images/material.svg"
            , altText = "Material Design Guidelines icon"
            }
        , ResourceLink.view
            { link = "https://material.io/components/web/catalog/input-controls/checkboxes/"
            , title = "Documentation"
            , icon = "images/ic_drive_document_24px.svg"
            , altText = "Documentation icon"
            }
        , ResourceLink.view
            { link = "https://github.com/material-components/material-components-web/tree/master/packages/mdc-checkbox"
            , title = "Source Code (Material Components Web)"
            , icon = "images/ic_code_24px.svg"
            , altText = "Source Code"
            }
        , Page.demos
            [ Html.h3 [ Typography.subtitle1 ] [ text "Unchecked" ]
            , controlledCheckbox lift "checkbox-unchecked-checkbox" model []
            , Html.h3 [ Typography.subtitle1 ] [ text "Indeterminate" ]
            , controlledCheckbox lift "checkbox-indeterminate-checkbox" model []
            , Html.h3 [ Typography.subtitle1 ] [ text "Checked" ]
            , controlledCheckbox lift "checkbox-checked-checkbox" model []
            ]
        ]
