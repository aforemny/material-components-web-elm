fetch=$(mktemp fetch.XXXXXX.js)

cat > "$fetch" <<EOF
const connect = require("connect");
const serveStatic = require("serve-static");
const puppeteer = require("puppeteer-core");
const http = require("http");

(async () => {

  const root = process.argv[2];
  const urls = process.argv.slice(3);
  const app = connect().use(serveStatic("./gh-pages"));
  const server = http.createServer(app);
  await new Promise((resolve, reject) => server.listen(8080, () => resolve()));

  const browser = await puppeteer.launch({
    headless: true,
    executablePath: process.env.CHROMIUM_PATH
  });
  let errors = [];

  for (url of urls) {
    const page = await browser.newPage();
    await page.goto(url);
    if (await page.\$eval("body", node => !!node.innerText.match(/404/))) {
      errors.push(url);
    }
  }

  for (error of errors) {
    console.log(error);
  }

  await browser.close();
  await new Promise((resolve, reject) => server.close(() => resolve()));

  process.exit(errors.length === 0 ? 0 : 1);
})();
EOF

find src -name "*.elm" \
  | xargs grep -h -o -E '\((https://aforemny.github.io/material-components-web-elm.*)\)' \
  | sed 's/[()]//g' \
  | sort \
  | uniq \
  | sed 's@.*#@http://localhost:8080/#@' \
  | xargs node "$fetch" ./gh-pages

code="$?"

rm -f "$fetch"

exit $code
