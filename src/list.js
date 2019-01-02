import { MDCList } from "@material/list/index";

class MdcList extends HTMLElement {

  constructor() {
    super();
  }

  connectedCallback() {
    this.MDCList = new MDCList(this);
    this.MDCList.checked = this.checked || false;
    this.MDCList.indeterminate = this.indeterminate || false;
    this.MDCList.disabled = this.disabled || false;
    this.MDCList.value = this.value || "";
  }

  disconnectedCallback() {
    if (typeof this.MDCList !== "undefined") {
      this.MDCList.destroy();
      delete this.MDCList;
    }
  }
};

customElements.define("mdc-list", MdcList);
