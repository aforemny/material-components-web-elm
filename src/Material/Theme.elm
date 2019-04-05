module Material.Theme exposing
    ( background
    , onPrimary
    , onSecondary
    , onSurface
    , primary
    , primaryBg
    , secondary
    , secondaryBg
    , surface
    , textDisabledOnBackground
    , textDisabledOnDark
    , textDisabledOnLight
    , textHintOnBackground
    , textHintOnDark
    , textHintOnLight
    , textIconOnBackground
    , textIconOnDark
    , textIconOnLight
    , textPrimaryOnBackground
    , textPrimaryOnDark
    , textPrimaryOnLight
    , textSecondaryOnBackground
    , textSecondaryOnDark
    , textSecondaryOnLight
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


textPrimaryOnLight : Html.Attribute msg
textPrimaryOnLight =
    class "mdc-theme--text-primary-on-light"


textSecondaryOnLight : Html.Attribute msg
textSecondaryOnLight =
    class "mdc-theme--text-secondary-on-light"


textHintOnLight : Html.Attribute msg
textHintOnLight =
    class "mdc-theme--text-hint-on-light"


textDisabledOnLight : Html.Attribute msg
textDisabledOnLight =
    class "mdc-theme--text-disabled-on-light"


textIconOnLight : Html.Attribute msg
textIconOnLight =
    class "mdc-theme--text-icon-on-light"


textPrimaryOnDark : Html.Attribute msg
textPrimaryOnDark =
    class "mdc-theme--text-primary-on-dark"


textSecondaryOnDark : Html.Attribute msg
textSecondaryOnDark =
    class "mdc-theme--text-secondary-on-dark"


textHintOnDark : Html.Attribute msg
textHintOnDark =
    class "mdc-theme--text-hint-on-dark"


textDisabledOnDark : Html.Attribute msg
textDisabledOnDark =
    class "mdc-theme--text-disabled-on-dark"


textIconOnDark : Html.Attribute msg
textIconOnDark =
    class "mdc-theme--text-icon-on-dark"


textPrimaryOnBackground : Html.Attribute msg
textPrimaryOnBackground =
    class "mdc-theme--text-primary-on-background"


textSecondaryOnBackground : Html.Attribute msg
textSecondaryOnBackground =
    class "mdc-theme--text-secondary-on-background"


textHintOnBackground : Html.Attribute msg
textHintOnBackground =
    class "mdc-theme--text-hint-on-background"


textDisabledOnBackground : Html.Attribute msg
textDisabledOnBackground =
    class "mdc-theme--text-disabled-on-background"


textIconOnBackground : Html.Attribute msg
textIconOnBackground =
    class "mdc-theme--text-icon-on-background"
