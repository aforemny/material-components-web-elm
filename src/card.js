import { getClassName, setClassName } from "./utils";
import { MDCRipple } from "@material/ripple/index";

class MdcCard extends HTMLElement {

  constructor() {
    super();
    this.ripple_;
    this.className_ = "";
  }

  get className() {
    return getClassName.call(this);
  }

  set className(className) {
    setClassName.call(this, className);
  }

  connectedCallback() {
    this.initRipple_();
  }

  initRipple_() {
    const primaryActionElement = this.querySelector(".mdc-card__primary-action");
    if (primaryActionElement) {
      this.ripple_ = new MDCRipple(primaryActionElement);
    }
  }

  disconnectedCallback() {
    if (this.ripple_) {
      this.ripple_.destroy();
    }
  }
};

customElements.define("mdc-card", MdcCard);
