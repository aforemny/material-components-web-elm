import { MDCSelect } from "@material/select/index";

class MdcSelect extends HTMLElement {

  constructor() {
    super();
  }

  connectedCallback() {
    this.MDCSelect = new MDCSelect(this);
  }

  disconnectedCallback() {
    if (typeof this.MDCSelect !== "undefined") {
      this.MDCSelect.destroy();
      delete this.MDCSelect;
    }
  }
};

customElements.define("mdc-select", MdcSelect);
