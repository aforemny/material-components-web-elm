import { MDCChipSet } from "@material/chips/index";

class MdcChipSet extends HTMLElement {

  constructor() {
    super();
  }

  connectedCallback() {
    //this.MDCChipSet = new MDCChipSet(this);
  }

  disconnectedCallback() {
    if (typeof this.MDCChipSet !== "undefined") {
      this.MDCChipSet.destroy();
      delete this.MDCChipSet;
    }
  }
};

customElements.define("mdc-chip-set", MdcChipSet);
