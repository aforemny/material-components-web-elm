set -e

to_markdown=$(cat <<EOF
let
  parse keep (('{':'-':'|':' ':line):lines) = line:parse True lines
  parse keep (('-':'}':_):lines) = parse False lines
  parse keep (line:lines) = if keep then line:parse keep lines else parse keep lines
  parse keep [] = []
in
interact (unlines . parse False . lines)
EOF
)

find src -name \*.elm | while read -r fn; do
  cat "$fn" \
    | ghc -e "$to_markdown" \
    | pandoc -f MARKDOWN -t MARKDOWN --filter "$(dirname $0)/test-docs.hs" > /dev/null
done
