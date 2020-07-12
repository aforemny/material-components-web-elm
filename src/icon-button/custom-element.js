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
    const iconButton = this.querySelector(".mdc-icon-button");

    if (!!iconButton) {
      installClassNameChangeHook.call(iconButton);
      this.iconButtonToggle_ = new MDCIconButtonToggle(iconButton);
      this.iconButtonToggle_.on = this.on_;
    }
  }

  disconnectedCallback() {
    this.iconButtonToggle_.destroy();
    const iconButton = this.querySelector(".mdc-icon-button");
    if (!!iconButton) {
      uninstallClassNameChangeHook.call(iconButton);
    }

    uninstallClassNameChangeHook.call(this);
  }
};

customElements.define("mdc-icon-button", MdcIconButton);
