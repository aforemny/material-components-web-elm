module Demo.IconButton exposing (Model, Msg(..), defaultModel, update, view)

import Demo.CatalogPage exposing (CatalogPage)
import Demo.Helper.ResourceLink as ResourceLink
import Html exposing (Html, text)
import Html.Attributes
import Html.Events
import Material.IconButton as IconButton
import Material.IconToggle as IconToggle
import Material.Typography as Typography
import Set exposing (Set)


type alias Model =
    { ons : Set String }


defaultModel : Model
defaultModel =
    { ons = Set.empty }


type Msg
    = Toggle String


update : Msg -> Model -> Model
update msg model =
    case msg of
        Toggle id ->
            { model
                | ons =
                    if Set.member id model.ons then
                        Set.remove id model.ons

                    else
                        Set.insert id model.ons
            }


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
        [ IconToggle.iconToggle
            (IconToggle.config
                |> IconToggle.setOn (Set.member "icon-button-hero" model.ons)
                |> IconToggle.setOnChange (Toggle "icon-button-hero")
            )
            { offIcon = "favorite_border"
            , onIcon = "favorite"
            }
        ]
    , content =
        [ Html.h3 [ Typography.subtitle1 ] [ text "Icon Button" ]
        , IconButton.iconButton IconButton.config "wifi"
        , Html.h3 [ Typography.subtitle1 ] [ text "Icon Toggle" ]
        , IconToggle.iconToggle
            (IconToggle.config
                |> IconToggle.setOn (Set.member "icon-button-toggle" model.ons)
                |> IconToggle.setOnChange (Toggle "icon-button-toggle")
            )
            { offIcon = "favorite_border"
            , onIcon = "favorite"
            }
        ]
    }
