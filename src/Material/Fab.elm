module Material.Fab exposing
    ( fab, fabConfig, FabConfig
    , extendedFab, extendedFabConfig, ExtendedFabConfig
    )

{-| A floating action button represents the primary action in an application.


# Table of Contents

  - [Resources](#resources)
  - [Basic Usage](#basic-usage)
  - [Floating Action Button](#floating-action-button)
      - [Mini FAB](#mini-fab)
      - [Exited FAB](#exited-fab)
  - [Extended Floating Action Button](#extended-floating-action-button)
      - [Extended FAB with Icon](#extended-fab-with-icon)
          - [Extended FAB with Leading Icon](#extended-fab-with-leading-icon)
          - [Extended FAB with Trailing Icon](#extended-fab-with-trailing-icon)
      - [Exited Extended FAB](#exited-extended-fab)


# Resources

  - [Demo: Floating action buttons](https://aforemny.github.io/material-components-web-elm/#fabs)
  - [Material Design Guidelines: Floating Action Button](https://material.io/go/design-fab)
  - [MDC Web: Floating Action Button](https://github.com/material-components/material-components-web/tree/master/packages/mdc-fab)
  - [Sass Mixins (MDC Web)](https://github.com/material-components/material-components-web/tree/master/packages/mdc-fab#sass-mixins)


# Basic Usage

Developers are required to manually position the floating action button within
their page layout, for instance by setting a fixed position via CSS.

A floating action button only contains an icon to indicate its action. For a
floating action button that may contain text, refer to the [extended floating
action button](#extended-fab) below.

    import Material.Fab exposing (fab, fabConfig)

    type Msg
        = FabClicked

    main =
        fab { fabConfig | onClick = Just FabClicked }
            "favorite"


# Floating Action Button

@docs fab, fabConfig, FabConfig


## Mini FAB

If you want the floating action button to appear in smaller size, set its mini
configuration field to True.

    fab { fabConfig | mini = True } "favorite"


## Exited FAB

If you want the floating action button to transition off the screen, set its
exited configuration field to True.

    fab { fabConfig | exited = True } "favorite"


# Extended Floating Action Button

@docs extendedFab, extendedFabConfig, ExtendedFabConfig


## Extended FAB with Icon

To add an icon to a extended floating action button, set its `icon`
configuration field to the name of a [Material
Icon](https://material.io/icons). If you want the icon to be positioned after
the button's label, also set the `trailingIcon` configuration field to `True`.


### Extended FAB with Leading Icon

    extendedFab { extendedFabConfig | icon = "favorite" }
        "Favorites"


### Extended FAB with Trailing Icon

    extendedFab
        { extendedFabConfig
            | icon = "favorite"
            , trailingIcon = True
        }
        "Favorites"


## Exited Extended FAB

If you want the extended floating action button to transition off the screen,
set its exited configuration field to True.

    extendedFab { extendedFabConfig | exited = True }
        "Favorites"

-}

import Html exposing (Html, text)
import Html.Attributes exposing (class)
import Html.Events


{-| Floating action button configuration
-}
type alias FabConfig msg =
    { mini : Bool
    , exited : Bool
    , onClick : Maybe msg
    , additionalAttributes : List (Html.Attribute msg)
    }


{-| Default floating action button configuration
-}
fabConfig : FabConfig msg
fabConfig =
    { mini = False
    , exited = False
    , onClick = Nothing
    , additionalAttributes = []
    }


{-| Floating action button view function
-}
fab : FabConfig msg -> String -> Html msg
fab config iconName =
    Html.node "mdc-fab"
        (List.filterMap identity
            [ rootCs
            , miniCs config
            , exitedCs config
            , clickHandler config
            ]
            ++ config.additionalAttributes
        )
        [ iconElt iconName
        ]


{-| Extended floating action button configuration
-}
type alias ExtendedFabConfig msg =
    { icon : Maybe String
    , trailingIcon : Bool
    , exited : Bool
    , onClick : Maybe msg
    , additionalAttributes : List (Html.Attribute msg)
    }


{-| Default extended floating action button configuration
-}
extendedFabConfig : ExtendedFabConfig msg
extendedFabConfig =
    { icon = Nothing
    , trailingIcon = False
    , exited = False
    , onClick = Nothing
    , additionalAttributes = []
    }


{-| Extended floating action button view function
-}
extendedFab : ExtendedFabConfig msg -> String -> Html msg
extendedFab config label =
    Html.node "mdc-fab"
        (List.filterMap identity
            [ rootCs
            , extendedFabCs
            , exitedCs config
            , clickHandler config
            ]
            ++ config.additionalAttributes
        )
        (List.filterMap identity
            [ leadingIconElt config
            , labelElt label
            , trailingIconElt config
            ]
        )


extendedFabCs : Maybe (Html.Attribute msg)
extendedFabCs =
    Just (class "mdc-fab mdc-fab--extended")


leadingIconElt : ExtendedFabConfig msg -> Maybe (Html msg)
leadingIconElt { icon, trailingIcon } =
    case ( icon, trailingIcon ) of
        ( Just iconName, False ) ->
            Just
                (Html.span [ class "material-icons", class "mdc-fab__icon" ]
                    [ text iconName ]
                )

        _ ->
            Nothing


labelElt : String -> Maybe (Html msg)
labelElt label =
    Just (Html.span [ class "mdc-fab__label" ] [ text label ])


trailingIconElt : ExtendedFabConfig msg -> Maybe (Html msg)
trailingIconElt { icon, trailingIcon } =
    case ( icon, trailingIcon ) of
        ( Just iconName, True ) ->
            Just
                (Html.span [ class "material-icons", class "mdc-fab__icon" ]
                    [ text iconName ]
                )

        _ ->
            Nothing


rootCs : Maybe (Html.Attribute msg)
rootCs =
    Just (class "mdc-fab")


miniCs : FabConfig msg -> Maybe (Html.Attribute msg)
miniCs { mini } =
    if mini then
        Just (class "mdc-fab--mini")

    else
        Nothing


exitedCs : { fabConfig | exited : Bool } -> Maybe (Html.Attribute msg)
exitedCs { exited } =
    if exited then
        Just (class "mdc-fab--exited")

    else
        Nothing


iconElt : String -> Html msg
iconElt iconName =
    Html.span [ class "material-icons", class "mdc-fab__icon" ] [ text iconName ]


clickHandler : { config | onClick : Maybe msg } -> Maybe (Html.Attribute msg)
clickHandler { onClick } =
    Maybe.map Html.Events.onClick onClick
