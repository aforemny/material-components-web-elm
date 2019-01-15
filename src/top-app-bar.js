import { MDCTopAppBar } from "@material/top-app-bar/index";

class MdcTopAppBar extends HTMLElement {

  constructor() {
    super();
  }

  connectedCallback() {
    this.MDCTopAppBar = new MDCTopAppBar(this);
  }

  disconnectedCallback() {
    if (typeof this.MDCTopAppBar !== "undefined") {
      this.MDCTopAppBar.destroy();
      delete this.MDCTopAppBar;
    }
  }
};

customElements.define("mdc-checkbox", MdcCheckbox);
