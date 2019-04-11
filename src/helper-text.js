import { MDCTextFieldHelperText } from "@material/textfield/helper-text/index";

class MdcHelperText extends HTMLElement {

  constructor() {
    super();
  }

  connectedCallback() {
    this.MDCHelperText = new MDCTextFieldHelperText(this);
  }

  disconnectedCallback() {
    if (typeof this.MDCHelperText !== "undefined") {
      this.MDCHelperText.destroy();
      delete this.MDCHelperText;
    }
  }
};

customElements.define("mdc-helper-text", MdcHelperText);
