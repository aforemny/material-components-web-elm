module Demo.IconButton exposing (Model, Msg(..), defaultModel, update, view)

import Demo.Helper.ResourceLink as ResourceLink
import Demo.Page as Page exposing (Page)
import Dict exposing (Dict)
import Html exposing (Html, text)
import Html.Attributes
import Html.Events
import Material.IconButton as IconButton exposing (iconButton, iconButtonConfig, iconToggle, iconToggleConfig)
import Material.Typography as Typography


type alias Model =
    { iconButtons : Dict String Bool
    }


defaultModel : Model
defaultModel =
    { iconButtons = Dict.empty
    }


type Msg
    = Toggle String


update : (Msg -> m) -> Msg -> Model -> ( Model, Cmd m )
update lift msg model =
    case msg of
        Toggle index ->
            let
                iconButtons =
                    Dict.update index
                        (\state -> Just (not (Maybe.withDefault False state)))
                        model.iconButtons
            in
            ( { model | iconButtons = iconButtons }, Cmd.none )


isOn : String -> Model -> Bool
isOn index model =
    Maybe.withDefault False (Dict.get index model.iconButtons)


view : (Msg -> m) -> Page m -> Model -> Html m
view lift page model =
    page.body "Icon Button"
        "Icons are appropriate for buttons that allow a user to take actions or make a selection, such as adding or removing a star to an item."
        [ Page.hero []
            [ iconToggle
                { iconToggleConfig
                    | on = isOn "icon-button-hero" model
                    , onClick = Just (lift (Toggle "icon-button-hero"))
                }
                { off = "favorite_border"
                , on = "favorite"
                }
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
            , iconButton
                { iconButtonConfig | onClick = Just (lift (Toggle "icon-button")) }
                "wifi"
            , Html.h3 [ Typography.subtitle1 ] [ text "Icon Button" ]
            , iconToggle
                { iconToggleConfig
                    | on = isOn "icon-button-toggle" model
                    , onClick = Just (lift (Toggle "icon-button-toggle"))
                }
                { off = "favorite_border"
                , on = "favorite"
                }
            ]
        ]
