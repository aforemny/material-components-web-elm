module Demo.IconButton exposing (Model, Msg(..), defaultModel, update, view)

import Browser.Dom
import Demo.CatalogPage exposing (CatalogPage)
import Demo.ElmLogo exposing (elmLogo)
import Html exposing (text)
import Html.Attributes exposing (class, style)
import Material.Button as Button
import Material.IconButton as IconButton
import Material.IconToggle as IconToggle
import Material.Typography as Typography
import Set exposing (Set)
import Svg.Attributes
import Task


type alias Model =
    { ons : Set String }


defaultModel : Model
defaultModel =
    { ons = Set.empty }


type Msg
    = Toggle String
    | Focus String
    | Focused (Result Browser.Dom.Error ())


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Toggle id ->
            ( { model
                | ons =
                    if Set.member id model.ons then
                        Set.remove id model.ons

                    else
                        Set.insert id model.ons
              }
            , Cmd.none
            )

        Focus id ->
            ( model, Task.attempt Focused (Browser.Dom.focus id) )

        Focused _ ->
            ( model, Cmd.none )


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
            { offIcon = IconToggle.icon "favorite_border"
            , onIcon = IconToggle.icon "favorite"
            }
        ]
    , content =
        [ Html.h3 [ Typography.subtitle1 ] [ text "Icon Button" ]
        , IconButton.iconButton IconButton.config (IconButton.icon "wifi")
        , Html.h3 [ Typography.subtitle1 ] [ text "Icon Toggle" ]
        , IconToggle.iconToggle
            (IconToggle.config
                |> IconToggle.setOn (Set.member "icon-button-toggle" model.ons)
                |> IconToggle.setOnChange (Toggle "icon-button-toggle")
            )
            { offIcon = IconToggle.icon "favorite_border"
            , onIcon = IconToggle.icon "favorite"
            }
        , Html.h3 [ Typography.subtitle1 ] [ text "Icon Button with Custom Icon" ]
        , IconButton.iconButton IconButton.config (IconButton.icon "favorite")
        , IconButton.iconButton IconButton.config
            (IconButton.customIcon Html.i
                [ class "fab fa-font-awesome"
                , style "width" "24px"
                , style "text-align" "center"
                ]
                []
            )
        , IconButton.iconButton IconButton.config
            (IconButton.svgIcon
                [ Svg.Attributes.viewBox "0 0 100 100" ]
                elmLogo
            )
        , Html.h3 [ Typography.subtitle1 ] [ text "Icon Toggle with Custom Icon" ]
        , IconToggle.iconToggle
            (IconToggle.config
                |> IconToggle.setOn (Set.member "custom-icon-toggle-1" model.ons)
                |> IconToggle.setOnChange (Toggle "custom-icon-toggle-1")
            )
            { offIcon = IconToggle.icon "favorite_border"
            , onIcon = IconToggle.icon "favorite"
            }
        , IconToggle.iconToggle
            (IconToggle.config
                |> IconToggle.setOn (Set.member "custom-icon-toggle-2" model.ons)
                |> IconToggle.setOnChange (Toggle "custom-icon-toggle-2")
            )
            { offIcon =
                IconToggle.customIcon Html.i
                    [ class "fab fa-font-awesome-alt"
                    , style "width" "24px"
                    , style "text-align" "center"
                    ]
                    []
            , onIcon =
                IconToggle.customIcon Html.i
                    [ class "fab fa-font-awesome"
                    , style "width" "24px"
                    , style "text-align" "center"
                    ]
                    []
            }
        , IconToggle.iconToggle
            (IconToggle.config
                |> IconToggle.setOn (Set.member "custom-icon-toggle-3" model.ons)
                |> IconToggle.setOnChange (Toggle "custom-icon-toggle-3")
            )
            { offIcon =
                IconToggle.svgIcon [ Svg.Attributes.viewBox "0 0 100 100" ] elmLogo
            , onIcon =
                IconToggle.svgIcon [ Svg.Attributes.viewBox "0 0 100 100" ] elmLogo
            }
        , Html.h3 [ Typography.subtitle1 ] [ text "Focus Icon Button" ]
        , Html.div []
            [ IconButton.iconButton
                (IconButton.config
                    |> IconButton.setAttributes [ Html.Attributes.id "my-icon-button" ]
                )
                (IconButton.icon "wifi")
            , text "\u{00A0}"
            , Button.raised
                (Button.config |> Button.setOnClick (Focus "my-icon-button"))
                "Focus"
            ]
        , Html.h3 [ Typography.subtitle1 ] [ text "Focus Icon Toggle" ]
        , Html.div []
            [ IconToggle.iconToggle
                (IconToggle.config
                    |> IconToggle.setOn (Set.member "my-icon-toggle" model.ons)
                    |> IconToggle.setOnChange (Toggle "my-icon-toggle")
                    |> IconToggle.setAttributes [ Html.Attributes.id "my-icon-toggle" ]
                )
                { offIcon = IconToggle.icon "favorite_border"
                , onIcon = IconToggle.icon "favorite"
                }
            , text "\u{00A0}"
            , Button.raised
                (Button.config |> Button.setOnClick (Focus "my-icon-toggle"))
                "Focus"
            ]
        ]
    }
