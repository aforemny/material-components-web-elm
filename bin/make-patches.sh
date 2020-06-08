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
    "chip-set")
      component="chips/chip-set"
      ;;
    *)
      ;;
  esac
  if test -d $dir/foundation.ts; then
    cp material-foundations-web/packages/mdc-$foundation/foundation.ts $dir/foundation.ts.orig
    diff -rupN $dir/foundation.ts.orig $dir/foundation.ts > $dir/foundation.patch || true
    rm $dir/foundation.ts.orig
  fi
  if test -d $dir/component.ts; then
    cp material-components-web/packages/mdc-$component/component.ts $dir/component.ts.orig
    diff -rupN $dir/component.ts.orig $dir/component.ts > $dir/component.patch || true
    rm $dir/component.ts.orig
  fi
done
