build: node_modules
	webpack --mode=development
	elm make demo/Main.elm --output demo.js

release: distclean node_modules
	mkdir -p dist
	webpack --mode=production
	elm make --optimize demo/Main.elm --output demo.js
	cp node_modules/material-components-web/dist/material-components-web.min.css dist/material-components-elm.min.css

node_modules:
	npm install

clean:
	rm -rf dist

distclean: clean
	rm -rf elm-stuff node_modules
