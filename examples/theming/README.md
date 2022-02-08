# theming

## resources

- [mdc-theme#readme](https://github.com/material-components/material-components-web/tree/master/packages/mdc-theme#readme)

## run the example

```
$ npm ci
$ parcel src/index.html
```

## steps

- remove `material-components-web-elm` CSS resource from index.html
- install material-components-web in the matching version
  - **note** due to an upstream bug, currently you would install material-components-web@13.0.0 instead of @11.0.0
- configure sass support in your bundler
  - you might have to include `node_modules` in its include path
- use `@material/theme` before including material-component-web's SCSS sources
