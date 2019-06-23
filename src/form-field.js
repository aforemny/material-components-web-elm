import { getClassName, setClassName } from "./utils";
import { MDCFormField } from "@material/form-field/index";

class MdcFormField extends HTMLElement {

  constructor() {
    super();
    this.className_ = "";
    this.formField_;
  }

  get className() {
    return getClassName.call(this);
  }

  set className(className) {
    setClassName.call(this, className);
  }

  connectedCallback() {
    this.formField_ = new MDCFormField(this);
    window.requestAnimationFrame(() => this.connectInput_());
  }

  connectInput_() {
    const input = this.getInput_();
    if (input) {
      this.formField_.input = input;
    }
  }

  getInput_() {
    const checkboxElement = this.querySelector("mdc-checkbox");
    if (checkboxElement) {
      return checkboxElement.input;
    }
    
    const radioElement = this.querySelector("mdc-radio");
    if (radioElement) {
      return radioElement.input;
    }
    
    const switchElement = this.querySelector("mdc-switch");
    if (switchElement) {
      return switchElement.input;
    }

    return false;
  }

  disconnectedCallback() {
    this.formField_.destroy();
  }
};

customElements.define("mdc-form-field", MdcFormField);
