module Material.Typography exposing
    ( body1
    , body2
    , button
    , caption
    , headline1
    , headline2
    , headline3
    , headline4
    , headline5
    , headline6
    , overline
    , subtitle1
    , subtitle2
    , typography
    )

import Html
import Html.Attributes exposing (class)


typography : Html.Attribute msg
typography =
    class "mdc-typography"


headline1 : Html.Attribute msg
headline1 =
    class "mdc-typography--headline1"


headline2 : Html.Attribute msg
headline2 =
    class "mdc-typography--headline2"


headline3 : Html.Attribute msg
headline3 =
    class "mdc-typography--headline3"


headline4 : Html.Attribute msg
headline4 =
    class "mdc-typography--headline4"


headline5 : Html.Attribute msg
headline5 =
    class "mdc-typography--headline5"


headline6 : Html.Attribute msg
headline6 =
    class "mdc-typography--headline6"


subtitle1 : Html.Attribute msg
subtitle1 =
    class "mdc-typography--subtitle1"


subtitle2 : Html.Attribute msg
subtitle2 =
    class "mdc-typography--subtitle2"


body1 : Html.Attribute msg
body1 =
    class "mdc-typography--body1"


body2 : Html.Attribute msg
body2 =
    class "mdc-typography--body2"


caption : Html.Attribute msg
caption =
    class "mdc-typography--caption"


button : Html.Attribute msg
button =
    class "mdc-typography--button"


overline : Html.Attribute msg
overline =
    class "mdc-typography--overline"
