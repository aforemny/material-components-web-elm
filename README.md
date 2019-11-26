# Material Components for Elm

A [Material Design](https://material.io/design) framework.

This library is based on [Material Components for the
web](https://github.com/material-components/material-components-web) (MDC Web).


## Important links

- Getting Started Guide (TODO)
- [Demo](https://aforemny.github.io/material-components-web-elm)


## Quick start

This package relies upon JavaScript and CSS that need to be included in your
project separately. As a result, this library will *not* work with e.g. `elm
reactor`. Instead you will need to use either an HTML file or a bundler, such
as webpack.


### Using HTML
 
You should [compile your Elm program to
JavaScript](https://guide.elm-lang.org/install/elm.html#elm-make) and include it
in a custom HTML document. From your HTML document, you have to include the
following assets to use this library.

Please make sure that the last two assets match this library's version (ie.
2.0.1) exactly.

```html
<link href="https://fonts.googleapis.com/css?family=Roboto:300,400,500|Material+Icons" rel="stylesheet">
<link rel="stylesheet" href="https://unpkg.com/material-components-web-elm@2.0.1/dist/material-components-web-elm.min.css">
<script src="https://unpkg.com/material-components-web-elm@2.0.1/dist/material-components-web-elm.min.js"></script>
```

Refer to the [simple counter
example](https://github.com/aforemny/material-components-web-elm/blob/master/examples/simple-counter)
for a minimal starting point, specifically to the files
[`src/Main.elm`](https://github.com/aforemny/material-components-web-elm/blob/master/examples/simple-counter/src/Main.elm)
and
[`page.html`](https://github.com/aforemny/material-components-web-elm/blob/master/examples/simple-counter/page.html).


### Using a bundler

Install the assets JavaScript and CSS assets via npm:

```sh
$ npm install --save material-components-web-elm@2.0.1
```

Then in your `index.js` add the following imports:

```js
require("material-components-web/dist/material-components-web.js");
require("material-components-web/dist/material-components-web.css")
```


## Contributions

Please [share your
experience](https://github.com/aforemny/material-components-web-elm/issues)
using this library! Use GitHub to [report bugs or ask
questions](https://github.com/aforemny/material-components-web-elm/issues),
too.
