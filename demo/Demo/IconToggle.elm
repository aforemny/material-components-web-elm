module Demo.IconToggle exposing (Model, Msg(..), defaultModel, update, view)

import Demo.Helper.Hero as Hero
import Demo.Helper.ResourceLink as ResourceLink
import Demo.Page as Page exposing (Page)
import Dict exposing (Dict)
import Html exposing (Html, text)
import Html.Attributes
import Html.Events
import Material.IconToggle as IconToggle
import Material.Typography as Typography


type alias Model =
    { iconToggles : Dict String Bool
    }


defaultModel : Model
defaultModel =
    { iconToggles = Dict.empty
    }


type Msg
    = Toggle String


update : (Msg -> m) -> Msg -> Model -> ( Model, Cmd m )
update lift msg model =
    case msg of
        Toggle index ->
            let
                iconToggles =
                    Dict.update index
                        (\state ->
                            Just <|
                                case state of
                                    Just True ->
                                        False

                                    _ ->
                                        True
                        )
                        model.iconToggles
            in
            ( { model | iconToggles = iconToggles }, Cmd.none )


iconToggle :
    (Msg -> m)
    -> String
    -> Model
    -> String
    -> String
    -> Html m
iconToggle lift index model offIcon onIcon =
    let
        isOn =
            Dict.get index model.iconToggles
                |> Maybe.withDefault False
    in
    IconToggle.view lift
        index
        model.mdc
        [ IconToggle.icon { on = onIcon, off = offIcon }
        , Html.Events.onClick (lift (Toggle index))
        , when isOn IconToggle.on
        ]
        []


iconButton :
    (Msg -> m)
    -> String
    -> Model
    -> String
    -> Html m
iconButton lift index model icon =
    iconToggle lift index model icon icon


view : (Msg -> m) -> Page m -> Model -> Html m
view lift page model =
    page.body "Icon Button"
        "Icons are appropriate for buttons that allow a user to take actions or make a selection, such as adding or removing a star to an item."
        [ Hero.view []
            [ iconToggle lift
                "icon-toggle-hero-icon-toggle"
                model
                "favorite_border"
                "favorite"
            ]
        , Html.h2
            [ Typography.headline6
            , Html.Attributes.style "border-bottom" "1px solid rgba(0,0,0,.87)"
            ]
            [ text "Resources"
            ]
        , ResourceLink.view
            { link = "https://material.io/design/components/buttons.html#toggle-button"
            , title = "Material Design Guidelines"
            , icon = "images/material.svg"
            , altText = "Material Design Guidelines icon"
            }
        , ResourceLink.view
            { link = "https://material.io/components/web/catalog/buttons/icon-buttons/"
            , title = "Documentation"
            , icon = "images/ic_drive_document_24px.svg"
            , altText = "Documentation icon"
            }
        , ResourceLink.view
            { link = "https://github.com/material-components/material-components-web/tree/master/packages/mdc-icon-button"
            , title = "Source Code (Material Components Web)"
            , icon = "images/ic_code_24px.svg"
            , altText = "Source Code"
            }
        , Page.demos
            [ Html.h3 [ Typography.subtitle1 ] [ text "Icon Button" ]
            , iconButton lift "icon-toggle-icon-button" model "wifi"
            , Html.h3 [ Typography.subtitle1 ] [ text "Icon Toggle" ]
            , iconToggle lift "icon-toggle-icon-toggle" model "favorite_border" "favorite"
            ]
        ]
