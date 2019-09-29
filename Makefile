build: node_modules
	mkdir -p gh-pages
	webpack --mode=development
	(cd demo && make)
	rsync --delete -r demo/images gh-pages
	cp demo/page.html gh-pages/index.html
	cp demo/demo.js gh-pages
	cp dist/material-components-elm.min.js gh-pages
	cp node_modules/material-components-web/dist/material-components-web.min.css dist

docs: node_modules
	elm-doc-preview


pages: distclean node_modules
	mkdir -p gh-pages
	webpack --mode=production
	(cd demo && make)
	rsync --delete -r demo/images gh-pages
	cp demo/page.html gh-pages/index.html
	cp demo/demo.js gh-pages
	cp dist/material-components-elm.min.js gh-pages
	cp node_modules/material-components-web/dist/material-components-web.min.css dist
	(cd gh-pages && git add . && git commit -m 'Update' && git push)


release: distclean node_modules
	(cd demo && make)
	(cd examples/simple-counter && make)
	mkdir -p dist
	webpack --mode=production
	cp node_modules/material-components-web/dist/material-components-web.min.css dist


node_modules:
	npm install


clean:
	rm -rf dist
	(cd demo && make clean)
	(cd examples/simple-counter && make clean)


distclean: clean
	rm -rf elm-stuff node_modules
	(cd demo && make distclean)
	(cd examples/simple-counter && make distclean)
