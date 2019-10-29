import { MDCDialog } from "./component";
import {
  installClassNameChangeHook,
  uninstallClassNameChangeHook,
} from "../utils/className";

class MdcDialog extends HTMLElement {

  get open() {
    return this.open_;
  }

  set open(open) {
    this.open_ = open;
    if (!!this.dialog_) {
      if (open) {
        this.dialog_.open();
      } else {
        this.dialog_.close();
      }
    }
  }

  constructor() {
    super();
    this.open_ = false;
  }

  connectedCallback() {
    installClassNameChangeHook.call(this);
    this.dialog_ = new MDCDialog(this);
    if (this.open_) {
      this.dialog_.open();
    }
  }


  disconnectedCallback() {
    this.dialog_.destroy();
    uninstallClassNameChangeHook.call(this);
  }
};

customElements.define("mdc-dialog", MdcDialog);
