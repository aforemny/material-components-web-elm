module Demo.Startpage exposing (view)

import Demo.Url as Url exposing (Url(..))
import Html exposing (Html, text)
import Html.Attributes
import Html.Events
import Material.IconButton as IconButton exposing (customIconButton, iconButtonConfig)
import Material.ImageList exposing (imageList, imageListConfig, imageListItem, imageListItemConfig)
import Material.TopAppBar as TopAppBar exposing (topAppBar, topAppBarConfig)


view : Html msg
view =
    Html.div []
        [ topAppBar topAppBarConfig
            [ TopAppBar.row []
                [ TopAppBar.section [ TopAppBar.alignStart ]
                    [ customIconButton
                        { iconButtonConfig
                            | additionalAttributes = [ TopAppBar.navigationIcon ]
                        }
                        [ Html.img
                            [ Html.Attributes.src "images/ic_component_24px_white.svg"
                            ]
                            []
                        ]
                    , Html.span
                        [ TopAppBar.title
                        , Html.Attributes.style "text-transform" "uppercase"
                        , Html.Attributes.style "font-weight" "400"
                        ]
                        [ text "Material Components for Elm" ]
                    ]
                ]
            ]
        , imageList
            { imageListConfig
                | additionalAttributes =
                    [ Html.Attributes.style "max-width" "900px"
                    , Html.Attributes.style "padding-top" "128px"
                    , Html.Attributes.style "padding-bottom" "100px"
                    ]
            }
            (List.map
                (\{ url, title, icon } ->
                    imageListItem
                        { imageListItemConfig
                            | label = Just title
                            , href = Just (Url.toString url)
                            , additionalAttributes =
                                [ Html.Attributes.style "width" "calc(100% / 4 - 8.25px)"
                                , Html.Attributes.style "margin" "4px"
                                ]
                        }
                        icon
                )
                imageListItems
            )
        ]


imageListItems : List { url : Url, icon : String, title : String, subtitle : String }
imageListItems =
    [ { url = Button
      , icon = "images/buttons_180px.svg"
      , title = "Button"
      , subtitle = "Raised and flat buttons"
      }
    , { url = Card
      , icon = "images/cards_180px.svg"
      , title = "Card"
      , subtitle = "Various card layout styles"
      }
    , { url = Checkbox
      , icon = "images/checkbox_180px.svg"
      , title = "Checkbox"
      , subtitle = "Multi-selection controls"
      }
    , { url = Chips
      , icon = "images/chips_180px.svg"
      , title = "Chips"
      , subtitle = "Chips"
      }
    , { url = Dialog
      , icon = "images/dialog_180px.svg"
      , title = "Dialog"
      , subtitle = "Secondary text"
      }
    , { url = Drawer
      , icon = "images/drawer_180px.svg"
      , title = "Drawer"
      , subtitle = "Various drawer styles"
      }
    , { url = Elevation
      , icon = "images/elevation_180px.svg"
      , title = "Elevation"
      , subtitle = "Shadow for different elevations"
      }
    , { url = Fab
      , icon = "images/floating_action_button_180px.svg"
      , title = "FAB"
      , subtitle = "The primary action in an application"
      }
    , { url = IconButton
      , icon = "images/icon_button_180px.svg"
      , title = "Icon Button"
      , subtitle = "Toggling icon states"
      }
    , { url = ImageList
      , icon = "images/image_list_180px.svg"
      , title = "Image List"
      , subtitle = "An Image List consists of several items, each containing an image and optionally supporting content (i.e. a text label)"
      }
    , { url = LayoutGrid
      , icon = "images/layout_grid_180px.svg"
      , title = "Layout Grid"
      , subtitle = "Grid and gutter support"
      }
    , { url = List
      , icon = "images/list_180px.svg"
      , title = "List"
      , subtitle = "Item layouts in lists"
      }
    , { url = LinearProgress
      , icon = "images/linear_progress_180px.svg"
      , title = "Linear progress"
      , subtitle = "Fills from 0% to 100%, represented by bars"
      }
    , { url = Menu
      , icon = "images/menu_180px.svg"
      , title = "Menu"
      , subtitle = "Pop over menus"
      }
    , { url = RadioButton
      , icon = "images/radio_180px.svg"
      , title = "Radio"
      , subtitle = "Single selection controls"
      }
    , { url = Ripple
      , icon = "images/ripple_180px.svg"
      , title = "Ripple"
      , subtitle = "Touch ripple"
      }
    , { url = Select
      , icon = "images/form_field_180px.svg"
      , title = "Select"
      , subtitle = "Popover selection menus"
      }
    , { url = Slider
      , icon = "images/slider_180px.svg"
      , title = "Slider"
      , subtitle = "Range Controls"
      }
    , { url = Snackbar
      , icon = "images/snackbar_180px.svg"
      , title = "Snackbar"
      , subtitle = "Transient messages"
      }
    , { url = Switch
      , icon = "images/switch_180px.svg"
      , title = "Switch"
      , subtitle = "On off switches"
      }
    , { url = TabBar
      , icon = "images/tabs_180px.svg"
      , title = "Tab Bar"
      , subtitle = "Tabs organize and allow navigation between groups of content that are related and at the same level of hierarchy"
      }
    , { url = TextField
      , icon = "images/form_field_180px.svg"
      , title = "Text field"
      , subtitle = "Single and multiline text fields"
      }
    , { url = Theme
      , icon = "images/ic_theme_24px.svg"
      , title = "Theme"
      , subtitle = "Using primary and accent colors"
      }
    , { url = TopAppBar
      , icon = "images/top_app_bar_180px.svg"
      , title = "Top App Bar"
      , subtitle = "Container for items such as application title, navigation icon, and action items."
      }
    , { url = Typography
      , icon = "images/fonts_180px.svg"
      , title = "Typography"
      , subtitle = "Type hierarchy"
      }
    ]
