module Main exposing (main)

import Html exposing (Html, text)
import Material.Button exposing (button, buttonConfig)
import Material.Card
import Material.Checkbox exposing (checkbox, checkboxConfig)
import Material.Chip exposing (chip, chipConfig)
import Material.ChipSet exposing (chipSet, chipSetConfig)
import Material.Dialog exposing (dialog, dialogConfig)
import Material.Fab exposing (fab, fabConfig)
import Material.FormField exposing (formField, formFieldConfig)
import Material.Icon
import Material.IconToggle exposing (iconToggle, iconToggleConfig)
import Material.LinearProgress exposing (linearProgress, linearProgressConfig)


main : Html msg
main =
    Html.div []
        [ Html.div []
            [ button buttonConfig "Click me"
            , button { buttonConfig | variant = Material.Button.Raised } "Click me"
            , button { buttonConfig | variant = Material.Button.Unelevated } "Click me"
            , button { buttonConfig | variant = Material.Button.Outlined } "Click me"
            ]
        , Html.div []
            [ checkbox checkboxConfig
            , checkbox { checkboxConfig | state = Material.Checkbox.Checked }
            , checkbox { checkboxConfig | state = Material.Checkbox.Indeterminate }
            ]
        , Html.div []
            [ chipSet chipSetConfig
                [ chip chipConfig "foo"
                , chip chipConfig "bar"
                ]
            ]
        , Html.div []
            [ dialog dialogConfig
                { title = "Simple dialog"
                , content = [ text "Hello" ]
                , actions = []
                }
            ]
        , Html.div []
            [ fab fabConfig "favorite"
            , fab { fabConfig | mini = True } "favorite"
            ]
        , Html.div []
            [ formField formFieldConfig [] ]
        , Html.div []
            [ iconToggle iconToggleConfig "favorite" ]
        , Html.div []
            [ linearProgress linearProgressConfig ]
        ]
