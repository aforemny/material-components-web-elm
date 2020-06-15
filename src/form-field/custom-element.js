import { MDCFormField } from "./component";

class MdcFormField extends HTMLElement {

  focus() {
    if (!!this.formField_.input) {
      this.formField_.input.focus();
    }
  }

  blur() {
    if (!!this.formField_.input) {
      this.formField_.input.blur();
    }
  }

  constructor() {
    super();
    this.formField_;
  }

  connectedCallback() {
    this.formField_ = new MDCFormField(this);
    const inputElement = this.querySelector("input");
    if (inputElement) {
      this.formField_.input = inputElement;
    }
  }

  disconnectedCallback() {
    this.formField_.destroy();
  }
};

customElements.define("mdc-form-field", MdcFormField);
