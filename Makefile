all: build-pages


build-npm: node_modules src/**/component.ts src/**/custom-element.js
	tsc --project ./tsconfig.json --module esnext --importHelpers
	webpack --mode=production
	cp node_modules/material-components-web/dist/material-components-web.css dist/material-components-web-elm.css
	cp node_modules/material-components-web/dist/material-components-web.css.map dist/material-components-web-elm.css.map
	cp node_modules/material-components-web/dist/material-components-web.min.css dist/material-components-web-elm.min.css
	cp node_modules/material-components-web/dist/material-components-web.min.css.map dist/material-components-web-elm.min.css.map


build-pages: build-npm build-demo
	mkdir -p gh-pages
	rsync --delete -r demo/images gh-pages
	cp demo/page.html gh-pages/index.html
	cp demo/demo.js gh-pages
	cp dist/material-components-web-elm.js gh-pages
	cp dist/material-components-web-elm.js.map gh-pages
	cp dist/material-components-web-elm.min.js gh-pages
	cp dist/material-components-web-elm.min.js.map gh-pages
	cp dist/material-components-web-elm.css gh-pages
	cp dist/material-components-web-elm.css.map gh-pages
	cp dist/material-components-web-elm.min.css gh-pages
	cp dist/material-components-web-elm.min.css.map gh-pages


build-demo:
	(cd demo && make)


build-examples:
	(cd examples/simple-counter && make)


build-docs: src/**/*.elm
	elm make --docs=docs.json


commit-pages: build-pages
	(cd gh-pages && git add . && git commit -m 'Update' && git push)


docs: node_modules
	elm-doc-preview


release: distclean build-pages build-examples build-docs


node_modules:
	npm install


clean:
	find src -name "*.d.ts" | xargs rm -f
	find src -name "component.js" | xargs rm -f
	find src -name "*.js.map" | xargs rm -f
	find src -name "*.patch" | xargs rm -f
	find src -name "*.ts.orig" | xargs rm -f
	rm -rf dist
	rm -f docs.json
	(cd demo && make clean)
	(cd examples/simple-counter && make clean)


distclean: clean
	rm -rf elm-stuff node_modules
	(cd demo && make distclean)
	(cd examples/simple-counter && make distclean)
