import { MDCIconToggle } from "@material/icon-toggle/index";

class MdcIconToggle extends HTMLElement {

  constructor() {
    super();
  }

  connectedCallback() {
    this.MDCIconToggle = new MDCIconToggle(this);
  }

  disconnectedCallback() {
    if (typeof this.MDCIconToggle !== "undefined") {
      this.MDCIconToggle.destroy();
      delete this.MDCIconToggle;
    }
  }
};

customElements.define("mdc-icon-toggle", MdcIconToggle);
