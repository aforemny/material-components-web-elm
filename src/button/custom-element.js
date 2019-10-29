import { MDCRipple } from "@material/ripple/index";

export default class MdcButton extends HTMLElement {

  constructor() {
    super();
    this.ripple;
  }

  connectedCallback() {
    this.ripple_ = new MDCRipple(this);
  }

  disconnectedCallback() {
    this.ripple_.destroy();
  }
};

customElements.define("mdc-button", MdcButton);
