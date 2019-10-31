import { MDCRipple } from "@material/ripple/index";

class MdcFab extends HTMLElement {

  constructor() {
    super();
  }

  connectedCallback() {
    this.ripple_ = new MDCRipple(this);
  }

  disconnectedCallback() {
    this.ripple_.destroy();
  }
};

customElements.define("mdc-fab", MdcFab);
