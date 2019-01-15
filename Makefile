build:
	webpack --mode=development
	elm make demo/Main.elm --output demo.js
