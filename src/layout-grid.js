import { getClassName, setClassName } from "./utils";

class MdcLayoutGrid extends HTMLElement {

  constructor() {
    super();
    this.className_ = "";
  }

  get className() {
    return getClassName.call(this);
  }

  set className(className) {
    setClassName.call(this, className);
  }

  connectedCallback() {
  }

  disconnectedCallback() {
  }
};

customElements.define("mdc-layout-grid", MdcLayoutGrid);
