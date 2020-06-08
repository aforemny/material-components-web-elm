import { MDCChip } from "./component";
import {
  installClassNameChangeHook,
  uninstallClassNameChangeHook,
} from "../utils/className";

let idCounter = 0;

class MdcChip extends HTMLElement {

  get id() {
    return this.id_;
  }

  set id(id) {
    this.id_ = id;
  }

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
    this.id_ = `mdc-chip-${++idCounter}`;
    this.chipset_ = null;
  }

  connectedCallback() {
    this.chip_ = new MDCChip(this);
    this.chip_.selected = this.selected_;

    this.chipset_ = this.parentElement.parentElement.chipset_;
    this.chipset_.addChip(this);
  }

  disconnectedCallback() {
    this.chip_.destroy();
    this.chipset_.foundation_.adapter_.removeChipAtIndex(
      this.chipset_.findChipIndex_(this.id)
    );
    uninstallClassNameChangeHook.call(this);
  }
};

customElements.define("mdc-chip", MdcChip);
