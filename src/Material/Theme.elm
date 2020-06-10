module Material.Theme exposing
    ( primary, secondary, background
    , onPrimary, onSecondary, onSurface
    , primaryBg, secondaryBg, surface
    , textPrimaryOnBackground, textSecondaryOnBackground, textHintOnBackground
    , textDisabledOnBackground, textIconOnBackground
    , textPrimaryOnLight, textSecondaryOnLight, textHintOnLight
    , textDisabledOnLight, textIconOnLight
    , textPrimaryOnDark, textSecondaryOnDark, textHintOnDark
    , textDisabledOnDark, textIconOnDark
    )

{-| The Material Design color system can be used to create a color scheme that
reflects your brand or style.

Material Components Web use a theme comprised of a primary and a secondary
color. Those colors can be conveniently override via Sass (see below), and
[less conveniently via
CSS](https://github.com/material-components/material-components-web/tree/master/packages/mdc-theme#non-sass-customization).
They cannot be changed from Elm at all.

While this module defines attributes that mimic the CSS classes available by
MDC Web, it is recommended to use MDC Web's Sass API to do
themeing since it is a lot more flexible. I highly recommend you [check it
out](https://github.com/material-components/material-components-web/tree/master/packages/mdc-theme#sass-mixins-variables-and-functions)!


# Table of Contents

  - [Resources](#resources)
  - [Basic Usage](#basic-usage)
  - [Changing Theme via SASS](#chaging-theme-via-sass)
  - [Colors](#colors)
      - [Text Colors](#text-colors)
      - [Background Colors](#background-colors)
  - [Text Styles](#text-styles)
      - [Text Styles on Background](#text-styles-on-background)
      - [Text Styles on Light Background](#text-styles-on-light-background)
      - [Text Styles on Dark Background](#text-styles-on-dark-background)


# Resources

  - [Demo: Theme](https://aforemny.github.io/material-components-web-elm/#theme)
  - [Material Design Guidelines: Color](https://material.io/go/design-theming)
  - [MDC Web: Theme](https://github.com/material-components/material-components-web/tree/master/packages/mdc-theme)
  - [Sass Mixins (MDC Web)](https://github.com/material-components/material-components-web/tree/master/packages/mdc-theme#sass-mixins-variables-and-functions)


# Basic Usage

    import Material.Theme as Theme

    main =
        Html.span [ Theme.primary ] [ text "Primary color" ]


# Changing Theme via SASS

```scss
$mdc-theme-primary: #fcb8ab;
$mdc-theme-secondary: #feeae6;
$mdc-theme-on-primary: #442b2d;
$mdc-theme-on-secondary: #442b2d;

@import "@material/button/mdc-button";
```


# Colors


## Text Colors

@docs primary, secondary, background
@docs onPrimary, onSecondary, onSurface


## Background Colors

@docs primaryBg, secondaryBg, surface


# Text Styles

MDC Web use a system that defines five **text styles**. In addition to the
theme's background color, they can be used on either light or dark background.
The text styles are defined as follows:

Those text styles can be used on light background, dark background and on the
theme's background color whether it is light or dark.

  - **primary**: Used for most text
  - **secondary**: Used for text which is lower in the visual hierarchy
  - **hint**: Used for text hints, such as those in text fields and labels
  - **disabled**: Used for text in disabled components and content
  - **icon**: Used for icons

Please note that the primary and secondary text style _do not_ correspond to
the theme's primary or secondary colors.


## Text Styles on Background

@docs textPrimaryOnBackground, textSecondaryOnBackground, textHintOnBackground
@docs textDisabledOnBackground, textIconOnBackground


## Text Styles on Light Background

@docs textPrimaryOnLight, textSecondaryOnLight, textHintOnLight
@docs textDisabledOnLight, textIconOnLight


## Text Styles on Dark Background

@docs textPrimaryOnDark, textSecondaryOnDark, textHintOnDark
@docs textDisabledOnDark, textIconOnDark

-}

import Html
import Html.Attributes exposing (class)


{-| Sets the text color to the theme primary color
-}
primary : Html.Attribute msg
primary =
    class "mdc-theme--primary"


{-| Sets the text color to the theme secondary color
-}
secondary : Html.Attribute msg
secondary =
    class "mdc-theme--secondary"


{-| Sets the background color to the theme background color
-}
background : Html.Attribute msg
background =
    class "mdc-theme--background"


{-| Sets the surface color to the theme surface color
-}
surface : Html.Attribute msg
surface =
    class "mdc-theme--surface"


{-| Sets the text color to the theme on-primary color

The theme's on-primary color is a text color that works best on a primary color
background.

-}
onPrimary : Html.Attribute msg
onPrimary =
    class "mdc-theme--on-primary"


{-| Sets the text color to the theme on-secondary color

The theme's on-secondary color is a text color that works best on a secondary
color background.

-}
onSecondary : Html.Attribute msg
onSecondary =
    class "mdc-theme--on-secondary"


{-| Sets the text color to the theme on-surface color

The theme's on-surface color is a text color that works best on a surface
color background.

-}
onSurface : Html.Attribute msg
onSurface =
    class "mdc-theme--on-surface"


{-| Sets the background color to the theme primary color
-}
primaryBg : Html.Attribute msg
primaryBg =
    class "mdc-theme--primary-bg"


{-| Sets the background color to the theme secondary color
-}
secondaryBg : Html.Attribute msg
secondaryBg =
    class "mdc-theme--secondary-bg"


{-| Sets text to a suitable color for the primary text style on top of light
background
-}
textPrimaryOnLight : Html.Attribute msg
textPrimaryOnLight =
    class "mdc-theme--text-primary-on-light"


{-| Sets text to a suitable color for the secondary text style on top of light
background
-}
textSecondaryOnLight : Html.Attribute msg
textSecondaryOnLight =
    class "mdc-theme--text-secondary-on-light"


{-| Sets text to a suitable color for the hint text style on top of light
background
-}
textHintOnLight : Html.Attribute msg
textHintOnLight =
    class "mdc-theme--text-hint-on-light"


{-| Sets text to a suitable color for the disabled text style on top of light
background
-}
textDisabledOnLight : Html.Attribute msg
textDisabledOnLight =
    class "mdc-theme--text-disabled-on-light"


{-| Sets text to a suitable color for the icon text style on top of light
background
-}
textIconOnLight : Html.Attribute msg
textIconOnLight =
    class "mdc-theme--text-icon-on-light"


{-| Sets text to a suitable color for the primary text style on top of dark
background
-}
textPrimaryOnDark : Html.Attribute msg
textPrimaryOnDark =
    class "mdc-theme--text-primary-on-dark"


{-| Sets text to a suitable color for the secondary text style on top of dark
background
-}
textSecondaryOnDark : Html.Attribute msg
textSecondaryOnDark =
    class "mdc-theme--text-secondary-on-dark"


{-| Sets text to a suitable color for the hint text style on top of dark
background
-}
textHintOnDark : Html.Attribute msg
textHintOnDark =
    class "mdc-theme--text-hint-on-dark"


{-| Sets text to a suitable color for the disabled text style on top of dark
background
-}
textDisabledOnDark : Html.Attribute msg
textDisabledOnDark =
    class "mdc-theme--text-disabled-on-dark"


{-| Sets text to a suitable color for the icon text style on top of dark
background
-}
textIconOnDark : Html.Attribute msg
textIconOnDark =
    class "mdc-theme--text-icon-on-dark"


{-| Sets text to a suitable color for the primary text style on top of the
background color
-}
textPrimaryOnBackground : Html.Attribute msg
textPrimaryOnBackground =
    class "mdc-theme--text-primary-on-background"


{-| Sets text to a suitable color for the secondary text style on top of the
background color
-}
textSecondaryOnBackground : Html.Attribute msg
textSecondaryOnBackground =
    class "mdc-theme--text-secondary-on-background"


{-| Sets text to a suitable color for the hint text style on top of the
background color
-}
textHintOnBackground : Html.Attribute msg
textHintOnBackground =
    class "mdc-theme--text-hint-on-background"


{-| Sets text to a suitable color for the disabled text style on top of the
background color
-}
textDisabledOnBackground : Html.Attribute msg
textDisabledOnBackground =
    class "mdc-theme--text-disabled-on-background"


{-| Sets text to a suitable color for the icon text style on top of the
background color
-}
textIconOnBackground : Html.Attribute msg
textIconOnBackground =
    class "mdc-theme--text-icon-on-background"
