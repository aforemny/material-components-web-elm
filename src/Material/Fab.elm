module Material.Fab exposing
    ( Config, config
    , setOnClick
    , setMini
    , setExited
    , setAttributes
    , fab
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
            "favorite"


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

    Fab.fab (Fab.config |> Fab.setMini True) "favorite"


# Exited FAB

If you want the floating action button to transition off the screen, set its
`setExited` configuration option to `True`.

    Fab.fab (Fab.config |> Fab.setExited True) "favorite"


# Focus a FAB

You may programatically focus a floating action button by assigning an id
attribute to it and use `Browser.Dom.focus`.

    Fab.fab
        (Fab.config
            |> Fab.setAttributes
                [ Html.Attributes.id "my-fab" ]
        )
        "favorite_border"

-}

import Html exposing (Html, text)
import Html.Attributes exposing (class)
import Html.Events
import Json.Encode as Encode


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
fab : Config msg -> String -> Html msg
fab ((Config { additionalAttributes }) as config_) iconName =
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
        , iconElt iconName
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


iconElt : String -> Html msg
iconElt iconName =
    Html.span [ class "material-icons", class "mdc-fab__icon" ] [ text iconName ]


clickHandler : Config msg -> Maybe (Html.Attribute msg)
clickHandler (Config { onClick }) =
    Maybe.map Html.Events.onClick onClick
