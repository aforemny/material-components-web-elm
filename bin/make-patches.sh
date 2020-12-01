set -ex

for fn in src/*/{foundation,component,util}.ts; do
  file=$(basename $fn .ts)
  dir=$(dirname $fn)
  component=$(basename $dir)
  case $(basename $dir) in
    "text-field")
      component="textfield"
      ;;
    "chip")
      component="chips/chip"
      ;;
    "chip-set")
      component="chips/chip-set"
      ;;
    *)
      ;;
  esac
  cp material-components-web/packages/mdc-$component/$file.ts $dir/$file.ts.orig
  diff -rupN $dir/$file.ts.orig $dir/$file.ts > $dir/$file.patch || true
  rm $dir/$file.ts.orig
done
