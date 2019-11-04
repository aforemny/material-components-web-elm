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
