import { MDCCheckbox } from "@material/checkbox/index";

class MdcCheckbox extends HTMLElement {

  static get observedAttributes() {
    return [ "checked", "indeterminate", "disabled", "value" ];
  };

  get checked() {
    return this.hasAttribute("checked");
  }

  set checked(isChecked) {
    if (isChecked) {
      this.setAttribute("checked", "");
    } else {
      this.removeAttribute("checked");
    }
  }

  get indeterminate() {
    return this.hasAttribute("indeterminate");
  }

  set indeterminate(isIndeterminate) {
    if (isIndeterminate) {
      this.setAttribute("indeterminate", "");
    } else {
      this.removeAttribute("indeterminate");
    }
  }

  get disabled() {
    return this.hasAttribute("disabled");
  }

  set disabled(isDisabled) {
    if (isDisabled) {
      this.setAttribute("disabled", "");
    } else {
      this.removeAttribute("disabled");
    }
  }

  get value() {
    return this.getAttribute("value");
  }

  set value(newValue) {
    this.setAttribute("value", newValue);
  }

  constructor() {
    super();
  }

  connectedCallback() {
    this.MDCCheckbox = new MDCCheckbox(this);
    this.MDCCheckbox.checked = this.checked;
    this.MDCCheckbox.indeterminate = this.indeterminate;
    this.MDCCheckbox.disabled = this.disabled;
    this.MDCCheckbox.value = this.value;
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
          this.MDCCheckbox.checked = this.checked;
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
