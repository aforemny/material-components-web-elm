import { MDCSwitch } from "@material/switch/index";

class MdcSwitch extends HTMLElement {

  constructor() {
    super();
  }

  connectedCallback() {
    this.MDCSwitch = new MDCSwitch(this);
    this.MDCSwitch.checked = this.checked || false;
    this.MDCSwitch.indeterminate = this.indeterminate || false;
    this.MDCSwitch.disabled = this.disabled || false;
    this.MDCSwitch.value = this.value || "";
  }

  disconnectedCallback() {
    if (typeof this.MDCSwitch !== "undefined") {
      this.MDCSwitch.destroy();
      delete this.MDCSwitch;
    }
  }

  attributeChangedCallback(name, oldValue, newValue) {
    switch (name) {
      case "checked":
        if (typeof this.MDCSwitch !== "undefined") {
          this.MDCSwitch.checked = newValue;
        }
        break;
      case "indeterminate":
        if (typeof this.MDCSwitch !== "undefined") {
          this.MDCSwitch.indeterminate = newValue;
        }
        break;
      case "disabled":
        if (typeof this.MDCSwitch !== "undefined") {
          this.MDCSwitch.disabled = newValue;
        }
        break;
      case "value":
        if (typeof this.MDCSwitch !== "undefined") {
          this.MDCSwitch.value = newValue;
        }
        break;
    }
  }
};

customElements.define("mdc-switch", MdcSwitch);
