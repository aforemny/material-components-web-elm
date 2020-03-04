![build](https://github.com/aforemny/material-components-web-elm/workflows/build/badge.svg)

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
2.1.2) exactly.

```html
<link href="https://fonts.googleapis.com/css?family=Roboto:300,400,500|Material+Icons" rel="stylesheet">
<link rel="stylesheet" href="https://unpkg.com/material-components-web-elm@2.1.2/dist/material-components-web-elm.min.css">
<script src="https://unpkg.com/material-components-web-elm@2.1.2/dist/material-components-web-elm.min.js"></script>
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
$ npm install --save material-components-web-elm@2.1.2
```

Then in your `index.js` add the following imports:

```js
require("material-components-web/dist/material-components-web.js");
require("material-components-web/dist/material-components-web.css");
```

### Setup using create-elm-app

Set up your project using

```sh
npm install create-elm-app -g
create-elm-app my-app
cd my-app/
```
and install materia-components-web-elm:

```sh
elm install aforemny/material-components-web-elm
```
If you want to **use CDN** to get the material-component-web-elm javascript/css files, then add the following lines to your `public/index.html`

```html
<link rel="stylesheet" href="https://unpkg.com/material-components-web-elm@2.1.2/dist/material-components-web-elm.min.css">
<script src="https://unpkg.com/material-components-web-elm@2.1.2/dist/material-components-web-elm.min.js"></script>
```

If you want to **bundle these files with your project**, you need to install them 
```sh
npm install --save material-components-web-elm@2.1.2
```
and import them in the to of your `src/index.js.

```js
require("material-components-web/dist/material-components-web.js");
require("material-components-web/dist/material-components-web.css");
```
#### Roboto Fonts and Material Icons

In the Html instructions, there was also an Import for the Roboto Font and the Material Icons. 
If you want to **use a CDN** to get both, then add the following line to your `public/index.html`:

```html
<link href="https://fonts.googleapis.com/css?family=Roboto:300,400,500|Material+Icons" rel="stylesheet">
```
(Not Recommended:) If you want to **bundle directly with your app**, you need to install both. Here are some example packages, feel free to swap for your preferred:

```sh
npm install --save typeface-roboto
npm install webpack-icons-installer -g
npm link webpack-icons-installer
```
And in `src/index.js` import on the top

```js
require('webpack-icons-installer/google');
require('typeface-roboto');
```


#### Bug
As the time of writing, Firefox happen to dislike how `create-elm-app` implements the serviceWorker. If you see **Unhandled Rejection (SecurityError): The operation is insecure.**, try replacing in `src/index.js`:

```js
serviceWorker.unregister();
```
to 
```js
serviceWorker.register();
```

## Contributions

Please [share your
experience](https://github.com/aforemny/material-components-web-elm/issues)
using this library! Use GitHub to [report bugs or ask
questions](https://github.com/aforemny/material-components-web-elm/issues),
too.
