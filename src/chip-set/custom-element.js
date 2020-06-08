import { MDCChipSet } from "./component";

class MdcChipSet extends HTMLElement {
  constructor() {
    super();
  }

  connectedCallback() {
    this.chipset_ = new MDCChipSet(this);
  }

  disconnectedCallback() {
    this.chipset_.destroy();
  }
};

customElements.define("mdc-chip-set", MdcChipSet);
