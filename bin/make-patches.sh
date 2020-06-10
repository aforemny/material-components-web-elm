set -e

find src -name component.ts | while read fn; do
  dir=$(dirname $fn)
  component=$(basename $dir)
  case $(basename $dir) in
    "text-field")
      component="textfield"
      ;;
    "chip")
      component="chips/chip"
      ;;
    *)
      ;;
  esac
  cp material-components-web/packages/mdc-$component/component.ts $dir/component.ts.orig
  diff -rupN $dir/component.ts.orig $dir/component.ts > $dir/component.patch || true
  rm $dir/component.ts.orig
done
