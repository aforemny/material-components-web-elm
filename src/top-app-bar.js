import { MDCTopAppBar } from "@material/top-app-bar/index";

class MdcTopAppBar extends HTMLElement {

  constructor() {
    super();
  }

  connectedCallback() {
    this.mdcComponent = new MDCTopAppBar(this);
  }

  disconnectedCallback() {
    if (typeof this.mdcComponent !== "undefined") {
      this.mdcComponent.destroy();
      delete this.mdcComponent;
    }
  }
};

customElements.define("mdc-top-app-bar", MdcTopAppBar);
