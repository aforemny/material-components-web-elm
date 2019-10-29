import { MDCChip } from "./component";
import {
  installClassNameChangeHook,
  uninstallClassNameChangeHook,
} from "../utils/className";

class MdcChip extends HTMLElement {

  get selected() {
    return this.selected_;
  }

  set selected(selected) {
    this.selected_ = selected;
    if (!!this.chip_) {
      this.chip_.selected = selected;
    }
  }

  constructor() {
    super();
    this.selected_ = false;
  }

  connectedCallback() {
    installClassNameChangeHook.call(this);
    this.chip_ = new MDCChip(this);
    this.chip_.selected = this.selected_;
  }

  disconnectedCallback() {
    this.chip_.destroy();
    uninstallClassNameChangeHook.call(this);
  }
};

customElements.define("mdc-chip", MdcChip);
