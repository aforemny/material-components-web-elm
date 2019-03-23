module Demo.Checkbox exposing (Model, Msg(..), defaultModel, update, view)

import Demo.Helper.Hero as Hero
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
    { checkboxes : Dict String (Maybe Bool)
    }


defaultModel : Model
defaultModel =
    { checkboxes =
        Dict.fromList
            [ ( "checkbox-checked-hero-checkbox", Just True )
            , ( "checkbox-unchecked-hero-checkbox", Just False )
            , ( "checkbox-unchecked-checkbox", Just False )
            , ( "checkbox-checked-checkbox", Just True )
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
                            Just <|
                                case Maybe.withDefault Nothing state of
                                    Just True ->
                                        Just False

                                    _ ->
                                        Just True
                        )
                        model.checkboxes
            in
            ( { model | checkboxes = checkboxes }, Cmd.none )


checkbox_ : (Msg -> m) -> String -> Model -> List (Html.Attribute m) -> Html m
checkbox_ lift index model additionalAttributes =
    checkbox
        { checkboxConfig
            | state =
                case Maybe.withDefault Nothing (Dict.get index model.checkboxes) of
                    Just True ->
                        Checkbox.Checked

                    Just False ->
                        Checkbox.Unchecked

                    Nothing ->
                        Checkbox.Indeterminate
            , onClick =
                Just (lift (Click index))
            , additionalAttributes = additionalAttributes
        }


view : (Msg -> m) -> Page m -> Model -> Html m
view lift page model =
    page.body "Checkbox"
        "Checkboxes allow the user to select multiple options from a set."
        [ Hero.view []
            [ checkbox_ lift
                "checkbox-checked-hero-checkbox"
                model
                [ Html.Attributes.style "margin" "8px" ]
            , checkbox_ lift
                "checkbox-unchecked-hero-checkbox"
                model
                [ Html.Attributes.style "margin" "8px" ]
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
            , checkbox_ lift "checkbox-unchecked-checkbox" model []
            , Html.h3 [ Typography.subtitle1 ] [ text "Indeterminate" ]
            , checkbox_ lift "checkbox-indeterminate-checkbox" model []
            , Html.h3 [ Typography.subtitle1 ] [ text "Checked" ]
            , checkbox_ lift "checkbox-checked-checkbox" model []
            ]
        ]
