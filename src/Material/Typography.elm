module Material.Typography exposing
    ( headline1, headline2, headline3, headline4, headline5, headline6
    , body1, body2
    , subtitle1, subtitle2
    , caption, button, overline
    , typography
    )

{-| Material Design's text sizes and styles were developed to balance content
density and reading comfort under typical usage conditions.


# Table of Contents

  - [Resources](#resources)
  - [Basic Usage](#basic-usage)
  - [Typography Variants](#typography-variants)


# Resources

  - [Demo: Typography](https://aforemny.github.io/material-components-web-elm/#typography)
  - [Material Design Guidelines: Typography](https://material.io/go/design-typography)
  - [MDC Web: Typography](https://github.com/material-components/material-components-web/tree/master/packages/mdc-typography)
  - [Sass Mixins (MDC Web)](https://github.com/material-components/material-components-web/tree/master/packages/mdc-typography#sass-variables-and-mixins)


# Basic Usage

For typography to work best, it is necessary to set the font to Roboto. This is
archieved by the `mdc-typography` class, and we recommend to set it globally to
the root of your page.

    import Material.Typography as Typography

    Html.h1 [ Typography.headline1 ] [ text "Headline" ]


# Typography Variants

Typography elements come in the following thirteen variants.

@docs headline1, headline2, headline3, headline4, headline5, headline6
@docs body1, body2
@docs subtitle1, subtitle2
@docs caption, button, overline
@docs typography

-}

import Html
import Html.Attributes exposing (class)


{-| Sets the font to Roboto
-}
typography : Html.Attribute msg
typography =
    class "mdc-typography"


{-| Sets font properties as Headline 1
-}
headline1 : Html.Attribute msg
headline1 =
    class "mdc-typography--headline1"


{-| Sets font properties as Headline 2
-}
headline2 : Html.Attribute msg
headline2 =
    class "mdc-typography--headline2"


{-| Sets font properties as Headline 3
-}
headline3 : Html.Attribute msg
headline3 =
    class "mdc-typography--headline3"


{-| Sets font properties as Headline 4
-}
headline4 : Html.Attribute msg
headline4 =
    class "mdc-typography--headline4"


{-| Sets font properties as Headline 5
-}
headline5 : Html.Attribute msg
headline5 =
    class "mdc-typography--headline5"


{-| Sets font properties as Headline 6
-}
headline6 : Html.Attribute msg
headline6 =
    class "mdc-typography--headline6"


{-| Sets font properties as Subtitle 1
-}
subtitle1 : Html.Attribute msg
subtitle1 =
    class "mdc-typography--subtitle1"


{-| Sets font properties as Subtitle 2
-}
subtitle2 : Html.Attribute msg
subtitle2 =
    class "mdc-typography--subtitle2"


{-| Sets font properties as Body 1
-}
body1 : Html.Attribute msg
body1 =
    class "mdc-typography--body1"


{-| Sets font properties as Body 2
-}
body2 : Html.Attribute msg
body2 =
    class "mdc-typography--body2"


{-| Sets font properties as Caption
-}
caption : Html.Attribute msg
caption =
    class "mdc-typography--caption"


{-| Sets font properties as Button
-}
button : Html.Attribute msg
button =
    class "mdc-typography--button"


{-| Sets font properties as Overline
-}
overline : Html.Attribute msg
overline =
    class "mdc-typography--overline"
