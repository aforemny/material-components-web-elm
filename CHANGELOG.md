# Changelog

All notable changes to this project will be documented in this file. See [standard-version](https://github.com/conventional-changelog/standard-version) for commit guidelines.

### 2.0.1 (2019-11-26)


### Features

* Update to MDC Web v2.3.1 ([7468981](https://github.com/aforemny/material-components-web-elm/commit/746898135eee6f6b714b3959dc74f4a45d33fde1))


### Bug Fixes

* Fix determinate linear progress variants ([e9c3c8c](https://github.com/aforemny/material-components-web-elm/commit/e9c3c8c21b91e113ca93d64e762eca49cbf598d9))
* Fix ripple for buttons ([8d59940](https://github.com/aforemny/material-components-web-elm/commit/8d59940d5cefaf78da6689ab6a5d68a29967943c))
* Fix snackbar crashing when messages cycled very quickly ([c816c5b](https://github.com/aforemny/material-components-web-elm/commit/c816c5bf80ca536366c86353354583a0212f5803))

## 2.0.0 (2019-11-14)


### ⚠ BREAKING CHANGES

* Card.actionIcon now takes a IconButtonConfig instead of
a IconConfig as first argument
* CheckboxConfig.onClick has been renamed to
CheckboxConfig.onChange
* TextFieldConfig.invalid has been replaced by
TextFieldConfig.valid (default to True). The same is true for
TextAreaConfig
* SnackbarConfig has been extended by a field
`closesOnEscape : Bool`. Additionally, Snackbar.Message's configuration
field timeoutMs has been changed from Float to Int
* SliderConfig.step has been changed from taking a `Maybe
Float` to taking a `Float` only
* SwitchConfig.onClick has been renamed to
SwitchConfig.onChange
* The function ripple has been renamed to boundedRipple.
RippleConfig does not contain the field `unbounded` anymore
* Functions listItem, listItemDivider and
listGroupSubheader now return `ListItem msg` instead of `Html msg`. The
function list has been changed accordingly.
* IconToggleConfig.onClick has been renamed to
IconToggleConfig.onChange
* DismissibleDrawerConfig has been extended by a field
`onClose : Maybe msg`. This facilitates the dismissible drawer closing
on pressing the Escape key.
* SelectConfig has been extended by the following boolean
fields: disabled, required and valid

### Features

* Add fields href, target to ButtonConfig ([3c60856](https://github.com/aforemny/material-components-web-elm/commit/3c60856d469a8afac2ada735c6093159978783fc))
* Add href to ListItemConfig ([6773780](https://github.com/aforemny/material-components-web-elm/commit/6773780bd065b05e9ca8e71079b117eb58fae076))
* Card.actionIcon is now based on IconButton ([0a4a5c0](https://github.com/aforemny/material-components-web-elm/commit/0a4a5c0935b2f5a0858355a8204cb213f51b6acf))


### Bug Fixes

* Checkbox no longer plays animation when initially rendered as checked or indeterminate ([0b8f623](https://github.com/aforemny/material-components-web-elm/commit/0b8f6237020053a15d21614f91275c92bbe8690a))
* Dialog applies additionalAttributes ([02fae12](https://github.com/aforemny/material-components-web-elm/commit/02fae12186c22de3a21c1f87be5ee02d3671d064))
* Disabled buttons now work ([97a66f4](https://github.com/aforemny/material-components-web-elm/commit/97a66f4a1db82efa3fd345f95a0b6010899ffecf))


* Update checkbox implementation ([78f99d4](https://github.com/aforemny/material-components-web-elm/commit/78f99d4e66c15c91f0db4a9131383cf6533b6f6d))
* Update drawer implementation ([83aa9d8](https://github.com/aforemny/material-components-web-elm/commit/83aa9d8d185761557cd7903a5ab200c18ec17acf))
* Update icon button implementation ([7fde683](https://github.com/aforemny/material-components-web-elm/commit/7fde6838c8bac6b55250f090c3bce349198353b5))
* Update image list item implementation ([22d3a7d](https://github.com/aforemny/material-components-web-elm/commit/22d3a7d169b1e53d49ee6f5934d347ab1f35fb99))
* Update ripple implementation ([704f9e8](https://github.com/aforemny/material-components-web-elm/commit/704f9e8691ba93b60257c4f9fbd63d936d5e7f35))
* Update select implementation ([94e7a0c](https://github.com/aforemny/material-components-web-elm/commit/94e7a0c31ac957916121ae539d7de3be34f2e283))
* Update slider implementation ([bf7ad91](https://github.com/aforemny/material-components-web-elm/commit/bf7ad9182eb5a8cb43d48edfcafc94e1a0fae9b0))
* Update snackbar implementation ([278ea96](https://github.com/aforemny/material-components-web-elm/commit/278ea96805a21583b9f2f5a2c8d030f7fec76da2))
* Update switch implementation ([11d10a8](https://github.com/aforemny/material-components-web-elm/commit/11d10a8b7835e723eb0328007d69c1089d9469b0))
* Update text field implementation ([b4a73ca](https://github.com/aforemny/material-components-web-elm/commit/b4a73cab6d987664fd79bfef184ec174f3ae8327))

### 1.0.1 (2019-10-27)


### Bug Fixes

* Add ripple to image list items ([1e81d39](https://github.com/aforemny/material-components-web-elm/commit/1e81d392b10cae65c09f5831b2174a11808d682a))
* Add support for Elm 0.19.1 ([94d1137](https://github.com/aforemny/material-components-web-elm/commit/94d113733a35fd2a921f42f6fb81d3e1f8a4b977))
* Permanent drawer destroys foundation ([e7c8bef](https://github.com/aforemny/material-components-web-elm/commit/e7c8bef5fa587a928e820915318f19d8503cd035))

## 1.0.0 (2019-09-29)


### Bug Fixes

* **docs:** Use CDN links in README and examples ([a3859d2](https://github.com/aforemny/material-components-web-elm/commit/a3859d2ba115198dff64148c85bf591aac133705))

## 2.0.0 (2019-11-14)


### ⚠ BREAKING CHANGES

* Card.actionIcon now takes a IconButtonConfig instead of
a IconConfig as first argument
* CheckboxConfig.onClick has been renamed to
CheckboxConfig.onChange
* TextFieldConfig.invalid has been replaced by
TextFieldConfig.valid (default to True). The same is true for
TextAreaConfig
* SnackbarConfig has been extended by a field
`closesOnEscape : Bool`. Additionally, Snackbar.Message's configuration
field timeoutMs has been changed from Float to Int
* SliderConfig.step has been changed from taking a `Maybe
Float` to taking a `Float` only
* SwitchConfig.onClick has been renamed to
SwitchConfig.onChange
* The function ripple has been renamed to boundedRipple.
RippleConfig does not contain the field `unbounded` anymore
* Functions listItem, listItemDivider and
listGroupSubheader now return `ListItem msg` instead of `Html msg`. The
function list has been changed accordingly.
* IconToggleConfig.onClick has been renamed to
IconToggleConfig.onChange
* DismissibleDrawerConfig has been extended by a field
`onClose : Maybe msg`. This facilitates the dismissible drawer closing
on pressing the Escape key.
* SelectConfig has been extended by the following boolean
fields: disabled, required and valid

### Features

* Add fields href, target to ButtonConfig ([3c60856](https://github.com/aforemny/material-components-web-elm/commit/3c60856d469a8afac2ada735c6093159978783fc))
* Add href to ListItemConfig ([6773780](https://github.com/aforemny/material-components-web-elm/commit/6773780bd065b05e9ca8e71079b117eb58fae076))
* Card.actionIcon is now based on IconButton ([0a4a5c0](https://github.com/aforemny/material-components-web-elm/commit/0a4a5c0935b2f5a0858355a8204cb213f51b6acf))


### Bug Fixes

* Checkbox no longer plays animation when initially rendered as checked or indeterminate ([0b8f623](https://github.com/aforemny/material-components-web-elm/commit/0b8f6237020053a15d21614f91275c92bbe8690a))
* Dialog applies additionalAttributes ([02fae12](https://github.com/aforemny/material-components-web-elm/commit/02fae12186c22de3a21c1f87be5ee02d3671d064))
* Disabled buttons now work ([97a66f4](https://github.com/aforemny/material-components-web-elm/commit/97a66f4a1db82efa3fd345f95a0b6010899ffecf))


* Update checkbox implementation ([78f99d4](https://github.com/aforemny/material-components-web-elm/commit/78f99d4e66c15c91f0db4a9131383cf6533b6f6d))
* Update drawer implementation ([83aa9d8](https://github.com/aforemny/material-components-web-elm/commit/83aa9d8d185761557cd7903a5ab200c18ec17acf))
* Update icon button implementation ([7fde683](https://github.com/aforemny/material-components-web-elm/commit/7fde6838c8bac6b55250f090c3bce349198353b5))
* Update image list item implementation ([22d3a7d](https://github.com/aforemny/material-components-web-elm/commit/22d3a7d169b1e53d49ee6f5934d347ab1f35fb99))
* Update ripple implementation ([704f9e8](https://github.com/aforemny/material-components-web-elm/commit/704f9e8691ba93b60257c4f9fbd63d936d5e7f35))
* Update select implementation ([94e7a0c](https://github.com/aforemny/material-components-web-elm/commit/94e7a0c31ac957916121ae539d7de3be34f2e283))
* Update slider implementation ([bf7ad91](https://github.com/aforemny/material-components-web-elm/commit/bf7ad9182eb5a8cb43d48edfcafc94e1a0fae9b0))
* Update snackbar implementation ([278ea96](https://github.com/aforemny/material-components-web-elm/commit/278ea96805a21583b9f2f5a2c8d030f7fec76da2))
* Update switch implementation ([11d10a8](https://github.com/aforemny/material-components-web-elm/commit/11d10a8b7835e723eb0328007d69c1089d9469b0))
* Update text field implementation ([b4a73ca](https://github.com/aforemny/material-components-web-elm/commit/b4a73cab6d987664fd79bfef184ec174f3ae8327))

### 1.0.1 (2019-10-27)


### Bug Fixes

* Add ripple to image list items ([1e81d39](https://github.com/aforemny/material-components-web-elm/commit/1e81d392b10cae65c09f5831b2174a11808d682a))
* Add support for Elm 0.19.1 ([94d1137](https://github.com/aforemny/material-components-web-elm/commit/94d113733a35fd2a921f42f6fb81d3e1f8a4b977))
* Permanent drawer destroys foundation ([e7c8bef](https://github.com/aforemny/material-components-web-elm/commit/e7c8bef5fa587a928e820915318f19d8503cd035))

## 1.0.0 (2019-09-29)


### Bug Fixes

* **docs:** Use CDN links in README and examples ([a3859d2](https://github.com/aforemny/material-components-web-elm/commit/a3859d2ba115198dff64148c85bf591aac133705))

### [1.0.1](https://github.com/aforemny/material-components-web-elm/compare/v1.0.0...v1.0.1) (2019-10-27)


### Bug Fixes

* Add ripple to image list items ([1e81d39](https://github.com/aforemny/material-components-web-elm/commit/1e81d39))
* Add support for Elm 0.19.1 ([94d1137](https://github.com/aforemny/material-components-web-elm/commit/94d1137))
* Permanent drawer destroys foundation ([e7c8bef](https://github.com/aforemny/material-components-web-elm/commit/e7c8bef))
