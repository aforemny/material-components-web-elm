import { MDCTopAppBar } from "@material/top-app-bar/index";

class MdcTopAppBar extends HTMLElement {

  constructor() {
    super();
  }

  connectedCallback() {
    this.mdcComponent = new MDCTopAppBar(this);
  }

  disconnectedCallback() {
    this.mdcComponent.destroy();
  }
};

customElements.define("mdc-top-app-bar", MdcTopAppBar);
