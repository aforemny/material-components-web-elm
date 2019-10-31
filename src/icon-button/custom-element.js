import { MDCIconButtonToggle } from "./component";
import {
  installClassNameChangeHook,
  uninstallClassNameChangeHook,
} from "../utils/className";

class MdcIconButton extends HTMLElement {

  get on() {
    return this.on_;
  }

  set on(on) {
    this.on_ = on;
    if (!!this.iconButtonToggle_) {
      this.iconButtonToggle_.on = on;
    }
  }

  constructor() {
    super();
    this.on_ = false;
    this.iconButtonToggle_;
  }

  connectedCallback() {
    installClassNameChangeHook.call(this);
    this.iconButtonToggle_ = new MDCIconButtonToggle(this);
    this.iconButtonToggle_.on = this.on_;
  }

  disconnectedCallback() {
    this.iconButtonToggle_.destroy();
    uninstallClassNameChangeHook.call(this);
  }
};

customElements.define("mdc-icon-button", MdcIconButton);
