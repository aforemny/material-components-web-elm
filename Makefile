build: node_modules
	mkdir -p gh-pages
	tsc --project ./tsconfig.json --module esnext --importHelpers
	webpack --mode=development
	(cd demo && make)
	rsync --delete -r demo/images gh-pages
	cp demo/page.html gh-pages/index.html
	cp demo/demo.js gh-pages
	cp dist/material-components-web-elm.min.js gh-pages
	cp node_modules/material-components-web/dist/material-components-web.min.css dist/material-components-web-elm.min.css


docs: node_modules
	elm-doc-preview


pages: distclean node_modules
	mkdir -p gh-pages
	tsc --project ./tsconfig.json --module esnext --importHelpers
	webpack --mode=production
	(cd demo && make)
	rsync --delete -r demo/images gh-pages
	cp demo/page.html gh-pages/index.html
	cp demo/demo.js gh-pages
	cp dist/material-components-web-elm.min.js gh-pages
	cp node_modules/material-components-web/dist/material-components-web.min.css dist/material-components-web-elm.min.css
	cp node_modules/material-components-web/dist/material-components-web.min.css gh-pages/material-components-web-elm.min.css
	(cd gh-pages && git add . && git commit -m 'Update' && git push)


release: distclean node_modules
	(cd demo && make)
	(cd examples/simple-counter && make)
	elm make --docs=docs.json
	rm -rf docs.json
	tsc --project ./tsconfig.json --module esnext --importHelpers
	webpack --mode=production
	cp node_modules/material-components-web/dist/material-components-web.min.css dist/material-components-web-elm.min.css


node_modules:
	npm install


clean:
	find src -name "*.d.ts" | xargs rm -f
	find src -name "component.js" | xargs rm -f
	find src -name "*.js.map" | xargs rm -f
	find src -name "*.patch" | xargs rm -f
	find src -name "*.ts.orig" | xargs rm -f
	rm -rf dist
	(cd demo && make clean)
	(cd examples/simple-counter && make clean)


distclean: clean
	rm -rf elm-stuff node_modules
	(cd demo && make distclean)
	(cd examples/simple-counter && make distclean)
