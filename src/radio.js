import { MDCRadio } from "@material/radio/index";

class MdcRadio extends HTMLElement {

  constructor() {
    super();
  }

  connectedCallback() {
    this.MDCRadio = new MDCRadio(this);
    this.MDCRadio.checked = this.checked || false;
    this.MDCRadio.indeterminate = this.indeterminate || false;
    this.MDCRadio.disabled = this.disabled || false;
    this.MDCRadio.value = this.value || "";
  }

  disconnectedCallback() {
    if (typeof this.MDCRadio !== "undefined") {
      this.MDCRadio.destroy();
      delete this.MDCRadio;
    }
  }

  attributeChangedCallback(name, oldValue, newValue) {
    switch (name) {
      case "checked":
        if (typeof this.MDCRadio !== "undefined") {
          this.MDCRadio.checked = newValue;
        }
        break;
      case "indeterminate":
        if (typeof this.MDCRadio !== "undefined") {
          this.MDCRadio.indeterminate = newValue;
        }
        break;
      case "disabled":
        if (typeof this.MDCRadio !== "undefined") {
          this.MDCRadio.disabled = newValue;
        }
        break;
      case "value":
        if (typeof this.MDCRadio !== "undefined") {
          this.MDCRadio.value = newValue;
        }
        break;
    }
  }
};

customElements.define("mdc-radio", MdcRadio);
