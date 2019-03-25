import { MDCRipple } from "@material/ripple/index";

class MdcRipple extends HTMLElement {

  constructor() {
    super();
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
