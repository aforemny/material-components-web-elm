find src -name component.patch | while read fn; do
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
  cp material-components-web/packages/mdc-$component/component.ts $dir/component.ts
  patch -p0 <$fn
done
