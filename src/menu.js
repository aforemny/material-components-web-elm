import { MDCMenu } from "@material/menu/index";

class MdcMenu extends HTMLElement {

  constructor() {
    super();
  }

  connectedCallback() {
    this.MDCMenu = new MDCMenu(this);
  }

  disconnectedCallback() {
    if (typeof this.MDCMenu !== "undefined") {
      this.MDCMenu.destroy();
      delete this.MDCMenu;
    }
  }
};

customElements.define("mdc-menu", MdcMenu);
