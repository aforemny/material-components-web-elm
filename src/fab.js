import { getClassName, setClassName } from "./utils";
import { MDCRipple } from "@material/ripple/index";

class MdcFab extends HTMLElement {

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
    this.MDCRipple = new MDCRipple(this);
  }

  disconnectedCallback() {
    if (typeof this.MDCRipple !== "undefined") {
      this.MDCRipple.destroy();
      delete this.MDCRipple;
    }
  }
};

customElements.define("mdc-fab", MdcFab);
