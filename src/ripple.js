import { getClassName, setClassName } from "./utils";
import { MDCRipple } from "@material/ripple/index";

class MdcRipple extends HTMLElement {

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
    this.mdcRipple = new MDCRipple(this);
  }

  disconnectedCallback() {
    if (this.mdcRipple) {
      this.mdcRipple.destroy();
      delete this.mdcRipple;
    }
  }
};

customElements.define("mdc-ripple", MdcRipple);
