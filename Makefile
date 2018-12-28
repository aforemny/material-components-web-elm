build:
	webpack
	elm make --optimize demo/Main.elm --output demo.js
