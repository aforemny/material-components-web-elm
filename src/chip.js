import { MDCChip } from "@material/chips/index";

class MdcChip extends HTMLElement {

  constructor() {
    super();
  }

  connectedCallback() {
    this.MDCChip = new MDCChip(this);
  }

  disconnectedCallback() {
    if (typeof this.MDCChip !== "undefined") {
      this.MDCChip.destroy();
      delete this.MDCChip;
    }
  }
};

customElements.define("mdc-chip", MdcChip);
