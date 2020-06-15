all: build-pages


build-npm: node_modules src/**/component.ts src/**/custom-element.js
	tsc --project ./tsconfig.json --module esnext --importHelpers
	webpack --mode=production
	cp node_modules/material-components-web/dist/material-components-web.css dist/material-components-web-elm.css
	cp node_modules/material-components-web/dist/material-components-web.css.map dist/material-components-web-elm.css.map
	cp node_modules/material-components-web/dist/material-components-web.min.css dist/material-components-web-elm.min.css
	cp node_modules/material-components-web/dist/material-components-web.min.css.map dist/material-components-web-elm.min.css.map


build-pages: build-npm build-demo
	mkdir -p public
	rsync --delete -r demo/images public
	cp demo/page.html public/index.html
	cp demo/demo.js public
	cp dist/material-components-web-elm.js public
	cp dist/material-components-web-elm.js.map public
	cp dist/material-components-web-elm.min.js public
	cp dist/material-components-web-elm.min.js.map public
	cp dist/material-components-web-elm.css public
	cp dist/material-components-web-elm.css.map public
	cp dist/material-components-web-elm.min.css public
	cp dist/material-components-web-elm.min.css.map public


build-demo:
	(cd demo && make)


build-examples:
	(cd examples/simple-counter && make)


build-docs: src/**/*.elm
	elm make --docs=docs.json


do-review: node_modules
	elm-review
	(cd demo && ../node_modules/.bin/elm-review)


commit-pages: build-pages
	(cd public && git add . && git commit -m 'Update' && git push)


docs: node_modules
	elm-doc-preview


release: distclean build-pages build-examples build-docs do-review


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
