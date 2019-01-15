import { MDCDrawer } from "@material/drawer/index";

class MdcDrawer extends HTMLElement {

  constructor() {
    super();
  }

  connectedCallback() {
    this.MDCDrawer = new MDCDrawer(this);
  }

  disconnectedCallback() {
    if (typeof this.MDCDrawer !== "undefined") {
      this.MDCDrawer.destroy();
      delete this.MDCDrawer;
    }
  }
};

customElements.define("mdc-drawer", MdcDrawer);
