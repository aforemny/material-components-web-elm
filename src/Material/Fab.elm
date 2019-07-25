module Material.Fab exposing
    ( FabConfig, fabConfig
    , fab
    )

{-| A floating action button represents the primary action in an application.

  - [Demo: Floating action buttons](https://aforemny.github.io/material-components-elm/#fabs)
  - [Material Design Guidelines: Floating Action Button](https://material.io/go/design-fab)
  - [MDC Web: Floating Action Button](https://github.com/material-components/material-components-web/tree/master/packages/mdc-fab)
  - [Sass Mixins (MDC Web)](https://github.com/material-components/material-components-web/tree/master/packages/mdc-fab#sass-mixins)


# Usage

Developers are required to manually position the floating action button within
their page layout, for instance by setting a fixed position via CSS.

A floating action button may only contain an icon to indicate its action. If
you are looking for a floating action button variant that contains text, refer
to [ExtendedFab](Material-Fab-Extended).


# Example

    import Material.Fab exposing (fab, fabConfig)

    main =
        fab fabConfig "favorite"


# Configuration

@docs FabConfig, fabConfig
@docs fab


# Mini

If you want the floating action button to appear in smaller size, set its mini
configuration field to True.

    fab { fabConfig | mini = True } "favorite"


# Exited

If you want the floating action button to transition off the screen, set its
exited configuration field to True.

    fab { fabConfig | exited = True } "favorite"

-}

import Html exposing (Html, text)
import Html.Attributes exposing (class)


{-| Floating action button configuration
-}
type alias FabConfig msg =
    { mini : Bool
    , exited : Bool
    , additionalAttributes : List (Html.Attribute msg)
    }


{-| Default floating action button configuration
-}
fabConfig : FabConfig msg
fabConfig =
    { mini = False
    , exited = False
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
            ]
            ++ config.additionalAttributes
        )
        [ iconElt iconName
        ]


rootCs : Maybe (Html.Attribute msg)
rootCs =
    Just (class "mdc-fab")


miniCs : FabConfig msg -> Maybe (Html.Attribute msg)
miniCs { mini } =
    if mini then
        Just (class "mdc-fab--mini")

    else
        Nothing


exitedCs : FabConfig msg -> Maybe (Html.Attribute msg)
exitedCs { exited } =
    if exited then
        Just (class "mdc-fab--exited")

    else
        Nothing


iconElt : String -> Html msg
iconElt iconName =
    Html.span [ class "material-icons", class "mdc-fab__icon" ] [ text iconName ]
