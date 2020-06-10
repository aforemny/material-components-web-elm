import { MDCRipple } from "../ripple/component";
import {
  installClassNameChangeHook,
  uninstallClassNameChangeHook,
} from "../utils/className";

export default class MdcCard extends HTMLElement {

  constructor() {
    super();
    this.ripple_;
  }

  connectedCallback() {
    installClassNameChangeHook.call(this);
    const primaryActionElement = this.querySelector(".mdc-card__primary-action");
    if (primaryActionElement) {
      this.ripple_ = new MDCRipple(primaryActionElement);
    }
  }

  disconnectedCallback() {
    if (this.ripple_) {
      this.ripple_.destroy();
    }
    uninstallClassNameChangeHook.call(this);
  }
};

customElements.define("mdc-card", MdcCard);
