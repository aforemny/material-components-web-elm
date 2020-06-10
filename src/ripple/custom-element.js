import { MDCRipple } from "./component";
import {
  installClassNameChangeHook,
  uninstallClassNameChangeHook,
} from "../utils/className";

class MdcRipple extends HTMLElement {

  get unbounded() {
    return this.unbounded_;
  }

  set unbounded(unbounded) {
    this.unbounded_ = unbounded;
    if (!!this.ripple_) {
      this.ripple_.unbounded = unbounded;
    }
  }

  constructor() {
    super();
    this.unbounded_ = false;
    this.ripple_;
  }

  connectedCallback() {
    installClassNameChangeHook.call(this);
    this.ripple_ = new MDCRipple(this);
    this.ripple_.unbounded = this.unbounded_;
  }

  disconnectedCallback() {
    this.ripple_.destroy();
    uninstallClassNameChangeHook.call(this);
  }
};

customElements.define("mdc-ripple", MdcRipple);
