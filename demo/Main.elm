module Main exposing (main)

import Html exposing (Html, text)
import Material.Button exposing (button, buttonConfig)
import Material.Card
import Material.Checkbox exposing (checkbox, checkboxConfig)
import Material.Chip exposing (chip, chipConfig)
import Material.ChipSet exposing (chipSet, chipSetConfig)
import Material.Dialog exposing (dialog, dialogConfig)
import Material.Elevation
import Material.Fab exposing (fab, fabConfig)
import Material.FormField exposing (formField, formFieldConfig)
import Material.Icon exposing (icon, iconConfig)
import Material.IconToggle exposing (iconToggle, iconToggleConfig)
import Material.LinearProgress exposing (linearProgress, linearProgressConfig)
import Material.List exposing (list, listConfig, listItem, listItemConfig)
import Material.Menu exposing (menu, menuConfig)
import Material.Radio exposing (radio, radioConfig)
import Material.Ripple exposing (ripple, rippleConfig)
import Material.Select exposing (option, optionConfig, select, selectConfig)
import Material.Slider exposing (slider, sliderConfig)
import Material.Snackbar exposing (snackbar, snackbarConfig)
import Material.Switch exposing (switch, switchConfig)
import Material.Tab exposing (tab, tabConfig)
import Material.TabBar exposing (tabBar, tabBarConfig)
import Material.TextField exposing (textField, textFieldConfig)
import Material.Theme
import Material.Typography


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
        , Html.div []
            [ list listConfig
                [ listItem listItemConfig [ text "foo" ]
                , listItem listItemConfig [ text "bar" ]
                ]
            ]
        , Html.div []
            [ menu menuConfig
                [ list listConfig
                    [ listItem listItemConfig [ text "foo" ]
                    , listItem listItemConfig [ text "bar" ]
                    ]
                ]
            ]
        , Html.div []
            [ radio radioConfig
            , radio { radioConfig | checked = True }
            ]
        , Html.div []
            [ ripple rippleConfig ]
        , Html.div []
            [ select selectConfig
                [ option optionConfig [ text "foo" ]
                , option optionConfig [ text "bar" ]
                ]
            ]
        , Html.div []
            [ slider { sliderConfig | value = 0.5 } ]
        , Html.div []
            [ snackbar snackbarConfig Nothing ]
        , Html.div []
            [ switch switchConfig
            , switch { switchConfig | checked = True }
            , switch { switchConfig | disabled = True }
            ]
        , Html.div []
            [ tabBar tabBarConfig
                [ tab { tabConfig | active = True } { label = "foo", icon = Nothing }
                , tab tabConfig { label = "bar", icon = Nothing }
                ]
            ]
        , Html.div []
            [ textField textFieldConfig
            , textField { textFieldConfig | label = "First name" }
            , textField { textFieldConfig | fullwidth = True }
            , textField { textFieldConfig | label = "First name", textarea = True }
            , textField
                { textFieldConfig
                    | label = "First name"
                    , textarea = True
                    , fullwidth = True
                }
            ]
        ]
