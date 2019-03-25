import { MDCRipple } from "@material/ripple/index";

class MdcButton extends HTMLElement {

  constructor() {
    super();
  }

  connectedCallback() {
    this.mdcRipple = MDCRipple.attachTo(this);
    this.tabIndex = 0;
  }

  disconnectedCallback() {
    if (typeof this.mdcRipple !== "undefined") {
      this.mdcRipple.destroy();
      delete this.mdcRipple;
    }
  }
};

customElements.define("mdc-button", MdcButton);
