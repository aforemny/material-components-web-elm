import { MDCRipple } from "../ripple/component";
import {
  installClassNameChangeHook,
  uninstallClassNameChangeHook,
} from "../utils/className";

export default class MdcCard extends HTMLElement {

  focus() {
    if (!!this.primaryAction_) {
      this.primaryAction_.focus();
    }
  }

  blur() {
    if (!!this.primaryAction_) {
      this.primaryAction_.blur();
    }
  }

  constructor() {
    super();
    this.primaryAction_;
    this.ripple_;
  }

  connectedCallback() {
    installClassNameChangeHook.call(this);

    const primaryActionElement = this.querySelector(".mdc-card__primary-action");
    if (!!primaryActionElement) {
      this.primaryAction_ = primaryActionElement;
    }

    if (!!this.primaryAction_) {
      this.ripple_ = new MDCRipple(this.primaryAction_);
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
