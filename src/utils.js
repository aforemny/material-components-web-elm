export function getClassName() {
  return ''+this.classList;
}

export function setClassName(className) {
    let css = className.split(" ").filter(cs => cs !== "");
    for (let cs of css) {
      this.classList.add(cs);
    }
    for (let cs of this.className_.split(" ").filter(cs => cs !== "")) {
      if (!css.includes(cs)) {
        this.classList.remove(cs);
      }
    }
    this.className_ = className;
}
