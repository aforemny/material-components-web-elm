import { MDCRipple } from "@material/ripple/index";

export default class MdcCard extends HTMLElement {

  constructor() {
    super();
    this.ripple_;
  }

  connectedCallback() {
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
