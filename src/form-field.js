import { MDCFormField } from "@material/form-field/index";

class MdcFormField extends HTMLElement {

  constructor() {
    super();
  }

  connectedCallback() {
    this.MDCFormField = new MDCFormField(this);
  }

  disconnectedCallback() {
    if (typeof this.MDCFormField !== "undefined") {
      this.MDCFormField.destroy();
      delete this.MDCFormField;
    }
  }
};

customElements.define("mdc-form-field", MdcFormField);
