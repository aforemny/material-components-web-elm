module Material.Theme exposing
    ( background
    , disabledOnDark
    , disabledOnLight
    , hintOnDark
    , hintOnLight
    , iconOnDark
    , iconOnLight
    , onPrimary
    , onSecondary
    , onSurface
    , primary
    , primaryBg
    , primaryOnDark
    , primaryOnLight
    , secondary
    , secondaryBg
    , secondaryOnDark
    , secondaryOnLight
    , surface
    )

import Html
import Html.Attributes exposing (class)


primary : Html.Attribute msg
primary =
    class "mdc-theme--primary"


secondary : Html.Attribute msg
secondary =
    class "mdc-theme--secondary"


background : Html.Attribute msg
background =
    class "mdc-theme--background"


surface : Html.Attribute msg
surface =
    class "mdc-theme--surface"


onPrimary : Html.Attribute msg
onPrimary =
    class "mdc-theme--on-primary"


onSecondary : Html.Attribute msg
onSecondary =
    class "mdc-theme--on-secondary"


onSurface : Html.Attribute msg
onSurface =
    class "mdc-theme--on-surface"


primaryBg : Html.Attribute msg
primaryBg =
    class "mdc-theme--primary-bg"


secondaryBg : Html.Attribute msg
secondaryBg =
    class "mdc-theme--secondary-bg"


primaryOnLight : Html.Attribute msg
primaryOnLight =
    class "mdc-theme--text-primary-on-light"


secondaryOnLight : Html.Attribute msg
secondaryOnLight =
    class "mdc-theme--text-secondary-on-light"


hintOnLight : Html.Attribute msg
hintOnLight =
    class "mdc-theme--text-hint-on-light"


disabledOnLight : Html.Attribute msg
disabledOnLight =
    class "mdc-theme--text-disabled-on-light"


iconOnLight : Html.Attribute msg
iconOnLight =
    class "mdc-theme--text-icon-on-light"


primaryOnDark : Html.Attribute msg
primaryOnDark =
    class "mdc-theme--text-primary-on-dark"


secondaryOnDark : Html.Attribute msg
secondaryOnDark =
    class "mdc-theme--text-secondary-on-dark"


hintOnDark : Html.Attribute msg
hintOnDark =
    class "mdc-theme--text-hint-on-dark"


disabledOnDark : Html.Attribute msg
disabledOnDark =
    class "mdc-theme--text-disabled-on-dark"


iconOnDark : Html.Attribute msg
iconOnDark =
    class "mdc-theme--text-icon-on-dark"
