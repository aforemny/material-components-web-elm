module Material.Typography exposing
    ( body1, body2
    , button
    , caption
    , headline1, headline2, headline3, headline4, headline5, headline6
    , overline
    , subtitle1, subtitle2
    , typography
    )

{-| TODO docs

@docs body1, body2
@docs button
@docs caption
@docs headline1, headline2, headline3, headline4, headline5, headline6
@docs overline
@docs subtitle1, subtitle2
@docs typography

-}

import Html
import Html.Attributes exposing (class)


{-| TODO docs
-}
typography : Html.Attribute msg
typography =
    class "mdc-typography"


{-| TODO docs
-}
headline1 : Html.Attribute msg
headline1 =
    class "mdc-typography--headline1"


{-| TODO docs
-}
headline2 : Html.Attribute msg
headline2 =
    class "mdc-typography--headline2"


{-| TODO docs
-}
headline3 : Html.Attribute msg
headline3 =
    class "mdc-typography--headline3"


{-| TODO docs
-}
headline4 : Html.Attribute msg
headline4 =
    class "mdc-typography--headline4"


{-| TODO docs
-}
headline5 : Html.Attribute msg
headline5 =
    class "mdc-typography--headline5"


{-| TODO docs
-}
headline6 : Html.Attribute msg
headline6 =
    class "mdc-typography--headline6"


{-| TODO docs
-}
subtitle1 : Html.Attribute msg
subtitle1 =
    class "mdc-typography--subtitle1"


{-| TODO docs
-}
subtitle2 : Html.Attribute msg
subtitle2 =
    class "mdc-typography--subtitle2"


{-| TODO docs
-}
body1 : Html.Attribute msg
body1 =
    class "mdc-typography--body1"


{-| TODO docs
-}
body2 : Html.Attribute msg
body2 =
    class "mdc-typography--body2"


{-| TODO docs
-}
caption : Html.Attribute msg
caption =
    class "mdc-typography--caption"


{-| TODO docs
-}
button : Html.Attribute msg
button =
    class "mdc-typography--button"


{-| TODO docs
-}
overline : Html.Attribute msg
overline =
    class "mdc-typography--overline"
