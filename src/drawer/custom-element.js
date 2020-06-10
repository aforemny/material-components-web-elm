import { MDCDrawer } from "./component";
import {
  installClassNameChangeHook,
  uninstallClassNameChangeHook,
} from "../utils/className";

class MdcDrawer extends HTMLElement {

  get open() {
    return this.open_;
  }

  set open(open) {
    this.open_ = open;
    if (!!this.drawer_) {
      this.drawer_.open = open;
    }
  }

  constructor() {
    super();
    this.open_ = false;
    this.drawer_;
  }

  connectedCallback() {
    installClassNameChangeHook.call(this);
    this.drawer_ = new MDCDrawer(this);
    this.drawer_.open = this.open_;
  }

  disconnectedCallback() {
    this.drawer_.destroy();
    uninstallClassNameChangeHook.call(this);
  }
};

customElements.define("mdc-drawer", MdcDrawer);
