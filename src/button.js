import { getClassName, setClassName } from "./utils";
import { MDCRipple } from "@material/ripple/index";

class MdcButton extends HTMLElement {

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
    this.ripple_ = MDCRipple.attachTo(this);
    this.tabIndex = 0;
  }

  disconnectedCallback() {
    this.ripple_.destroy();
  }
};

customElements.define("mdc-button", MdcButton);
