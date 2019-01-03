import { MDCTextField } from "@material/textfield/index";

class MdcTextField extends HTMLElement {

  constructor() {
    super();
  }

  connectedCallback() {
    this.MDCTextField = new MDCTextField(this);
  }

  disconnectedCallback() {
    if (typeof this.MDCTextField !== "undefined") {
      this.MDCTextField.destroy();
      delete this.MDCTextField;
    }
  }
};

customElements.define("mdc-text-field", MdcTextField);
