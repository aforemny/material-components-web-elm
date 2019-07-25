module Material.Fab.Extended exposing
    ( ExtendedFabConfig, extendedFabConfig
    , extendedFab
    )

{-| An extended floating action button represents the primary action in an
application. In contrast to the [standard floating action
button](Material-Fab), it must contain text.


# Usage

Developers are required to manually position the extended floating action
button within their page layout, for instance by setting a fixed position via
CSS.

An extended floating action button must contain text to indicate its action. If
you are looking for a floating action button variant that only contains an
icon, refer to [Fab](Material-Fab).


# Example

    import Material.Fab.Extended
        exposing
            ( extendedFab
            , extendedFabConfig
            )

    main =
        extendedFab extendedFabConfig "Favorites"


# Configuration

@docs ExtendedFabConfig, extendedFabConfig
@docs extendedFab


# Icon

To add an icon to a extended floating action button, set its `icon`
configuration field to the name of a [Material
Icon](https://material.io/icons). If you want the icon to be positioned after
the button's label, also set the `trailingIcon` configuration field to `True`.


## With leading icon

    extendedFab { extendedFabConfig | icon = "favorite" }
        "Favorites"


## With trailing icon

    extendedFab
        { extendedFabConfig
            | icon = "favorite"
            , trailingIcon = True
        }
        "Favorites"


# Exited

If you want the extended floating action button to transition off the screen,
set its exited configuration field to True.

    extendedFab { extendedFabConfig | exited = True }
        "Favorites"

-}

import Html exposing (Html, text)
import Html.Attributes exposing (class)


{-| Extended floating action button configuration
-}
type alias ExtendedFabConfig msg =
    { icon : Maybe String
    , trailingIcon : Bool
    , exited : Bool
    , additionalAttributes : List (Html.Attribute msg)
    }


{-| Default extended floating action button configuration
-}
extendedFabConfig : ExtendedFabConfig msg
extendedFabConfig =
    { icon = Nothing
    , trailingIcon = False
    , exited = False
    , additionalAttributes = []
    }


{-| Extended floating action button view function
-}
extendedFab : ExtendedFabConfig msg -> String -> Html msg
extendedFab config label =
    Html.node "mdc-fab"
        (List.filterMap identity
            [ rootCs
            , exitedCs config
            ]
            ++ config.additionalAttributes
        )
        (List.filterMap identity
            [ leadingIconElt config
            , labelElt label
            , trailingIconElt config
            ]
        )


rootCs : Maybe (Html.Attribute msg)
rootCs =
    Just (class "mdc-fab mdc-fab--extended")


exitedCs : ExtendedFabConfig msg -> Maybe (Html.Attribute msg)
exitedCs { exited } =
    if exited then
        Just (class "mdc-fab--exited")

    else
        Nothing


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
