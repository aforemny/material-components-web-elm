import { MDCIconButton } from "@material/icon-button/index";

class MdcIconButton extends HTMLElement {

  constructor() {
    super();
  }

  connectedCallback() {
    this.MDCIconButton = new MDCIconButton(this);
  }

  disconnectedCallback() {
    if (typeof this.MDCIconButton !== "undefined") {
      this.MDCIconButton.destroy();
      delete this.MDCIconButton;
    }
  }
};

customElements.define("mdc-icon-button", MdcIconButton);
