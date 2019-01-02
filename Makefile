build:
	webpack --mode=development
	elm make --optimize demo/Main.elm --output demo.js
