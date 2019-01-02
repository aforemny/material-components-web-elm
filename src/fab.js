import { MDCRipple } from "@material/ripple/index";

class MdcFab extends HTMLElement {

  constructor() {
    super();
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
