import { MDCCheckbox } from "@material/checkbox/index";

class MdcCheckbox extends HTMLElement {

  constructor() {
    super();
  }

  connectedCallback() {
    this.MDCCheckbox = new MDCCheckbox(this);
    this.MDCCheckbox.checked = this.checked || false;
    this.MDCCheckbox.indeterminate = this.indeterminate || false;
    this.MDCCheckbox.disabled = this.disabled || false;
    this.MDCCheckbox.value = this.value || "";
  }

  disconnectedCallback() {
    if (typeof this.MDCCheckbox !== "undefined") {
      this.MDCCheckbox.destroy();
      delete this.MDCCheckbox;
    }
  }

  attributeChangedCallback(name, oldValue, newValue) {
    switch (name) {
      case "checked":
        if (typeof this.MDCCheckbox !== "undefined") {
          this.MDCCheckbox.checked = newValue;
        }
        break;
      case "indeterminate":
        if (typeof this.MDCCheckbox !== "undefined") {
          this.MDCCheckbox.indeterminate = newValue;
        }
        break;
      case "disabled":
        if (typeof this.MDCCheckbox !== "undefined") {
          this.MDCCheckbox.disabled = newValue;
        }
        break;
      case "value":
        if (typeof this.MDCCheckbox !== "undefined") {
          this.MDCCheckbox.value = newValue;
        }
        break;
    }
  }
};

customElements.define("mdc-checkbox", MdcCheckbox);
