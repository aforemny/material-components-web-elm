module Demo.IconButton exposing (Model, Msg(..), defaultModel, update, view)

import Demo.CatalogPage exposing (CatalogPage)
import Demo.Helper.ResourceLink as ResourceLink
import Dict exposing (Dict)
import Html exposing (Html, text)
import Html.Attributes
import Html.Events
import Material.IconButton exposing (iconButton, iconButtonConfig)
import Material.IconToggle exposing (iconToggle, iconToggleConfig)
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


update : Msg -> Model -> Model
update msg model =
    case msg of
        Toggle index ->
            { model
                | iconButtons =
                    Dict.update index
                        (\state -> Just (not (Maybe.withDefault False state)))
                        model.iconButtons
            }


isOn : String -> Model -> Bool
isOn index model =
    Maybe.withDefault False (Dict.get index model.iconButtons)


view : Model -> CatalogPage Msg
view model =
    { title = "Icon Button"
    , prelude = "Icons are appropriate for buttons that allow a user to take actions or make a selection, such as adding or removing a star to an item."
    , resources =
        { materialDesignGuidelines = Just "https://material.io/design/components/buttons.html#toggle-button"
        , documentation = Just "https://package.elm-lang.org/packages/aforemny/material-components-web-elm/latest/Material-IconButton"
        , sourceCode = Just "https://github.com/material-components/material-components-web/tree/master/packages/mdc-icon-button"
        }
    , hero =
        [ iconToggle
            { iconToggleConfig
                | on = isOn "icon-button-hero" model
                , onChange = Just (Toggle "icon-button-hero")
            }
            { offIcon = "favorite_border"
            , onIcon = "favorite"
            }
        ]
    , content =
        [ Html.h3 [ Typography.subtitle1 ] [ text "Icon Button" ]
        , iconButton iconButtonConfig "wifi"
        , Html.h3 [ Typography.subtitle1 ] [ text "Icon Toggle" ]
        , iconToggle
            { iconToggleConfig
                | on = isOn "icon-button-toggle" model
                , onChange = Just (Toggle "icon-button-toggle")
            }
            { offIcon = "favorite_border"
            , onIcon = "favorite"
            }
        ]
    }
