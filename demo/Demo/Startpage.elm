module Demo.Startpage exposing (view)

import Demo.Page exposing (Page)
import Demo.Url exposing (Url(..))
import Html exposing (Html, text)
import Html.Attributes
import Html.Events
import Material.ImageList as ImageList


view : Page m -> Html m
view page =
    Html.div
        []
        [ page.toolbar "Material Components for the Web"
        , Html.nav
            []
            [ imageList imageListConfig
                (List.map
                    (\{ url, title, icon } ->
                        { image = icon, label = Just title }
                    )
                    [ { url = Button
                      , icon = "images/ic_button_24px.svg"
                      , title = "Button"
                      , subtitle = "Raised and flat buttons"
                      }
                    , { url = Card
                      , icon = "images/ic_card_24px.svg"
                      , title = "Card"
                      , subtitle = "Various card layout styles"
                      }
                    , { url = Checkbox
                      , icon = "images/ic_checkbox_24px.svg"
                      , title = "Checkbox"
                      , subtitle = "Multi-selection controls"
                      }
                    , { url = Chips
                      , icon = "ic_chips_24px.svg"
                      , title = "Chips"
                      , subtitle = "Chips"
                      }
                    , { url = Dialog
                      , icon = "images/ic_dialog_24px.svg"
                      , title = "Dialog"
                      , subtitle = "Secondary text"
                      }
                    , { url = Drawer
                      , icon = "images/ic_drawer_24px.svg"
                      , title = "Drawer"
                      , subtitle = "Various drawer styles"
                      }
                    , { url = Elevation
                      , icon = "images/ic_shadow_24px.svg"
                      , title = "Elevation"
                      , subtitle = "Shadow for different elevations"
                      }
                    , { url = Fabs
                      , icon = "images/ic_fabs_24px.svg"
                      , title = "FAB"
                      , subtitle = "The primary action in an application"
                      }
                    , { url = IconToggle
                      , icon = "images/ic_icon-toggles_24px.svg"
                      , title = "Icon Button"
                      , subtitle = "Toggling icon states"
                      }
                    , { url = ImageList
                      , icon = "images/ic_image-list_24px.svg"
                      , title = "Image List"
                      , subtitle = "An Image List consists of several items, each containing an image and optionally supporting content (i.e. a text label)"
                      }
                    , { url = LayoutGrid
                      , icon = "images/ic_layout-grid_24px.svg"
                      , title = "Layout Grid"
                      , subtitle = "Grid and gutter support"
                      }
                    , { url = List
                      , icon = "images/ic_lists_24px.svg"
                      , title = "List"
                      , subtitle = "Item layouts in lists"
                      }
                    , { url = LinearProgress
                      , icon = "images/ic_linear-progress_24px.svg"
                      , title = "Linear progress"
                      , subtitle = "Fills from 0% to 100%, represented by bars"
                      }
                    , { url = Menu
                      , icon = "images/ic_menus_24px.svg"
                      , title = "Menu"
                      , subtitle = "Pop over menus"
                      }
                    , { url = RadioButton
                      , icon = "images/ic_radio-buttons_24px.svg"
                      , title = "Radio"
                      , subtitle = "Single selection controls"
                      }
                    , { url = Ripple
                      , icon = "images/ic_ripple_24px.svg"
                      , title = "Ripple"
                      , subtitle = "Touch ripple"
                      }
                    , { url = Select
                      , icon = "images/ic_select_24px.svg"
                      , title = "Select"
                      , subtitle = "Popover selection menus"
                      }
                    , { url = Slider
                      , icon = "images/ic_slider_24px.svg"
                      , title = "Slider"
                      , subtitle = "Range Controls"
                      }
                    , { url = Snackbar
                      , icon = "images/ic_snackbar_24px.svg"
                      , title = "Snackbar"
                      , subtitle = "Transient messages"
                      }
                    , { url = Switch
                      , icon = "images/ic_switch_24px.svg"
                      , title = "Switch"
                      , subtitle = "On off switches"
                      }
                    , { url = TabBar
                      , icon = "images/ic_tab-bar_24px.svg"
                      , title = "Tab Bar"
                      , subtitle = "Tabs organize and allow navigation between groups of content that are related and at the same level of hierarchy"
                      }
                    , { url = TextField
                      , icon = "images/ic_text-fields_24px.svg"
                      , title = "Text field"
                      , subtitle = "Single and multiline text fields"
                      }
                    , { url = Theme
                      , icon = "images/ic_theme_24px.svg"
                      , title = "Theme"
                      , subtitle = "Using primary and accent colors"
                      }
                    , { url = TopAppBar Nothing
                      , icon = "images/ic_top-app-bar_24px.svg"
                      , title = "Top App Bar"
                      , subtitle = "Container for items such as application title, navigation icon, and action items."
                      }
                    , { url = Typography
                      , icon = "images/ic_typography_24px.svg"
                      , title = "Typography"
                      , subtitle = "Type hierarchy"
                      }
                    ]
                )
            ]
        ]
