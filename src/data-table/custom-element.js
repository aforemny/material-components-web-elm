import { MDCDataTable } from "./component";

class MdcDataTable extends HTMLElement {

  constructor() {
    super();
    this.dataTable_;
  }

  connectedCallback() {
    this.dataTable_ = new MDCDataTable(this);
  }

  disconnectedCallback() {
    this.dataTable_.destroy();
  }
};

customElements.define("mdc-data-table", MdcDataTable);
