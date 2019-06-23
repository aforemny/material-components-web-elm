import { getClassName, setClassName } from "./utils";

class MdcIcon extends HTMLElement {

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

customElements.define("mdc-icon", MdcIcon);
