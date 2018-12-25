import { MDCRipple } from "@material/ripple/index";

class MdcButton extends HTMLElement {

  constructor() {
    super();
  }

  connectedCallback() {
    this.MDCRipple = MDCRipple.attachTo(this);
  }

  disconnectedCallback() {
    if (typeof this.MDCRipple !== "undefined") {
      this.MDCRipple.destroy();
      delete this.MDCRipple;
    }
  }
};

customElements.define("mdc-button", MdcButton);
