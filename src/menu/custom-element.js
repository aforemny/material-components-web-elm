import { MDCMenu } from "./component";
import {
  installClassNameChangeHook,
  uninstallClassNameChangeHook,
} from "../utils/className";

class MdcMenu extends HTMLElement {

  get open() {
    return this.open_;
  }

  set open(open) {
    this.open_ = open;
    if (!!this.menu_) {
      this.menu_.open = open;
    }
  }

  get quickOpen() {
    return this.quickOpen_;
  }

  set quickOpen(quickOpen) {
    this.quickOpen_ = quickOpen;
    if (!!this.menu_) {
      this.menu_.quickOpen = quickOpen;
    }
  }

  constructor() {
    super();
    this.open_ = false;
    this.quickOpen_ = false;
    this.menu_;
  }

  connectedCallback() {
    installClassNameChangeHook.call(this);
    this.menu_ = new MDCMenu(this);
    this.menu_.open = this.open_;
    this.menu_.quickOpen = this.quickOpen_;
  }

  disconnectedCallback() {
    this.menu_.destroy();
    uninstallClassNameChangeHook.call(this);
  }
};

customElements.define("mdc-menu", MdcMenu);
