import { MDCRipple } from "../ripple/component";
import {
  installClassNameChangeHook,
  uninstallClassNameChangeHook,
} from "../utils/className";

class MdcListItem extends HTMLElement {

  constructor() {
    super();
  }

  connectedCallback() {
    installClassNameChangeHook.call(this);
    if (this.classList.contains("mdc-list-item")) {
      this.ripple_ = new MDCRipple(this);
    } else {
      this.ripple_ = new MDCRipple(this.querySelector(".mdc-list-item"));
    }
  }

  disconnectedCallback() {
    this.ripple_.destroy();
    uninstallClassNameChangeHook.call(this);
  }
};

customElements.define("mdc-list-item", MdcListItem);
