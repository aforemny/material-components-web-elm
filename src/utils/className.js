/* Material Components frequently enhance their DOM elements with additional
 * class names that depend on component state (ie. has focus) rather than
 * configuration state (ie. text field value).
 *
 * Since the component state is unknown to Elm, we cannot control those class
 * names in Elm. On the other hand, Elm does controls some class names (ie.
 * mdc-text-field).
 *
 * This means that currently, Elm's virtual dom library assumes sole control
 * over class names, since it sets a DOM node's `className` property. Thus, if
 * a Elm-controlled class name changes, it might delete additional uncontrolled
 * class names.
 *
 * We work around this issue by patching a DOM node's `className` property in
 * the following way:
 * (1) We may assume that Elm only ever touches `className`
 * (2) We may assume that Material Components only ever touch `classList`
 *
 * Thus, whenever a write to `className` happens, we record the list of classes
 * that Elm has control over (classes that have been added via `className`).
 * Then we identify classes removed via `className`, and we only allow removal
 * of classes that Elm has control over. Classes added via the `classList`
 * property cannot be removed via the `className` property.
 *
 * We will not require this fix anymore once Elm's virtual dom implementation
 * uses `classList.add`, `classList.remove` to manage class names.
 */

function setClassName(className) {
  const css = className.split(" ").filter(cs => cs !== "");
  for (let cs of css) {
    this.classList.add(cs)
  };
  for (let cs of this.className_) {
    if (!css.includes(cs)) this.classList.remove(cs);
  }
  this.className_ = css;
}

function getClassName() {
  return `${this.classList}`;
}

export function installClassNameChangeHook() {
  Object.defineProperty(this, "className", {
    get: getClassName.bind(this),
    set: setClassName.bind(this),
    configurable: true,
  });
  this.className_ = [...this.classList];
};

export function uninstallClassNameChangeHook() {
  let object = Object.getPrototypeOf(this);
  let descriptor;
  while (!(descriptor = Object.getOwnPropertyDescriptor(object, "className"))) {
    object = Object.getPrototypeOf(object);
  }
  Object.defineProperty(this, "className", descriptor);
  delete this.className_;
  this.className = getClassName.call(this);
};
