build: node_modules
	webpack --mode=development
	cp node_modules/material-components-web/dist/material-components-web.min.css dist/material-components-elm.min.css
	(cd demo && make)

release: distclean node_modules
	mkdir -p dist
	webpack --mode=production
	cp node_modules/material-components-web/dist/material-components-web.min.css dist/material-components-elm.min.css

pages:
	mkdir -p gh-pages
	(cd demo && make)
	rsync --delete -r demo/images gh-pages
	cp demo/page.html gh-pages/index.html
	cp demo/demo.js gh-pages
	cp dist/material-components-elm.min.js dist/material-components-elm.min.css gh-pages
	(cd gh-pages && git add . && git commit -m 'Update' && git push)

node_modules:
	npm install

clean:
	rm -rf dist
	(cd demo && make clean)

distclean: clean
	rm -rf elm-stuff node_modules
	(cd demo && make distclean)
