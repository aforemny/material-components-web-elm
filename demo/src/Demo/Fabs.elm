module Demo.Fabs exposing (Model, Msg(..), defaultModel, update, view)

import Browser.Dom
import Demo.CatalogPage exposing (CatalogPage)
import Demo.ElmLogo exposing (elmLogo)
import Html exposing (text)
import Html.Attributes exposing (class, style)
import Material.Button as Button
import Material.Fab as Fab
import Material.Fab.Extended as ExtendedFab
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
    { title = "Floating Action Button"
    , prelude = "Floating action buttons represents the primary action in an application. Only one floating action button is recommended per screen to represent the most common action."
    , resources =
        { materialDesignGuidelines = Just "https://material.io/go/design-fab"
        , documentation = Just "https://package.elm-lang.org/packages/aforemny/material-components-web-elm/latest/Material-Fab"
        , sourceCode = Just "https://github.com/material-components/material-components-web/blob/master/packages/mdc-fab/"
        }
    , hero = [ Fab.fab Fab.config (Fab.icon "favorite_border") ]
    , content =
        [ Html.h3 [ Typography.subtitle1 ] [ text "Standard Floating Action Button" ]
        , Fab.fab Fab.config (Fab.icon "favorite_border")
        , Html.h3 [ Typography.subtitle1 ] [ text "Mini Floating Action Button" ]
        , Fab.fab (Fab.config |> Fab.setMini True) (Fab.icon "favorite_border")
        , Html.h3 [ Typography.subtitle1 ] [ text "Extended FAB" ]
        , ExtendedFab.fab
            (ExtendedFab.config
                |> ExtendedFab.setIcon (Just (ExtendedFab.icon "add"))
            )
            "Create"
        , Html.h3 [ Typography.subtitle1 ]
            [ text "Extended FAB (Text label followed by icon)" ]
        , ExtendedFab.fab
            (ExtendedFab.config
                |> ExtendedFab.setIcon (Just (ExtendedFab.icon "add"))
                |> ExtendedFab.setTrailingIcon True
            )
            "Create"
        , Html.h3 [ Typography.subtitle1 ] [ text "Extended FAB (without icon)" ]
        , ExtendedFab.fab ExtendedFab.config "Create"
        , Html.h3 [ Typography.subtitle1 ] [ text "FAB (Shaped)" ]
        , Html.div [ style "display" "flex" ]
            [ Fab.fab
                (Fab.config
                    |> Fab.setAttributes
                        [ style "border-radius" "50% 0"
                        , style "margin-right" "24px"
                        ]
                )
                (Fab.icon "favorite_border")
            , Fab.fab
                (Fab.config
                    |> Fab.setMini True
                    |> Fab.setAttributes
                        [ style "border-radius" "8px"
                        , style "margin-right" "24px"
                        ]
                )
                (Fab.icon "favorite_border")
            , ExtendedFab.fab
                (ExtendedFab.config
                    |> ExtendedFab.setIcon (Just (ExtendedFab.icon "add"))
                )
                "Create"
            ]
        , Html.h3 [ Typography.subtitle1 ] [ text "FAB with Custom Icon" ]
        , Fab.fab Fab.config (Fab.icon "favorite_border")
        , text "\u{00A0}"
        , Fab.fab Fab.config (Fab.customIcon Html.i [ class "fab fa-font-awesome" ] [])
        , text "\u{00A0}"
        , Fab.fab Fab.config
            (Fab.svgIcon [ Svg.Attributes.viewBox "0 0 100 100" ] elmLogo)
        , Html.h3 [ Typography.subtitle1 ] [ text "Extended FAB with Custom Icon" ]
        , ExtendedFab.fab
            (ExtendedFab.config
                |> ExtendedFab.setIcon
                    (Just
                        (ExtendedFab.icon "favorite_border")
                    )
            )
            "Material Icons"
        , text "\u{00A0}"
        , ExtendedFab.fab
            (ExtendedFab.config
                |> ExtendedFab.setIcon
                    (Just
                        (ExtendedFab.customIcon Html.i
                            [ class "fab fa-font-awesome" ]
                            []
                        )
                    )
            )
            "Font Awesome"
        , text "\u{00A0}"
        , ExtendedFab.fab
            (ExtendedFab.config
                |> ExtendedFab.setIcon
                    (Just
                        (ExtendedFab.svgIcon [ Svg.Attributes.viewBox "0 0 100 100" ]
                            elmLogo
                        )
                    )
            )
            "SVG"
        , Html.h3 [ Typography.subtitle1 ] [ text "Focus FAB" ]
        , Html.div [ style "display" "flex" ]
            [ Fab.fab
                (Fab.config |> Fab.setAttributes [ Html.Attributes.id "my-fab" ])
                (Fab.icon "favorite_border")
            , text "\u{00A0}"
            , Button.raised
                (Button.config |> Button.setOnClick (Focus "my-fab"))
                "Focus"
            ]
        ]
    }
