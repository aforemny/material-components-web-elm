import { MDCRipple } from "../ripple/component";
import {
  installClassNameChangeHook,
  uninstallClassNameChangeHook,
} from "../utils/className";

export default class MdcButton extends HTMLElement {

  get disabled() {
    return this.disabled_;
  }

  set disabled(disabled) {
    this.disabled_ = disabled;
  }

  constructor() {
    super();
    this.ripple_;
  }

  connectedCallback() {
    this.style.display = "inline-flex";
    installClassNameChangeHook.call(this);
    this.ripple_ = new MDCRipple(this.querySelector(".mdc-button"));
  }

  disconnectedCallback() {
    this.ripple_.destroy();
    uninstallClassNameChangeHook.call(this);
  }
};

customElements.define("mdc-button", MdcButton);
