module Material.Fab exposing
    ( Config, config
    , setOnClick
    , setMini
    , setExited
    , setAttributes
    , fab
    , Icon, icon
    , customIcon
    , svgIcon
    )

{-| A floating action button represents the primary action in an application.

A floating action button only contains an icon to indicate its action. For a
floating action button that may contain text, refer to the [extended floating
action button](Material-Fab-Extended).


# Table of Contents

  - [Resources](#resources)
  - [Basic Usage](#basic-usage)
  - [Configuration](#configuration)
      - [Configuration Options](#configuration-options)
  - [Floating Action Button](#floating-action-button)
  - [Mini FAB](#mini-fab)
  - [Exited FAB](#exited-fab)
  - [FAB with Custom Icon](#fab-with-custom-icon)
  - [Focus a FAB](#focus-a-fab)


# Resources

  - [Demo: Floating action buttons](https://aforemny.github.io/material-components-web-elm/#fab)
  - [Material Design Guidelines: Floating Action Button](https://material.io/go/design-fab)
  - [MDC Web: Floating Action Button](https://github.com/material-components/material-components-web/tree/master/packages/mdc-fab)
  - [Sass Mixins (MDC Web)](https://github.com/material-components/material-components-web/tree/master/packages/mdc-fab#sass-mixins)


# Basic Usage

Developers are required to manually position the floating action button within
their page layout, for instance by setting a fixed position via CSS.

    import Html.Attributes exposing (style)
    import Material.Fab as Fab

    type Msg
        = FabClicked

    main =
        Fab.fab
            (Fab.config
                |> Fab.setOnClick FabClicked
                |> Fab.setAttributes
                    [ style "position" "fixed"
                    , style "bottom" "2rem"
                    , style "right" "2rem"
                    ]
            )
            (Fab.icon "favorite")


# Configuration

@docs Config, config


## Configuration Options

@docs setOnClick
@docs setMini
@docs setExited
@docs setAttributes


# Floating Action Button

@docs fab


# Mini FAB

If you want the floating action button to appear in smaller size, set its
`setMini` configuration option to `True`.

    Fab.fab (Fab.config |> Fab.setMini True)
        (Fab.icon "favorite")


# Exited FAB

If you want the floating action button to transition off the screen, set its
`setExited` configuration option to `True`.

    Fab.fab (Fab.config |> Fab.setExited True)
        (Fab.icon "favorite")


# FAB with Custom Icon

This library natively supports [Material Icons](https://material.io/icons).
However, you may also include SVG or custom icons such as FontAwesome.

@docs Icon, icon
@docs customIcon
@docs svgIcon


# Focus a FAB

You may programatically focus a floating action button by assigning an id
attribute to it and use `Browser.Dom.focus`.

    Fab.fab
        (Fab.config
            |> Fab.setAttributes
                [ Html.Attributes.id "my-fab" ]
        )
        (Fab.icon "favorite_border")

-}

import Html exposing (Html, text)
import Html.Attributes exposing (class)
import Html.Events
import Json.Encode as Encode
import Svg exposing (Svg)
import Svg.Attributes


{-| Floating action button configuration
-}
type Config msg
    = Config
        { mini : Bool
        , exited : Bool
        , additionalAttributes : List (Html.Attribute msg)
        , onClick : Maybe msg
        }


{-| Default floating action button configuration
-}
config : Config msg
config =
    Config
        { mini = False
        , exited = False
        , onClick = Nothing
        , additionalAttributes = []
        }


{-| Specify whether the floating actions button should be smaller than normally
-}
setMini : Bool -> Config msg -> Config msg
setMini mini (Config config_) =
    Config { config_ | mini = mini }


{-| Specify whether a floating action button should transition off the screen
-}
setExited : Bool -> Config msg -> Config msg
setExited exited (Config config_) =
    Config { config_ | exited = exited }


{-| Specify additional attributes
-}
setAttributes : List (Html.Attribute msg) -> Config msg -> Config msg
setAttributes additionalAttributes (Config config_) =
    Config { config_ | additionalAttributes = additionalAttributes }


{-| Specify a message when the user clicks the floating action button
-}
setOnClick : msg -> Config msg -> Config msg
setOnClick onClick (Config config_) =
    Config { config_ | onClick = Just onClick }


{-| Floating action button view function
-}
fab : Config msg -> Icon -> Html msg
fab ((Config { additionalAttributes }) as config_) icon_ =
    Html.node "mdc-fab"
        (List.filterMap identity
            [ rootCs
            , miniCs config_
            , exitedCs config_
            , clickHandler config_
            , tabIndexProp 0
            ]
            ++ additionalAttributes
        )
        [ rippleElt
        , iconElt icon_
        ]


tabIndexProp : Int -> Maybe (Html.Attribute msg)
tabIndexProp tabIndex =
    Just (Html.Attributes.property "tabIndex" (Encode.int tabIndex))


rootCs : Maybe (Html.Attribute msg)
rootCs =
    Just (class "mdc-fab")


miniCs : Config msg -> Maybe (Html.Attribute msg)
miniCs (Config { mini }) =
    if mini then
        Just (class "mdc-fab--mini")

    else
        Nothing


exitedCs : Config msg -> Maybe (Html.Attribute msg)
exitedCs (Config { exited }) =
    if exited then
        Just (class "mdc-fab--exited")

    else
        Nothing


rippleElt : Html msg
rippleElt =
    Html.div [ class "mdc-fab__ripple" ] []


iconElt : Icon -> Html msg
iconElt icon_ =
    case icon_ of
        Icon { node, attributes, nodes } ->
            Html.map never (node (class "mdc-fab__icon" :: attributes) nodes)

        SvgIcon { node, attributes, nodes } ->
            Html.map never
                (node (Svg.Attributes.class "mdc-fab__icon" :: attributes) nodes)


clickHandler : Config msg -> Maybe (Html.Attribute msg)
clickHandler (Config { onClick }) =
    Maybe.map Html.Events.onClick onClick


{-| Icon type
-}
type Icon
    = Icon
        { node : List (Html.Attribute Never) -> List (Html Never) -> Html Never
        , attributes : List (Html.Attribute Never)
        , nodes : List (Html Never)
        }
    | SvgIcon
        { node : List (Svg.Attribute Never) -> List (Svg Never) -> Svg Never
        , attributes : List (Svg.Attribute Never)
        , nodes : List (Svg Never)
        }


{-| Material Icon

    Fab.fab Fab.config (Fab.icon "favorite")

-}
icon : String -> Icon
icon iconName =
    customIcon Html.i [ class "material-icons" ] [ text iconName ]


{-| Custom icon

    Fab.fab Fab.config
        (Fab.customIcon Html.i
            [ class "fab fa-font-awesome" ]
            []
        )

-}
customIcon :
    (List (Html.Attribute Never) -> List (Html Never) -> Html Never)
    -> List (Html.Attribute Never)
    -> List (Html Never)
    -> Icon
customIcon node attributes nodes =
    Icon { node = node, attributes = attributes, nodes = nodes }


{-| SVG icon

    Fab.fab Fab.config
        (Fab.svgIcon
            [ Svg.Attributes.viewBox "…" ]
            [-- …
            ]
        )

-}
svgIcon : List (Svg.Attribute Never) -> List (Svg Never) -> Icon
svgIcon attributes nodes =
    SvgIcon { node = Svg.svg, attributes = attributes, nodes = nodes }
