import { MDCTab } from "@material/tab/index";

class MdcTab extends HTMLElement {

  constructor() {
    super();
  }

  connectedCallback() {
    this.MDCTab = new MDCTab(this);
  }

  disconnectedCallback() {
    if (typeof this.MDCTab !== "undefined") {
      this.MDCTab.destroy();
      delete this.MDCTab;
    }
  }
};

customElements.define("mdc-tab", MdcTab);
