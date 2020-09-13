for fn in src/*/{foundation,component,util}.ts; do
  file=$(basename $fn .patch)
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
  cp material-components-web/packages/mdc-$component/$file.ts $dir/$file.ts
  patch -p0 <$fn
done
