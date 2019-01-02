import { MDCDialog } from "@material/dialog/index";

class MdcDialog extends HTMLElement {

  constructor() {
    super();
  }

  connectedCallback() {
    this.MDCDialog = new MDCDialog(this);
  }

  disconnectedCallback() {
    if (typeof this.MDCDialog !== "undefined") {
      this.MDCDialog.destroy();
      delete this.MDCDialog;
    }
  }
};

customElements.define("mdc-dialog", MdcDialog);
