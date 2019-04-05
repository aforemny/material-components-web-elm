import { MDCChipSet } from "@material/chips/index";

class MdcChipSet extends HTMLElement {

  constructor() {
    super();
  }

  connectedCallback() {
  }

  disconnectedCallback() {
  }
};

customElements.define("mdc-chip-set", MdcChipSet);
