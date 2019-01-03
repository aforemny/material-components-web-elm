import { MDCTabBar } from "@material/tab-bar/index";

class MdcTabBar extends HTMLElement {

  constructor() {
    super();
  }

  connectedCallback() {
    this.MDCTabBar = new MDCTabBar(this);
  }

  disconnectedCallback() {
    if (typeof this.MDCTabBar !== "undefined") {
      this.MDCTabBar.destroy();
      delete this.MDCTabBar;
    }
  }
};

customElements.define("mdc-tab-bar", MdcTabBar);
